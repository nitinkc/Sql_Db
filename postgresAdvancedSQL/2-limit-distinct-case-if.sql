SELECT STAFF_TYPE FROM STAFF ; -- Returns lot of duplicate data.
SELECT DISTINCT STAFF_TYPE FROM STAFF ; -- Returns unique values only.


SELECT STAFF_TYPE FROM STAFF LIMIT 5; -- Fetches only the first 5 records from the result.

-- CASE statement:  (IF 1 then print True ; IF 0 then print FALSE ; ELSE print -1)
SELECT STAFF_ID, SALARY
, CASE WHEN SALARY >= 10000 THEN 'High Salary'
       WHEN SALARY BETWEEN 5000 AND 10000 THEN 'Average Salary'
       WHEN SALARY < 5000 THEN 'Too Low'
  END AS RANGE
FROM STAFF_SALARY
ORDER BY 2 DESC;

-- Test with If statement, if it exists
-- https://www.postgresql.org/docs/9.1/functions-conditional.html
-- The SQL CASE expression is a generic conditional expression, similar to if/else statements in other programming languages:

SELECT STAFF_ID, SALARY,
	if (s.SALARY >= 10000) THEN 
	 'High Salary'
	elseif (s.SALARY BETWEEN 5000 AND 10000) THEN 
	'Average Salary'
	else (s.SALARY < 5000) THEN 
	'Too Low'
	end as hhh
FROM STAFF_SALARY s
ORDER BY 2 DESC;