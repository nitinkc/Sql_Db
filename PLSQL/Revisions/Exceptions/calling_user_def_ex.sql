-- error code - -20000 to -20999 only

CREATE OR REPLACE PROCEDURE calling_user_def_ex AS

past_due EXCEPTION; -- declare exception
 PRAGMA EXCEPTION_INIT (past_due, -20060);
-- assign error code to exception
BEGIN
	account_status ('1-JUL-10', '9-JUL-10'); -- invoke procedure
EXCEPTION
WHEN past_due THEN -- handle exception
DBMS_OUTPUT.PUT_LINE(TO_CHAR(SQLERRM(-20060)));
END calling_user_def_ex;
/
