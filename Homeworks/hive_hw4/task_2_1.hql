ADD JAR /opt/cloudera/parcels/CDH/lib/hive/lib/hive-serde.jar;
USE mf_dzyatko; 
SELECT date, count(*) as cnt
from logs 
group by date
order by cnt desc
limit 10;
