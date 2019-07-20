ADD JAR /opt/cloudera/parcels/CDH/lib/hive/lib/hive-serde.jar;
USE mf_dzyatko; 
set hive.auto.convert.join=true;
set mapreduce.job.reduces=8;
SELECT 
    region,
	SUM(IF(gender = 'male',1,0)) as male_count,
	SUM(IF(gender = 'female',1,0)) as female_count
from logs 
join ip_regions on ip_regions.ip = logs.ip
join users on users.ip = logs.ip
group by region
limit 10;
