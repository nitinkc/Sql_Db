/* Assignment to tell all the error and all the tables that are creating the errorrs
Demonstration of Block Structured Languages

SOLUTION: MULTILEVEL NESTING
*/

CREATE OR REPLACE PROCEDURE assignment
AS
DECLARE
 var1 EMP%ROWTYPE;
 var2 EMP%ROWTYPE;
 var3 EMP%ROWTYPE;
 var4 EMP%ROWTYPE;
 var5 EMP%ROWTYPE;
 sqlCode varchar2(100);
 sqlErrm varchar2(200);

BEGIN
  SELECT * INTO var1 FROM EMP where EMPNO = 7639;
END

EXCEPTION
  WHEN TABLE_NOT_FOUND THEN
  			insert into error_log values ('assignment', substr(sqlcode, 1,100), user||substr (sqlerrm, 1, 150), sysdate());
  WHEN NO_DATA_FOUND THEN
  			insert into error_log values ('prc_get_students', substr(sqlcode, 1,100), user||substr (sqlerrm, 1, 150), sysdate());
  WHEN OTHERS THEN
        insert into error_log values ('prc_get_students', substr(sqlcode, 1,100), user||substr (sqlerrm, 1, 150), sysdate());
END

BEGIN
  SELECT * INTO var2 FROM EMP where EMPNO = 7499;
END
EXCEPTION  
  SELECT * INTO var3 FROM EMP where EMPNO = 7521;
  SELECT * INTO var4 FROM EMP where EMPNO = 0; -- does not exist
  SELECT * INTO var5 FROM EMP where EMPNO = 7639;

EXCEPTION
  WHEN TABLE_NOT_FOUND THEN
  			insert into error_log values ('assignment', substr(sqlcode, 1,100), user||substr (sqlerrm, 1, 150), sysdate());
  WHEN NO_DATA_FOUND THEN
  			insert into error_log values ('prc_get_students', substr(sqlcode, 1,100), user||substr (sqlerrm, 1, 150), sysdate());
  WHEN OTHERS THEN
        insert into error_log values ('prc_get_students', substr(sqlcode, 1,100), user||substr (sqlerrm, 1, 150), sysdate());
END assignment;

insert into error_log values ('prc_get_students', substr(sqlcode, 1,100), user||substr (sqlerrm, 1, 150), sysdate());
