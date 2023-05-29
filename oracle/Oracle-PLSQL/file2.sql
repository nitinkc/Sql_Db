SET SERVEROUTPUT ON SIZE 1000000

DECLARE
	SUBTYPE name is char(20);
	SUBTYPE greeting is varchar2(100);
	salutation name;
	greeings greeting;
BEGIN
	salutation:=' hi there ';
	greeings:= ' break the system !!!';
	DBMS_OUTPUT.PUT_LINE(' hELLO' || salutation || greeings); 
END;
/