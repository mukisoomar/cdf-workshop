set hive.cli.errors.ignore=true;

CREATE DATABASE IF NOT EXISTS clickstream;
USE clickstream;

DROP TABLE IF EXISTS users;
CREATE EXTERNAL TABLE IF NOT EXISTS users 
(swid string, birth_dt string, gender_cd string) 
ROW FORMAT DELIMITED FIELDS TERMINATED BY '\t' STORED AS TEXTFILE 
LOCATION "/workshop/clickstream/data/users";

DROP TABLE IF EXISTS users_orc;
CREATE TABLE IF NOT EXISTS users_orc as
SELECT * FROM users;

DROP TABLE IF EXISTS products_orc;
CREATE TABLE IF NOT EXISTS products_orc as
SELECT * FROM products;

DROP TABLE IF EXISTS products;
CREATE EXTERNAL TABLE IF NOT EXISTS products
(url string, category string, description string) 
ROW FORMAT DELIMITED FIELDS TERMINATED BY '\t' STORED AS TEXTFILE 
LOCATION "/workshop/clickstream/data/products";

DROP TABLE IF EXISTS weblogs;
CREATE EXTERNAL TABLE IF NOT EXISTS weblogs (
	id double,
	ts string, 
	ip string, 
	url string, 
	purchase_flag int,  
	error_flag int, 
	swid string, 
	city string, 
	state string, 
	country string 
	) 
ROW FORMAT DELIMITED FIELDS TERMINATED BY '|' STORED AS TEXTFILE
LOCATION "/workshop/clickstream/data/cleansed/";

DROP TABLE IF EXISTS omniture_raw;
CREATE EXTERNAL TABLE IF NOT EXISTS omniture_raw (
	id double, 
	ts string, 
	id1 string, 
	id2 string,
	ip string,
	url string,  
	swid string, 
	city string, 
	state string, 
	country string
  ) 
ROW FORMAT DELIMITED FIELDS TERMINATED BY '|' STORED AS TEXTFILE
LOCATION "/workshop/clickstream/data/raw/";

DROP TABLE IF EXISTS omniture_raw_orc;
CREATE TABLE IF EXISTS omniture_raw_orc STORED AS ORC AS
SELECT id, tx, id1, id2, ip, regexp_replace(url,"http://www.acme.com","") as url, 
swid, city, state, country from omniture_raw;


drop view purchased_sessions;
create view purchased_sessions as
  select 
    id, ts, ip, url, swid, city, state, country
  from
    weblogs w
  where
    swid in (select distinct(swid) from weblogs l where l.purchase_flag=1);
