/*
The Rent Agreement Problem
Initial data : Nov 12 2010 to Nov 11 2011

CLEAR THE TABLE
TRUNCATE TABLE rate_Agreement;
insert into rate_agreement values (1, to_date('2010/11/12','yyyy/mm/dd'), to_date('2011/11/11','yyyy/mm/dd'), 1000 );
Scenario 1 : exec run_rate_agreement('11-12-2010', '11-11-2011', 4080);
Scenario 2: exec run_rate_agreement('02-12-2011', '06-11-2011', 4080);
*/
CREATE OR REPLACE PROCEDURE prc_rate_agreement_prob(start_date IN VARCHAR2, end_date IN VARCHAR2, rate IN INTEGER)
AS
  new_st_dt     RATE_AGREEMENT.FROMDATE%TYPE; --date format
  new_end_dt    RATE_AGREEMENT.TODATE%TYPE;
  new_rate      RATE_AGREEMENT.AMOUNT%TYPE;

  old_st_dt     RATE_AGREEMENT.FROMDATE%TYPE; --date format
  old_end_dt    RATE_AGREEMENT.TODATE%TYPE;
  old_rate      RATE_AGREEMENT.AMOUNT%TYPE;

  BEGIN
    IF (length(new_st_dt) != 10) THEN
      raise_application_error(-20099, 'Wrong date format');
    END IF;

    new_st_dt := to_date(start_date, 'MM-DD-YYYY');
    new_end_dt := to_date(end_date, 'MM-DD-YYYY');

    DBMS_OUTPUT.PUT_LINE('Correct date provided by the user');
    DBMS_OUTPUT.PUT_LINE(new_st_dt || '---' || new_end_dt || '---' || new_rate);

    BEGIN
       --set up the table
      TRUNCATE TABLE rate_Agreement;
      insert into rate_agreement values (1, to_date('2010/11/12','yyyy/mm/dd'), to_date('2011/11/11','yyyy/mm/dd'), 1000 );
      COMMIT ;
    END;

    SELECT
      fromdate,
      todate,
      amount
    INTO old_st_dt, old_end_dt, old_rate
    FROM RATE_AGREEMENT WHERE id=1;
    DBMS_OUTPUT.PUT_LINE('Data from the Database');
    DBMS_OUTPUT.PUT_LINE(old_st_dt || '---' || old_end_dt || '---' || old_rate);

    --Scenatio 1 : Fully overlap
    --Run :  exec run_rate_agreement('11-12-2010', '11-11-2011', 4080);
    IF (new_st_dt = old_st_dt AND new_end_dt = old_end_dt) THEN
      --No need to change dates as there is atotal eclipse
      UPDATE RATE_AGREEMENT SET amount = new_rate;
      COMMIT ;
      DBMS_OUTPUT.PUT_LINE('Update Successful');
    END IF;

    --Scenario 2: New Dates between Old dates
    --Split in three parts. starting and ending is Old rate
    -- while middle one is the new rate
    -- RUN :  exec run_rate_agreement('02-12-2011', '06-11-2011', 4080);
    IF (new_st_dt > old_st_dt AND new_end_dt < old_end_dt) THEN
      --starting
      --first segment of old rate
      UPDATE RATE_AGREEMENT SET fromdate = old_st_dt, todate = new_st_dt, amount = old_rate;
      -- second segment of new rates
      INSERT INTO RATE_AGREEMENT VALUES (2,new_st_dt, new_end_dt,new_rate);
      -- third segment of old rate
      INSERT INTO RATE_AGREEMENT VALUES (3,new_end_dt, old_end_dt,old_rate);

      COMMIT ;
      DBMS_OUTPUT.PUT_LINE('Update Successful');

    END IF;

    EXCEPTION
    WHEN TOO_MANY_ROWS THEN
        DBMS_OUTPUT.PUT_LINE('multiple rows');
    WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE('Other Exception');

  END prc_rate_agreement_prob;
/