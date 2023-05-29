/*
User Defined exceptions

accepts two parameters and runs

RUN THE PROGRAM
-----------------------------------------------
DECLARE
v_code number;
v_msg varchar2(80);
BEGIN
prc_learn_exception(v_code, v_msg); -- the procedure will output the data into the two variables
dbms_output.put_line(v_code || '---' || v_msg);
END;
.
------------------------------------------------

 */


CREATE OR REPLACE PROCEDURE prc_learn_exception(P_return_code OUT NUMBER,
  P_return_message OUT VARCHAR2) -- no need to give the size of varchar
AS
    e_number1 EXCEPTION; -- MY Exception
    E2 EXCEPTION;
    E3 EXCEPTION;
  cnt NUMBER;
  BEGIN
    SELECT count(*)
    INTO cnt
    FROM EMP;

    IF (cnt = 0) THEN
      RAISE e_number1; -- raise a user defined exception
      RETURN;
    ELSE
      P_return_code := 0;
      P_return_message := 'count is not ZERO';
      dbms_output.put_line(cnt);
    END IF;


    EXCEPTION

    WHEN e_number1 THEN
    P_return_code := 99;
    P_return_message := 'No data found for select stmt';

    WHEN OTHERS THEN
    P_return_code := -1; --for unknown errors
    P_return_message := 'No data found for select stmt';

    dbms_output.put_line(SQLCODE || '--' || SQLERRM);

  END prc_learn_exception;
/