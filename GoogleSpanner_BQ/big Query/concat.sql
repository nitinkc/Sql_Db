BEGIN
	create temp table test as
		WITH temp_table AS(
			SELECT "1" as STR_VALUE, cast('2022-10-01T10:00:00+01:00'as timestamp) as STR_DATE, 1 as INT_VAL UNION ALL
			SELECT "abc", '2022-10-01',5  UNION ALL
			SELECT null,null,null
			)
	select * from temp_table;

END;

SELECT LPAD(CAST(STR_VALUE AS STRING), 5, '0') AS CODE,--Left Padding
STR_DATE || ' CONCATE ' || INT_VAL as CONCAT_WITH_PIPE,
concat(STR_DATE, ' CONCATE ', INT_VAL) as CONCAT_WITH_CONCAT,
FROM test;