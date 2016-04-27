## JOIN
### INNER JOIN

```sql
 SELECT l.*
 FROM lineitems AS l
 INNER JOIN orders AS o ON o.id = l.order_id
 INNER JOIN users AS u ON u.id = o.user_id
 WHERE u.name = '藤本美代';
```

### AND演算子

```sql
select l.id, l.item_name
from lineitems as l,
     orders as o,
     users as u
where u.name = '藤本美代'
and l.order_id = o.id
and u.id = o.user_id;
```

#### INNER JOINがやっていること
両テーブルともレコードがある場合のみ表示

#### OUTER JOINがやっていること
一方さえあればレコード表示


```sql
SELECT u.name_kana,
       l.id
FROM users AS u
LEFT OUTER JOIN orders AS o ON u.id = o.user_id
LEFT OUTER JOIN lineitems AS l ON o.id = l.order_id
WHERE u.id = 1000;
```

```
+--------------------+------+
| name_kana          | id   |
+--------------------+------+
| タンバユウジ         | NULL |
+--------------------+------+
```

### 例題：名前：合計購入金額表を出す

#### WHERE

```sql

      select u.name,t_p.p as sum_p from
      users as u,
      (select sum(l.price) as p,o.user_id as uid
      from lineitems as l,orders as o
      where l.order_id = o.id group by uid ) AS t_p where t_p.uid = u.id;
```


#### JOIN
以上と一緒
(中のinner JOINと別にLEFT JOINを使うと遅い)
```sql
      SELECT users.name,
        sum_prices.sum_price
        FROM users
        INNER JOIN
        (SELECT orders.user_id,
            sum(price) AS sum_price
            FROM orders
            inner JOIN lineitems ON orders.id = lineitems.order_id
            GROUP BY orders.user_id) AS sum_prices ON users.id = sum_prices.user_id ;
```
