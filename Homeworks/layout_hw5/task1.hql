ADD JAR /opt/cloudera/parcels/CDH/lib/hive/lib/hive-serde.jar;
USE mf_dzyatko;
DROP TABLE IF EXISTS logs_optimized;
CREATE EXTERNAL TABLE logs_optimized (
ip STRING,
timestamp STRING,
request STRING,
size INT,
response_code INT,
useragent STRING
)
PARTITIONED BY (date STRING)
STORED AS orc
    TBLPROPERTIES ("orc.compress" = "ZLIB");

set hive.exec.max.dynamic.partitions.pernode=116;
set hive.exec.dynamic.partition.mode=nonstrict;

INSERT OVERWRITE TABLE logs_optimized PARTITION(date)
SELECT ip,timestamp, request, size,response_code, useragent
,  date
from logs;"