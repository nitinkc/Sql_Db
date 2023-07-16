
-- JOINS (Two ways to write SQL queries):
-- #1. Using JOIN keyword between tables in FROM clause.
SELECT  T1.COLUMN1 AS C1, T1.COLUMN2 C2, T2.COLUMN3 AS C3    -- C1, C2, C3 are aliase to the column
  FROM  TABLE1    T1 JOIN  TABLE2 AS T2 
  ON T1.C1 = T2.C1 AND T1.C2 = T2.C2;    -- T1, T2 are aliases for table names.

-- #2. Using comma "," between tables in FROM clause -> use where instead of ON
SELECT  T1.COLUMN1 AS C1, T1.COLUMN2 AS C2, T2.COLUMN3 C3
  FROM  TABLE1 AS T1, TABLE2 AS T2
 WHERE  T1.C1 = T2.C1
   AND  T1.C2 = T2.C2;


-- Fetch all the class name where Music is thought as a subject.
SELECT CLASS_NAME
FROM SUBJECTS SUB
JOIN CLASSES CLS ON SUB.SUBJECT_ID = CLS.SUBJECT_ID
WHERE SUBJECT_NAME = 'Music';

-- Fetch the full name of all staff who teach Mathematics.
SELECT DISTINCT (STF.FIRST_NAME||' '||STF.LAST_NAME) AS FULL_NAME --, CLS.CLASS_NAME
FROM SUBJECTS SUB
JOIN CLASSES CLS ON CLS.SUBJECT_ID = SUB.SUBJECT_ID
JOIN STAFF STF ON CLS.TEACHER_ID = STF.STAFF_ID
WHERE SUB.SUBJECT_NAME = 'Mathematics';


-- Fetch all staff who teach grade 8, 9, 10 and also fetch all the non-teaching staff
-- UNION can be used to merge two differnt queries. UNION returns always unique records so any duplicate data while merging these queries will be eliminated.
-- UNION ALL displays all records including the duplicate records.
-- When using both UNION, UNION ALL operators, rememeber that noo of columns and their data type must match among the different queries.
SELECT STF.STAFF_TYPE
,    (STF.FIRST_NAME||' '||STF.LAST_NAME) AS FULL_NAME
,    STF.AGE
,    (CASE WHEN STF.GENDER = 'M' THEN 'Male'
           WHEN STF.GENDER = 'F' THEN 'Female'
      END) AS GENDER
,    STF.JOIN_DATE
FROM STAFF STF
JOIN CLASSES CLS ON STF.STAFF_ID = CLS.TEACHER_ID
WHERE STF.STAFF_TYPE = 'Teaching'
AND   CLS.CLASS_NAME IN ('Grade 8', 'Grade 9', 'Grade 10')
UNION ALL
SELECT STAFF_TYPE
,    (FIRST_NAME||' '||LAST_NAME) AS FULL_NAME, AGE
,    (CASE WHEN GENDER = 'M' THEN 'Male'
           WHEN GENDER = 'F' THEN 'Female'
      END) AS GENDER
,    JOIN_DATE
FROM STAFF
WHERE STAFF_TYPE = 'Non-Teaching';
