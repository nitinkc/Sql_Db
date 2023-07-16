WITH i_temp_table_emp AS(
SELECT "ht" as STR_VALUE, cast('2022-10-01T10:00:00+01:00' as timestamp) as STR_DATE
UNION ALL
SELECT "hhd" as STR_VALUE, null as STR_DATE
	)

SELECT
	CASE 
		WHEN UPPER(STR_VALUE) LIKE UPPER('%ht%') THEN 'Hubble Telescope'
		WHEN STR_VALUE IS NULL THEN "N/A"
	END as result
	,if(UPPER(STR_VALUE) LIKE '%ISS%', 'International Space Station', "not matching") 
	 AS COLLECTION_TYPE
from
	i_temp_table_emp