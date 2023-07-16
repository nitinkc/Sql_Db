BEGIN 

	create temp table timeStr as
		WITH a AS
		( SELECT "Test" AS STR_VALUE, '2022-10-01T10:00:00+01:00' AS STR_DATE,1 AS INT_VAL)
	select * from a;	

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

END;

-- Safecast string date as timestamp
SELECT
		IF (STR_VALUE IS NULL, 'N/A', CAST(STR_VALUE AS STRING)) AS strValue
		,FORMAT_TIMESTAMP('%m/%d/%Y', safe_cast(STR_DATE AS TIMESTAMP)) as strCollectionDate
		,IF (INT_VAL IS NULL, 'N/A', CAST(INT_VAL AS STRING)) AS intVal
	from timeStr
	limit 1;
--------------

-- Show Date in MM/DD/YYYY format, N/A when date is null
SELECT
 STR_VALUE,
 if(STR_DATE is null,"N/A",CAST(FORMAT_TIMESTAMP('%m/%d/%Y', safe_cast(STR_DATE AS TIMESTAMP)) as STRING)) as strCollectionDate,
 INT_VAL
from timeTs l;

SELECT FORMAT_TIMESTAMP('%m/%d/%Y  %H:%M %Z %z', CURRENT_TIMESTAMP()) AS generatedDateTime;

