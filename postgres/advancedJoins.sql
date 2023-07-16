/*
SQL Joins: There are several types of JOIN but we look at the most commonly used:
1) Inner Join
    - Inner joins fetches records when there are matching values in both tables.
2) Outer Join
    - Left Outer Join
        - Left join fetches all records from left table and the matching records from right table.
        - The count of the query will be the count of the Left table.
        - Columns which are fetched from right table and do not have a match will be passed as NULL.
    - Right Outer Join
        - Right join fetches all records from right table and the matching records from left table.
        - The count of the query will be the count of the right table.
        - Columns which are fetched from left table and do not have a match will be passed as NULL.
    - Full Outer Join
        - Full join always return the matching and non-matching records from both left and right table.
*/

-- Inner Join: 21 records returned – Inner join always fetches only the matching records present in both right and left table.
-- Inner Join can be represented as eithe "JOIN" or as "INNER JOIN". Both are correct and mean the same.
SELECT COUNT(1)
FROM STAFF STF
JOIN STAFF_SALARY SS ON SS.STAFF_ID = STF.STAFF_ID
ORDER BY 1;

SELECT DISTINCT (STF.FIRST_NAME||' '||STF.LAST_NAME) AS FULL_NAME, SS.SALARY
FROM STAFF STF
JOIN STAFF_SALARY SS ON SS.STAFF_ID = STF.STAFF_ID
ORDER BY 2;


-- 23 records – 23 records present in left table.
-- All records from LEFT table with be fetched irrespective of whether there is matching record in the RIGHT table.
SELECT COUNT(1)
FROM STAFF STF
LEFT JOIN STAFF_SALARY SS ON SS.STAFF_ID = STF.STAFF_ID
ORDER BY 1;

SELECT DISTINCT (STF.FIRST_NAME||' '||STF.LAST_NAME) AS FULL_NAME, SS.SALARY
FROM STAFF STF
LEFT JOIN STAFF_SALARY SS ON SS.STAFF_ID = STF.STAFF_ID
ORDER BY 2;


-- 24 records – 24 records in right table.
-- All records from RIGHT table with be fetched irrespective of whether there is matching record in the LEFT table.
SELECT COUNT(1)
FROM STAFF STF
RIGHT JOIN STAFF_SALARY SS ON SS.STAFF_ID = STF.STAFF_ID
ORDER BY 1;

SELECT DISTINCT (STF.FIRST_NAME||' '||STF.LAST_NAME) AS FULL_NAME, SS.SALARY
FROM STAFF STF
RIGHT JOIN STAFF_SALARY SS ON SS.STAFF_ID = STF.STAFF_ID
ORDER BY 1;


-- 26 records – all records from both tables. 21 matching records + 2 records from left + 3 from right table.
-- All records from both LEFT and RIGHT table with be fetched irrespective of whether there is matching record in both these tables.
SELECT COUNT(1)
FROM STAFF STF
FULL OUTER JOIN STAFF_SALARY SS ON SS.STAFF_ID = STF.STAFF_ID
ORDER BY 1;

SELECT DISTINCT (STF.FIRST_NAME||' '||STF.LAST_NAME) AS FULL_NAME, SS.SALARY
FROM STAFF STF
FULL OUTER JOIN STAFF_SALARY SS ON SS.STAFF_ID = STF.STAFF_ID
ORDER BY 1,2;
