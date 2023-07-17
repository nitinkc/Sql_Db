SET search_path TO student, public;
SHOW search_path;

-- TO_CHAR function taking the year part and converting to string
SELECT * FROM STUDENTS WHERE TO_CHAR(DOB,'YYYY') = '2014' limit 1;
SELECT TO_CHAR(DOB,'MON') as month_String, * FROM STUDENTS WHERE TO_CHAR(DOB,'MON') = 'JAN' limit 1;


-- TO_DATE - Accepts the date format
SELECT * FROM STUDENTS WHERE DOB = TO_DATE('01-14-2014','MM-DD-YYYY');