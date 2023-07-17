SET search_path TO student, public;
SHOW search_path;

-- Count no of students in each class
SELECT SC.CLASS_ID, COUNT(1) AS "no_of_students"
FROM mydb.student.STUDENT_CLASSES SC
GROUP BY SC.CLASS_ID
ORDER BY SC.CLASS_ID;

-- Return only the records where there are more than 100 students in each class
SELECT SC.CLASS_ID, COUNT(1) AS "no_of_students"
FROM STUDENT_CLASSES SC
GROUP BY SC.CLASS_ID
HAVING COUNT(1) > 100
ORDER BY SC.CLASS_ID;

-- Parents with more than 1 kid in school.
SELECT PARENT_ID, COUNT(1) AS "no_of_kids"
FROM STUDENT_PARENT SP
GROUP BY PARENT_ID
HAVING COUNT(1) > 1;



--Aggregate Functions (AVG, MIN, MAX, SUM, COUNT): Aggregate functions are used to perform calculations on a set of values.
-- AVG: Calculates the average of the given values.
SELECT AVG(SS.SALARY)::NUMERIC(10,2) AS AVG_SALARY
FROM STAFF_SALARY SS
JOIN STAFF STF ON STF.STAFF_ID = SS.STAFF_ID
WHERE STF.STAFF_TYPE = 'Teaching';

SELECT STF.STAFF_TYPE, AVG(SS.SALARY)::NUMERIC(10,2) AS AVG_SALARY
FROM STAFF_SALARY SS
JOIN STAFF STF ON STF.STAFF_ID = SS.STAFF_ID
GROUP BY STF.STAFF_TYPE;

/* Note:
“::NUMERIC” is a cast operator which is used to convert values from one data type to another.
In the above query we use it display numeric value more cleanly by restricting the decimal point to only 2.
Here 10 is precision which is the total no of digits allowed.
2 is the scale which is the digits after decimal point.
*/

-- SUM: Calculates the total sum of all values in the given column.
SELECT STF.STAFF_TYPE, SUM(SS.SALARY)::NUMERIC(10,2) AS AVG_SALARY
FROM STAFF_SALARY SS
JOIN STAFF STF ON STF.STAFF_ID = SS.STAFF_ID
GROUP BY STF.STAFF_TYPE;

-- MIN: Returns the record with minimun value in the given column.
SELECT STF.STAFF_TYPE, MIN(SS.SALARY)::NUMERIC(10,2) AS AVG_SALARY
FROM STAFF_SALARY SS
JOIN STAFF STF ON STF.STAFF_ID = SS.STAFF_ID
GROUP BY STF.STAFF_TYPE;

-- MAX: Returns the record with maximum value in the given column.
SELECT STF.STAFF_TYPE, MAX(SS.SALARY)::NUMERIC(10,2) AS AVG_SALARY
FROM STAFF_SALARY SS
JOIN STAFF STF ON STF.STAFF_ID = SS.STAFF_ID
GROUP BY STF.STAFF_TYPE;