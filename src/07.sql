select count(*) from users;
select count(*) from users where birthplace = '大分県';
select sum(price) from lineitems;
select max(age) from users where birthplace = '大分県';
select count(*),max(age),min(age) from users where birthplace = '大分県' and gender_id = 0;
select
    count(*) as 総数,
    max(age) as 最高齢,
    min(age) as 最年少,
    avg(age) as 平均年齢
from users
where birthplace = '大分県';

select sum(price) AS 大分県生まれ最高年齢購買合計金額
from lineitems
where order_id in
    (select id
     from orders
     where user_id in
         (select id
          from users
          where birthplace = '大分県'
            and age in
              (select max(age)
               from users
               where birthplace = '大分県')));

-- ・全顧客の最大の誕生日と最小の誕生日を取得
select 
    min(birthday),
    max(birthday)
from users;

/*
+----------+----------+
| min(age) | max(age) |
+----------+----------+
|       20 |       59 |
+----------+----------+
1 row in set (0.01 sec)
*/


-- ・1980年代生まれの方の注文合計数を取得

select count(*)
from lineitems
where id in
    (
    select id
    from users
    where birthday like "198%"
    );

/*
+----------+
| count(*) |
+----------+
|      341 |
+----------+
1 row in set (0.00 sec)
*/

-- ・20代の方の購買合計金額を取得
select sum(price)
from lineitems
where id in 
    (select id
    from users
    where age between 20 and 29);
/*
+------------+
| sum(price) |
+------------+
|     981500 |
+------------+
1 row in set (0.00 sec)
*/