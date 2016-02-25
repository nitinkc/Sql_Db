-- SubQueries : Main Queries depends upon the result from another query

select * from dept;
Select ename, deptno from emp where deptno = (select deptno from dept where loc = 'DALLAS');

-- Subquery must return only one record






-- EXISTS clause: its performance is better

/* */