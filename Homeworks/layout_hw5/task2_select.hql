    
USE mf_dzyatko;
set hive.auto.convert.join=true;
set mapreduce.job.reduces=16;

--SELECT
--    logs.useragent,
--    SUM(IF(gender = 'male',1,0)) as male_count,
--    SUM(IF(gender = 'female',1,0)) as female_count
--FROM logs_S logs
--JOIN users_S on users_S.ip = logs.ip
--GROUP BY logs.useragent
--LIMIT 10;

SELECT
    logs.useragent,
    SUM(IF(gender = 'male',1,0)) as male_count,
    SUM(IF(gender = 'female',1,0)) as female_count
FROM logs_optimized_S logs
JOIN users_S on users_S.ip = logs.ip
GROUP BY logs.useragent
LIMIT 10;

--SELECT
--    logs.useragent,
--    SUM(IF(gender = 'male',1,0)) as male_count,
--    SUM(IF(gender = 'female',1,0)) as female_count
--FROM logs_M logs
--JOIN users on users.ip = logs.ip
--GROUP BY logs.useragent
--LIMIT 10;
--
--SELECT
--    logs.useragent,
--    SUM(IF(gender = 'male',1,0)) as male_count,
--    SUM(IF(gender = 'female',1,0)) as female_count
--FROM logs_optimized_M logs
--JOIN users on users.ip = logs.ip
--GROUP BY logs.useragent
--LIMIT 10;

--SELECT
--    logs.useragent,
--    SUM(IF(gender = 'male',1,0)) as male_count,
--    SUM(IF(gender = 'female',1,0)) as female_count
--FROM logs logs
--JOIN users on users.ip = logs.ip
--GROUP BY logs.useragent
--LIMIT 10;
--
--SELECT
--    logs.useragent,
--    SUM(IF(gender = 'male',1,0)) as male_count,
--    SUM(IF(gender = 'female',1,0)) as female_count
--FROM logs_optimized logs
--JOIN users on users.ip = logs.ip
--GROUP BY logs.useragent
--LIMIT 10;
