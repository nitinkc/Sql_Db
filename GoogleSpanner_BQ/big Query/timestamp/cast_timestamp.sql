WITH i_temp_table_lab AS(
	SELECT "Test" as STR_VALUE, cast('2022-10-01T10:00:00+01:00'as timestamp) as STR_DATE, 1 as INT_VAL
  UNION ALL
  SELECT null as STR_VALUE, null as STR_DATE, null as INT_VAL
	 UNION ALL
	SELECT "Test" as STR_VALUE, cast('2022-10-01T10:00:00+01:00'as timestamp) as STR_DATE, 0 as INT_VAL
	 UNION ALL
	SELECT "Test" as STR_VALUE, cast('2022-10-01T10:00:00+01:00'as timestamp) as STR_DATE, 2 as INT_VAL
	 UNION ALL
	SELECT "Test" as STR_VALUE, cast('2022-10-01T10:00:00+01:00'as timestamp) as STR_DATE, null as INT_VAL
	 UNION ALL
	SELECT "Test" as STR_VALUE, cast('2022-10-01T10:00:00+01:00'as timestamp) as STR_DATE, -1 as INT_VAL
	)

-- If String Value is Null, show N/A
SELECT
 IF (STR_VALUE IS NULL, 'N/A', STR_VALUE) AS strValue,
 STR_DATE,
 INT_VAL
from i_temp_table_lab l;