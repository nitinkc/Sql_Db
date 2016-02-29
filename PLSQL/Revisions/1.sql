/*****************************************************
1. Learn how to to take input from the procedure
2. Learn how to send output in the console
3. Learn how to use %TYPE

Note: EMP is the table Name

RUN THE PROGRAM
-----------------------------------------------
declare
x number(5);
begin
prc_learn_type(123, x);
dbms_output.put_line(x);
end;
.
------------------------------------------------
Revision History
1.1 Feb 28 2016 Program Created
1.2 Since out parameter is involved, HAVE TO run in the block!!
1.3 Putting the error into the err_log tables. The bug that took time was the usage of
sqlerrm in the function
WRONG : INSERT INTO err_log VALUES ('prc_learn_type',substr(sqlcode, 1, 100), substr(sqlerrm(SQLCODE), 1, 100), sysdate, user);

CORRECT:
v_errm := sqlerrm(sqlcode);
 v_errm := substr(v_errm, 1, 150);
 v_cd := substr(sqlcode, 1, 100);
INSERT INTO err_log VALUES ('prc_learn_type',v_cd, v_errm, sysdate, user);
************************************************************/

--set serveroutput on;
CREATE OR REPLACE PROCEDURE prc_learn_type(e_number in NUMBER, e_deptno out NUMBER)
AS
  v_ename EMP.ename%TYPE;
  v_eno EMP.empno%TYPE;

  -- Since you cannot use sqlcode and sqlErrm directly into thwe statement in a function,
  -- declare the variables here to be used for err log
  v_errm VARCHAR2(200);
  v_cd VARCHAR2(100);
  BEGIN
    -- Getting the data
    SELECT ename, empno, deptno
    INTO v_ename,v_eno, e_deptno
      FROM EMP
        WHERE empno =  e_number;
    DBMS_OUTPUT.PUT_LINE('Employee Name is : ' || v_ename || ' Employee # is ' || v_eno || ' Wroking in the dept # ' || e_deptno);
    EXCEPTION
    WHEN NO_DATA_FOUND THEN
      DBMS_OUTPUT.PUT_LINE('No Employee with Empno : ' || e_number);
    -- inserting error codes in the tables
      v_errm := sqlerrm(sqlcode); -- take the message from the code
       v_errm := substr(v_errm, 1, 150);-- chop the message out
       v_cd := substr(sqlcode, 1, 100); -- take the sql error code
      INSERT INTO err_log VALUES ('prc_learn_type',v_cd, v_errm, sysdate, user);
      -- if commit is not auto enabled
      commit;
    WHEN TOO_MANY_ROWS THEN
    v_errm := sqlerrm(sqlcode);
     v_errm := substr(v_errm, 1, 150);
     v_cd := substr(sqlcode, 1, 100);
    INSERT INTO err_log VALUES ('prc_learn_type',v_cd, v_errm, sysdate, user);
      DBMS_OUTPUT.PUT_LINE('Too many Rows');
    WHEN OTHERS THEN
     v_errm := sqlerrm(sqlcode);
     v_errm := substr(v_errm, 1, 150);
     v_cd := substr(sqlcode, 1, 100);
    INSERT INTO err_log VALUES ('prc_learn_type',v_cd, v_errm, sysdate, user);
      DBMS_OUTPUT.PUT_LINE('SQL Code is: ' || SQLCODE || 'SQL Error is: '|| SQLERRM);
  END prc_learn_type;
/
