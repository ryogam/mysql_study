# set up

- install Home brew

```
/usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"

```

参考: http://brew.sh/index_ja.html


- mysql install 

```
brew update
brew install mysql
```



- mysql start

```
mysql.server start
```


- insert test data

```
mysql -u root
CREATE DATABASE mysql_study;
exit;
mysql -u root -h localhost --default-character-set=utf8 mysql_study < data/mysql_study.backup
```


- check test data


```
mysql -u root
SHOW DATABASES;
USE mysql_study;
SHOW TABLES;
SELECT * FROM areas;
SELECT * FROM genders;
SELECT * FROM lineitems;
SELECT * FROM orders;
SELECT * FROM prefectures;
SELECT * FROM users;
```

# 分析SQLのコーディングスタイル
https://techlife.cookpad.com/entry/2016/11/09/000033

```
select
    user_id
    , user_session_id
    , min(log_time) as session_start_time
    , max(log_time) as session_end_time
    , count(*) as num_steps
    , max(case session_step when 1 then keywords else null end) as step1
    , max(case session_step when 2 then keywords else null end) as step2
    , max(case session_step when 3 then keywords else null end) as step3
    , max(case session_step when 4 then keywords else null end) as step4
    , max(case session_step when 5 then keywords else null end) as step5
    , max(case session_step when 6 then keywords else null end) as step6
    , max(case session_step when 7 then keywords else null end) as step7
    , max(case session_step when 8 then keywords else null end) as step8
from (
    select
        user_id
        , user_session_id
        , row_number() over (
              partition by user_id, user_session_id
              order by log_time
          ) as session_step
        , log_time
        , keywords
    from (
        select
            user_id
            , sum(session_delta) over (
                  partition by user_id
                  order by log_time
                  rows between unbounded preceding and current row
              ) as user_session_id
            , log_time
            , keywords
        from (
            select
                user_id
                , case
                  when
                    lag(log_time) over (partition by user_id order by log_time) is null
                    or log_time > lag(log_time) over (partition by user_id order by log_time) + interval '00:30'
                  then 1 else 0 end as session_delta
                , log_time
                , trim(word1
                      ||' '|| coalesce(word2,'')
                      ||' '|| coalesce(word3,'')
                      ||' '|| coalesce(word4,'')
                      ||' '|| coalesce(word5,'')
                      ||' '|| coalesce(word6,'')
                  ) as keywords
            from
                activity.search_log
            where
                log_time between timestamp '2015-02-01 00:00:00' and timestamp '2015-02-01 01:00:00'
        )
    )
)
group by user_id, user_session_id
order by user_id, user_session_id
;
```
