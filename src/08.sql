select distinct(prefectural) FROM orders;

select count(*), prefectural from orders group by prefectural;

select count(*), age
    from users
    where age is not null
    group by age
    order by age;

select 
    max(age),
    min(age), 
    birthplace, 
    (case
        when gender_id = 0 then '男性'
        else '女性'
    end) as gender
from users 
where age is not null 
group by birthplace, gender_id 
order by birthplace, gender_id;

select count(*) as 人数,
       age as 年齢
from users
where age is not null
group by age
having count(*) >= 25
order by age;

select count(*), avg(age), birthplace 
from users 
where age is not null 
group by birthplace 
having avg(age) >= 25
order by avg(age) desc;

-- ・血液型ごとにそれぞれ何人いるか情報を取得
select count(*),
    blood_type
from users
where blood_type is not null
group by blood_type;

-- ・県ごとに最高齢と最年少の年齢差の情報を取得し、その差順に並べる
select max(age) - min(age) as 年齢差,
    birthplace 
from users
where age is not null
group by birthplace
order by 年齢差;