SET SEROUTPUT ON

DECLARE
	n_outercount number:=1;
	n_innercount number;
	n_innercount1 number:=300;
	n_innercount2 number:=4000;
BEGIN
	<<outerloop>>
	LOOP
		DBMS_OUTPUT.PUT_LINE('outer loop ' || n_outercount);
			
		FOR n_innercount IN REVERSE 10..13 LOOP
			DBMS_OUTPUT.PUT_LINE('inner for loop ' || n_innercount );			
		
			WHILE n_innercount1 < 305 LOOP
				
				DBMS_OUTPUT.PUT_LINE('inner for loop' || n_innercount1);
				n_innercount1:=n_innercount1+1;				

			END LOOP;				

		END LOOP;

		n_outercount := n_outercount+1;
		IF n_outercount>3 THEN	
			exit;
		END IF;
	END LOOP;
END;
/