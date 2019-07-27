ADD JAR /opt/cloudera/parcels/CDH/lib/hive/lib/hive-serde.jar;
USE mf_dzyatko;
DROP TABLE IF EXISTS logs_raw;
CREATE EXTERNAL TABLE logs_raw (
ip STRING,
timestamp STRING,
request STRING,
size INT,
response_code INT,
useragent STRING
)
ROW FORMAT
serde 'org.apache.hadoop.hive.serde2.RegexSerDe'
with serdeproperties (
"input.regex" = "^(\\S*)\\t\\t\\t(\\S*)\\t(\\S*)\\t(\\d*)\\t(\\d*)\\t(\\S*).*"
)
STORED AS textfile
LOCATION '/data/user_logs/user_logs';

DROP TABLE IF EXISTS logs;
CREATE EXTERNAL TABLE logs (
ip STRING,
timestamp STRING,
request STRING,
size INT,
response_code INT,
useragent STRING
)
PARTITIONED BY (date STRING);

set hive.exec.max.dynamic.partitions.pernode=116;
set hive.exec.dynamic.partition.mode=nonstrict;

INSERT OVERWRITE TABLE logs PARTITION(date)
SELECT ip,timestamp, request, size,response_code, useragent, substr(timestamp, 1,8) AS date
from logs_raw;

DROP TABLE IF EXISTS logs_raw_M;
CREATE EXTERNAL TABLE logs_raw_M (
ip STRING,
timestamp STRING,
request STRING,
size INT,
response_code INT,
useragent STRING
)
ROW FORMAT
serde 'org.apache.hadoop.hive.serde2.RegexSerDe'
with serdeproperties (
"input.regex" = "^(\\S*)\\t\\t\\t(\\S*)\\t(\\S*)\\t(\\d*)\\t(\\d*)\\t(\\S*).*"
)
STORED AS textfile
LOCATION '/data/user_logs/user_logs_M';

DROP TABLE IF EXISTS logs_M;
CREATE EXTERNAL TABLE logs_M (
ip STRING,
timestamp STRING,
request STRING,
size INT,
response_code INT,
useragent STRING
)
PARTITIONED BY (date STRING);

set hive.exec.max.dynamic.partitions.pernode=116;
set hive.exec.dynamic.partition.mode=nonstrict;

INSERT OVERWRITE TABLE logs PARTITION(date)
SELECT ip,timestamp, request, size,response_code, useragent, substr(timestamp, 1,8) AS date
from logs_raw_M;

DROP TABLE IF EXISTS logs_raw_S;
CREATE EXTERNAL TABLE logs_raw_S (
ip STRING,
timestamp STRING,
request STRING,
size INT,
response_code INT,
useragent STRING
)
ROW FORMAT
serde 'org.apache.hadoop.hive.serde2.RegexSerDe'
with serdeproperties (
"input.regex" = "^(\\S*)\\t\\t\\t(\\S*)\\t(\\S*)\\t(\\d*)\\t(\\d*)\\t(\\S*).*"
)
STORED AS textfile
LOCATION '/data/user_logs/user_logs_S';

DROP TABLE IF EXISTS logs_S;
CREATE EXTERNAL TABLE logs_S (
ip STRING,
timestamp STRING,
request STRING,
size INT,
response_code INT,
useragent STRING
)
PARTITIONED BY (date STRING);

set hive.exec.max.dynamic.partitions.pernode=116;
set hive.exec.dynamic.partition.mode=nonstrict;

INSERT OVERWRITE TABLE logs PARTITION(date)
SELECT ip,timestamp, request, size,response_code, useragent, substr(timestamp, 1,8) AS date
from logs_raw_S;


