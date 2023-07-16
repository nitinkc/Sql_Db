BEGIN

	create temp table temp_table as
		WITH temp_table AS(
			SELECT "1" as STR_VALUE, cast('2022-10-01T10:00:00+01:00'as timestamp) as STR_DATE, 1 as INT_VAL UNION ALL
			SELECT "abc", '2022-10-01',5  UNION ALL
			SELECT null,null,null
			)
	select * from temp_table;
END;


-- Safe cast function takes care of any errors. Instead, it sends null. Also, it handle nulls
SELECT SAFE_CAST(STR_DATE AS timestamp) AS not_a_number 
from temp_table;


-- Safe cast function takes care of any errors. Instead, it sends null 
SELECT SAFE_CAST(STR_VALUE AS INT64) AS not_a_number 
from temp_table;

SELECT 
	CAST(STR_VALUE AS INT64) AS not_a_number  --This will error out (Bad int64 value: abc) as STR_VALUE column will return a string that cant be converted to a Number
from temp_table;