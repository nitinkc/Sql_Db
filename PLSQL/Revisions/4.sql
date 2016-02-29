CREATE OR REPLACE PROCEDURE prc_learn_reraising_exceptions AS
    e_salary_too_high EXCEPTION;
  current_salary   NUMBER := 20000;
  max_salary       NUMBER := 10000;
  erroneous_salary NUMBER;

  -- declare the variables here to be used for err log
  v_errm VARCHAR2(200);
  v_cd VARCHAR2(100);

  BEGIN
    BEGIN
      IF current_salary > max_salary
      THEN
        RAISE e_salary_too_high; -- raise exception
      END IF;
      EXCEPTION
      WHEN e_salary_too_high THEN
      erroneous_salary := current_salary;
      DBMS_OUTPUT.PUT_LINE('Salary ' || erroneous_salary || ' is out of range.');
      DBMS_OUTPUT.PUT_LINE('Maximum salary is ' || max_salary || '.');
      -- Raise can only be called from the exception
      RAISE; -- reraise current exception (exception name is optional)
      -- The information reaches the outer block and the outer block takes a decision
    END;
    -- if the exception occurs, the following two statements will never execure (if we have RAISE)
    -- If the re-raising is not done, then these two will execute always!!
    INSERT INTO success_tbl VALUES ('success', sysdate);
    DBMS_OUTPUT.PUT_LINE('Success TBL insert done.');

    EXCEPTION
    WHEN e_salary_too_high THEN -- finish handling exception
      DBMS_OUTPUT.PUT_LINE('Re raising the exception');
      current_salary := max_salary;
      DBMS_OUTPUT.PUT_LINE('Revising salary from ' || erroneous_salary || ' to ' || current_salary || '.');

    WHEN OTHERS THEN
      v_errm := sqlerrm(sqlcode);
      v_errm := substr(v_errm, 1, 150);
      v_cd := substr(sqlcode, 1, 100);
      INSERT INTO err_log VALUES ('prc_learn_type', v_cd, v_errm, sysdate, user);
      DBMS_OUTPUT.PUT_LINE('SQL Code is: ' || SQLCODE || 'SQL Error is: ' || SQLERRM);

  END prc_learn_reraising_exceptions;
/
