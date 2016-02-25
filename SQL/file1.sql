set serveroutput on

DECLARE
	message VARCHAR2(20) := 'HI THERE';
BEGIN
	DBMS_OUTPUT.PUT_LINE(message);
END;
/