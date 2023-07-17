SET search_path TO student, public;
SHOW search_path;

--SUBQUERY: Query written inside a query is called subquery.
-- Fetch the details of parents having more than 1 kids going to this school. Also display student details.
SELECT (P.FIRST_NAME||' '||P.LAST_NAME) AS PARENT_NAME
,    (S.FIRST_NAME||' '||S.LAST_NAME) AS STUDENT_NAME
,    S.AGE AS STUDENT_AGE
,    S.GENDER AS STUDENT_GENDER
,    (ADR.STREET||', '||ADR.CITY||', '||ADR.STATE||', '||ADR.COUNTRY) AS ADDRESS
FROM PARENTS P
JOIN STUDENT_PARENT SP ON P.ID = SP.PARENT_ID
JOIN STUDENTS S ON S.ID = SP.STUDENT_ID
JOIN ADDRESS ADR ON P.ADDRESS_ID = ADR.ADDRESS_ID
WHERE P.ID IN (  SELECT PARENT_ID
                   FROM STUDENT_PARENT SP
               GROUP BY PARENT_ID
                 HAVING COUNT(1) > 1)
ORDER BY 1;


-- Staff details who’s salary is less than 5000
SELECT STAFF_TYPE, FIRST_NAME, LAST_NAME
FROM  STAFF
WHERE STAFF_ID IN (SELECT STAFF_ID
                     FROM STAFF_SALARY
                    WHERE SALARY < 5000);

