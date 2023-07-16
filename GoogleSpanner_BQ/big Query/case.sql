begin
create temp table timeTs as
	WITH a AS
	(
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
select * from a;

end;


-- If String Value is Null, show N/A
SELECT
 IF (STR_VALUE IS NULL, 'N/A', STR_VALUE) AS strValue,
 STR_DATE,
 INT_VAL
from timeTs l;

-- If Integer Value is 1 show "YES", if 0 show "NO", if null show "-" and else show N/A
SELECT
 STR_VALUE,
 STR_DATE,
 CASE
			WHEN INT_VAL IS NULL THEN '-'
			WHEN CAST(INT_VAL AS STRING) = '1' THEN 'YES'
			WHEN CAST(INT_VAL AS STRING) = '0' THEN 'NO'
			ELSE 'N/A'
	END AS INT_VAL,
from timeTs l;

--safe cast
