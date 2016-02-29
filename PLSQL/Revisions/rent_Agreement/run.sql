CREATE OR REPLACE PROCEDURE run_rate_agreement(start_date IN VARCHAR2, end_date IN VARCHAR2, rate IN NUMBER)
AS
  wrong_date EXCEPTION; -- declare exception
  -- assign error code to exception
  PRAGMA EXCEPTION_INIT (wrong_date, -20099);

  -- declare the variables here to be used for err log
  v_errm VARCHAR2(200);
  v_cd VARCHAR2(100);
  BEGIN
    --DBMS_OUTPUT.PUT_LINE(start_date || '---' || end_date || '---' || rate);
    prc_rate_agreement_prob(start_date, end_date, rate); -- invoke procedure
    EXCEPTION
    WHEN wrong_date THEN -- handle exception
    DBMS_OUTPUT.PUT_LINE(TO_CHAR(SQLERRM(-20099)));
    -- inserting error codes in the tables
       v_errm := sqlerrm(sqlcode); -- take the message from the code
       v_errm := substr(v_errm, 1, 150);-- chop the message out
       v_cd := substr(sqlcode, 1, 100); -- take the sql error code
      INSERT INTO err_log VALUES ('run_rate_agreement',v_cd, v_errm, sysdate, user);
      DBMS_OUTPUT.PUT_LINE(v_cd || v_errm || sysdate || user);
      -- if commit is not auto enabled
      COMMIT;

  END run_rate_agreement;
/
