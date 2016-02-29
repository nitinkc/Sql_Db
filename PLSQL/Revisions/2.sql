/*
1. Learn to Create RECORD type variable
*/
CREATE OR REPLACE PROCEDURE prc_cursor_learn AS
  TYPE rec_demo IS RECORD (
    c1 EMP.empno%TYPE,
    c2 EMP.ename%TYPE,
    c3 EMP.deptno%TYPE
  );

  v_demo rec_demo; -- Variable v_demo is Record (Row) of Type rec_
  -- demo which has 3 columns based in EMP Table

  -- Setting the cursor
  CURSOR c_rec_demo IS SELECT ename, empno, deptno from EMP;

  -- declaring a variable fo row type of the Cursor record
  v_rec_demo c_rec_demo%ROWTYPE;

    -- declare the variables here to be used for err log
  v_errm VARCHAR2(200);
  v_cd VARCHAR2(100);

  BEGIN
      -- 1. Open the Cursor
    OPEN c_rec_demo;

    --2. Loop through the cursor
    LOOP
      FETCH c_rec_demo INTO v_rec_demo;
    EXIT WHEN c_rec_demo%NOTFOUND ;
      -- just for demonstration purpose keeping the value in a variable of record type
      v_demo.c1 := v_rec_demo.empno; -- take care of assignment :=
      v_demo.c2 := v_rec_demo.ename;
      v_demo.c3 := v_rec_demo.deptno;
      --exit when the cursor reaches the end
       -- take care in the if : ONLY ONE = SIGN
        IF (v_demo.c3 = 20) THEN
          DBMS_OUTPUT.PUT_LINE(v_demo.c1 || '---' || v_demo.c2 || '---' || v_demo.c3);
        END IF;

    END LOOP;

    --3. close the cursor

    EXCEPTION
    WHEN OTHERS THEN
    -- inserting error codes in the tables
    v_errm := sqlerrm(sqlcode); -- take the message from the code
    v_errm := substr(v_errm, 1, 150);-- chop the message out
    v_cd := substr(sqlcode, 1, 100); -- take the sql error code

  END prc_cursor_learn;
/