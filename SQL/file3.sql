SET SERVEROUTPUT ON SIZE 1000000

DECLARE
	a integer:= 10;
	b integer NOT NULL := 20;
	c integer;
	d real;
BEGIN
	c := a+b;
	DBMS_OUTPUT.PUT_LINE('value of c is ' || c);
	d := a/3;
	DBMS_OUTPUT.PUT_LINE('value of d is '|| d);
END;
/