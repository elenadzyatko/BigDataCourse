ADD JAR /opt/cloudera/parcels/CDH/lib/hive/lib/hive-serde.jar;
USE mf_dzyatko;
set hive.exec.max.dynamic.partitions.pernode=116;
set hive.exec.dynamic.partition.mode=nonstrict;



DROP TABLE IF EXISTS logs_optimized_bucket_S;
CREATE EXTERNAL TABLE logs_optimized_bucket_S (
ip STRING,
timestamp STRING,
request STRING,
size INT,
response_code INT,
useragent STRING
)
PARTITIONED BY (date STRING)
CLUSTERED BY(ip) INTO 128 BUCKETS
STORED AS orc
    TBLPROPERTIES ("orc.compress"="ZLIB");

INSERT OVERWRITE TABLE logs_optimized_bucket_S PARTITION(date)
SELECT ip, timestamp, request, size, response_code, useragent, date
from logs_optimized_S;


--DROP TABLE IF EXISTS logs_optimized_bucket_M;
--CREATE EXTERNAL TABLE logs_optimized_bucketed_M (
--ip STRING,
--ts STRING,
--request STRING,
--size INT,
--response_code INT,
--useragent STRING
--)
--PARTITIONED BY (date STRING)
--CLUSTERED BY(ip) INTO 256 BUCKETS
--STORED AS orc
--    TBLPROPERTIES ("orc.compress"="ZLIB");
--
--INSERT OVERWRITE TABLE logs_optimized_bucketed_M PARTITION(date)
--SELECT ip, ts, request, size, response_code, useragent, date
--from logs_optimized_M;
--
--
--DROP TABLE IF EXISTS logs_optimized_bucketed_full;
--CREATE EXTERNAL TABLE logs_optimized_bucketed_full (
--ip STRING,
--ts STRING,
--request STRING,
--size INT,
--response_code INT,
--useragent STRING
--)
--PARTITIONED BY (date STRING)
--CLUSTERED BY(ip) INTO 256 BUCKETS
--STORED AS orc
--    TBLPROPERTIES ("orc.compress"="ZLIB");
--
--INSERT OVERWRITE TABLE logs_optimized_bucketed_full PARTITION(date)
--SELECT ip, ts, request, size, response_code, useragent, date
--from logs_optimized_full;