CREATE PROCEDURE account_status ( due_date DATE, today DATE )  IS
BEGIN
IF due_date < today THEN -- explicitly raise exception RAISE_APPLICATION_ERROR(-20060, 'Account past due.');
 END IF;
 END;
/
