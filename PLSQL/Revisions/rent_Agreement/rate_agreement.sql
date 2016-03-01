/*
The Rent Agreement Problem
Initial data : Nov 12 2010 to Nov 11 2011

-- table format
insert into rate_agreement values (1, to_date('2010/11/12','yyyy/mm/dd'), to_date('2011/11/11','yyyy/mm/dd'), 1000 );

 -- parameter dates are in mm-dd-yyyy format

 -- Scenario 1: New Dates Beyond old dates from both end
    -- RUN : exec run_rate_agreement('05-12-2010', '03-03-2012', 3300);

 --Scenario 1.1 : Fully overlap
    --Run :  exec run_rate_agreement('11-12-2010', '11-11-2011', 4080);

--Scenario 1.2 : Left side overlaps (old and new start dates aer same) and right side extends
    --Run :  exec run_rate_agreement('11-12-2010', '03-11-2012', 4080);

--Scenario 1.3 : Right side overlaps (old and new end dates are same) and right side extends
    --Run :  exec run_rate_agreement('06-12-2010', '11-11-2012', 4080);

--Scenario 2: New Dates between Old dates - Split in three parts. starting and ending is Old rate
    -- RUN :  exec run_rate_agreement('02-12-2011', '06-11-2011', 1250);

-- Scenario 2.1: New Dates between Old dates with new end date overlaps old end date
    -- RUN : exec run_rate_agreement('02-12-2011', '11-11-2011', 1100);

-- Scenario 2.2: New Dates between Old dates with new start date overlaps old start date
    -- RUN : exec run_rate_agreement('11-12-2010', '02-21-2011', 2200);

-- Scenario 3: New Start date begins before old start date & new end date between the two old dates
    -- RUN : exec run_rate_agreement('02-26-2010', '06-11-2011', 3300);

-- Scenario 4: Reverse of Scenario 3: New Start date between the two two old dates and new end date beyond old end dt
    -- RUN : exec run_rate_agreement('01-01-2011', '01-01-2012', 4400);

-- Scenario 5: New agreement ends before the old even begins
    -- RUN : exec run_rate_agreement('01-01-2010', '01-08-2010', 5500);

-- Scenario 6: New agreement begins before the old finishes
    -- RUN : exec run_rate_agreement('12-01-2011', '01-08-2012', 6600);
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
    new_rate := rate;

    DBMS_OUTPUT.PUT_LINE('Data Provided by the User');
    DBMS_OUTPUT.PUT_LINE(new_st_dt || ' --- ' || new_end_dt || ' --- ' || new_rate);

    --set up the table
    --TRUNCATE is DDL (data definition language). You cannot perform DDL from within PL/SQL
    --PERFORMANCE DEGRADES - NOT RECOMMENDED!!
    BEGIN
      EXECUTE IMMEDIATE 'TRUNCATE table rate_Agreement';
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

    -- Scenario 1: New Dates Beyond old dates from both end
    -- parameter dates are in mm-dd-yyyy format
    -- RUN : exec run_rate_agreement('05-12-2010', '03-03-2012', 3300);
     IF (new_st_dt <= old_st_dt AND new_end_dt >= old_end_dt) THEN
      UPDATE RATE_AGREEMENT SET fromdate = new_st_dt, todate = new_end_dt, amount = new_rate;
      COMMIT ;
      DBMS_OUTPUT.PUT_LINE('Update Successful Scenario 3');
    END IF;

    -- parameter dates are in mm-dd-yyyy format

    --Scenario 1.1 : Fully overlap
    -- this is a special case of Scenario 1
    --Run :  exec run_rate_agreement('11-12-2010', '11-11-2011', 4080);

    --Scenario 1.2 : Left side overlaps (old and new start dates aer same) and right side extends
    --Run :  exec run_rate_agreement('11-12-2010', '03-11-2012', 4080);

    --Scenario 1.3 : Right side overlaps (old and new end dates are same) and right side extends
    --Run :  exec run_rate_agreement('06-12-2010', '11-11-2012', 4080);

    -- All the above 3 sub-scenarios are covered in the Scenario 1

    /* This block coveres in Scenario 1.1
    IF (new_st_dt = old_st_dt AND new_end_dt = old_end_dt) THEN
      --No need to change dates as there is atotal eclipse
      UPDATE RATE_AGREEMENT SET amount = new_rate;
      COMMIT ;
      DBMS_OUTPUT.PUT_LINE('Update Successful Scenario 1');
    END IF;
    */

    --Scenario 2: New Dates between Old dates
    --Split in three parts. starting and ending is Old rate
    -- while middle one is the new rate
    -- parameter dates are in mm-dd-yyyy format
    -- RUN :  exec run_rate_agreement('02-12-2011', '06-11-2011', 1250);
    IF (new_st_dt > old_st_dt AND new_end_dt < old_end_dt) THEN
      --starting
      --first segment of old rate
      UPDATE RATE_AGREEMENT SET fromdate = old_st_dt, todate = new_st_dt - 1, amount = old_rate;
      -- second segment of new rates
      INSERT INTO RATE_AGREEMENT VALUES (2,new_st_dt, new_end_dt,new_rate);
      -- third segment of old rate
      INSERT INTO RATE_AGREEMENT VALUES (3,new_end_dt + 1, old_end_dt,old_rate);

      COMMIT ;
      DBMS_OUTPUT.PUT_LINE('Update Successful Scenario 2');
    END IF;

    -- Scenario 2.1: New Dates between Old dates with new end date overlaps old end date
    -- parameter dates are in mm-dd-yyyy format
    -- RUN : exec run_rate_agreement('02-12-2011', '11-11-2011', 1100);
     IF (new_st_dt > old_st_dt AND new_end_dt = old_end_dt) THEN
      --starting
      --first segment of old rate
      UPDATE RATE_AGREEMENT SET fromdate = old_st_dt, todate = new_st_dt - 1, amount = old_rate;
      -- second segment of new rates
      INSERT INTO RATE_AGREEMENT VALUES (2,new_st_dt, new_end_dt,new_rate);
      COMMIT ;
      DBMS_OUTPUT.PUT_LINE('Update Successful Scenario 2.1');
    END IF;

    -- Scenario 2.2: New Dates between Old dates with new start date overlaps old start date
    -- parameter dates are in mm-dd-yyyy format
    -- RUN : exec run_rate_agreement('11-12-2010', '02-21-2011', 2200);
     IF (new_st_dt = old_st_dt AND new_end_dt < old_end_dt) THEN
      UPDATE RATE_AGREEMENT SET fromdate = old_st_dt, todate = new_end_dt - 1, amount = new_rate;--BUG: date -1 is required
      -- second segment of new rates
      INSERT INTO RATE_AGREEMENT VALUES (2,new_end_dt, old_end_dt,old_rate);
      COMMIT ;
      DBMS_OUTPUT.PUT_LINE('Update Successful Scenario 2.2');
    END IF;


    -- Scenario 3: New Start date begins before old start date & new end date between the two old dates
    -- parameter dates are in mm-dd-yyyy format
    -- RUN : exec run_rate_agreement('02-26-2010', '06-11-2011', 3300);
     IF (new_st_dt < old_st_dt AND (new_end_dt > old_st_dt AND new_end_dt < old_end_dt)) THEN --Possible BUG Consider the case of equality
      --first segment of new rate
      UPDATE RATE_AGREEMENT SET fromdate = new_st_dt, todate = new_end_dt, amount = new_rate;
      -- second segment of old rates
      INSERT INTO RATE_AGREEMENT VALUES (2,new_end_dt + 1, old_end_dt, old_rate);
      COMMIT ;
      DBMS_OUTPUT.PUT_LINE('Update Successful Scenario 3');
    END IF;


    -- Scenario 4: Reverse of Scenario 3: New Start date between the two two old dates and new end date beyond old end dt
    -- parameter dates are in mm-dd-yyyy format
    -- RUN : exec run_rate_agreement('01-01-2011', '01-01-2012', 4400);
     IF ((new_st_dt > old_st_dt AND new_st_dt < old_end_dt) AND new_end_dt > old_end_dt ) THEN --Possible BUG take care of equality
      --first segment of new rate
      UPDATE RATE_AGREEMENT SET fromdate = old_st_dt, todate = new_st_dt, amount = old_rate;
      -- second segment of old rates
      INSERT INTO RATE_AGREEMENT VALUES (2,new_st_dt + 1, new_end_dt, new_rate);
      COMMIT;
      DBMS_OUTPUT.PUT_LINE('Update Successful Scenario 4');
    END IF;

    -- Scenario 5: New agreement ends before the old even begins
    -- parameter dates are in mm-dd-yyyy format
    -- RUN : exec run_rate_agreement('01-01-2010', '01-08-2010', 5500);
     IF (new_st_dt < old_st_dt AND new_end_dt <= old_st_dt ) THEN --Possible BUG take care of equality
    -- the old agreement persists
     -- Adding the new agreement segment of old rates
      INSERT INTO RATE_AGREEMENT VALUES (2,new_st_dt, new_end_dt, new_rate);
      COMMIT;
      DBMS_OUTPUT.PUT_LINE('Update Successful Scenario 5');
    END IF;

    -- Scenario 6: New agreement begins before the old finishes
    -- parameter dates are in mm-dd-yyyy format
    -- RUN : exec run_rate_agreement('12-01-2011', '01-08-2012', 6600);
     IF (new_st_dt >= old_end_dt AND new_end_dt > old_end_dt) THEN --Possible BUG take care of equality
    -- the old agreement persists
     -- Adding the new agreement segment
      INSERT INTO RATE_AGREEMENT VALUES (2,new_st_dt, new_end_dt, new_rate);
      COMMIT;
      DBMS_OUTPUT.PUT_LINE('Update Successful Scenario 6');
    END IF;


    EXCEPTION
    WHEN TOO_MANY_ROWS THEN
        DBMS_OUTPUT.PUT_LINE('multiple rows');
    WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE('Other Exception');

  END prc_rate_agreement_prob;
/