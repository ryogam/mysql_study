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


