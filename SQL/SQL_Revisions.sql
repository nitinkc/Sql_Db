-- Comments are put in -- and /* */
-- String are enclosed in single quotes

--------------------------------NOTES ------------------------
-- || is called concatenation
-- For joins, look at the data in the tables, the data must be referenced
-- with rownum we can only use < or  <= operator, f=greater than does not work
-- row id is the physical address of a record. Fastest access with Rowid
-- rownum is the logical number given
-- There are 5 constraints 
    -- primary, foreign, not null, unique, 
-- all strings, dates and time are in single quotes
-- only table/column alias with space in double quotes

-- In DBMS - One single record (one row) is an element in the set

-- For pattern matching -, %

-- Group by - A class is a group.
-- Group by -> 1 output per row

-- Join - avoid having redundat rows
/*                      Join 
                        / \
                       /   \
--Inner Join (common data)  Outer (common date not necessasary)
*/          
-- Outer Join is generic. Provides inner join results plus some extra data
------------------------------------------------------------------------------
/* See all tables in the schema*/
Select * from tab;

select * from emp;
select * from dept;

/* Count the total number of Rows*/
select count(*) from emp;

/*Decode the Employee Number*/
select case when empno = 7369 then 1
            when empno = 7499 then 2
            else 1111
            end
    empno, ename from EMP;        
    
/* Above can also be written as */
select decode(empno, 7369, 1,
7499, 2,
1111) from emp;

/*Multiple Conditions*/

/*Dates are surrounded in single colon*/
select * from emp where sal >= 1250 AND hiredate <'1-jan-2009';

/* Range Selection */
Select * from emp where sal between 800 AND 1000;

/* Exact List Matching (If there is none (900), then no result)*/
Select * from EMP where sal IN (800, 1250, 900);

/* SQL Alias*/

/* In SQL the strings are in single quotes Only Alias in double quotes*/
-- Column Alias
/* With the use of keyword AS*/
select hiredate as "Date HIRED" from emp;

/* Without the use of keyword as HAS TO BE A SINGLE WORF*/
select hiredate HIRE_DATE from emp; 

/* Table Alias*/
select e.empno MY_EMPLOYEE, d.deptno "From Random Dept" from emp e, dept d; 

select e.ename EMPLOYEE, d.dname "Work in Dept" from emp e, dept d where 
e.deptno = d.deptno; 

/* Pattern Matching */
/* Count the total employees with name beginniong with A */
/* % is String matching operator this used with quotes
    LIKE is used only with Strings */
select count(*) from emp where empno like '7%';

/* underscore os for single characters */
select empno from emp where empno like '_7%';

/* Clubbing the two columns together */
select ename||'-'||empno "Name-id Pairs" from emp where empno like '_5_%';

/* convert into lowercase before comparison. Avoids String matching */
Select ename, empno from emp where lower(job) IN('clerk');

/* NULL value treatment. ALWAYS USE is NULL or ISNOT NULL. NO = */ 
Select * from emp where comm IS NULL;
Select * from emp where comm IS NOT NULL;

/* WARNING: THIS WILL NOT GIVE ERROR. BUT WRONG RESULT (No rows return) */
Select * from emp where comm = NULL; 

/* Null value treatment*/
Select ename, comm from emp;

/* Replace null by ZERO*/
Select ename, nvl(comm, 0) from emp;

/* Replace non null by 11 and null by 0*/
/* NVL2 syntax nvl2(string, VAL_IF_NOT_NULL, VAL_IF_NULL)*/
Select ename, nvl2(comm, 11, 0) Commission from emp;

/* Replace null by ZERO*/
Select comm*17, nvl(comm, 0)*17 from emp;

--------------------------------------------------
-- ORDER BY

-- By default it is ASC
select * from emp order by sal;

-- Decreasing Order
select * from emp order by empno DESC;

-- Order by Third Column
select * from emp order by 3;

-- Order by First column
select Mgr, ename from emp order by 1 DESC;

-- Order by 2 columns
select * from emp order by JOB, DEPTNO DESC;

----------------------------------------------
-- DDL STATEMENTS ----------------------------

/* Column Level Constraints, Unnamed
    *** Can only be applied to one column
*/
Create table tab_1 (c number Primary Key,
First_Name char(30) NOT NULL,
Mobile_Number number(12) UNIQUE,
Gender char(1) Check(gender in ('M','F')));
commit;

/* Table Level Constraints, 
    *** can be applied to a group of columns
    *** have named constraints
    *** maintenance of named constraints is easier than un-nmaed
*/
create table tab_2 (id number(5), name char(20), price number(10),
constraint tab2_id_primary_key PRIMARY KEY(id));
commit;

/* Create a new Table*/
create table tab_3 (name char(20), price number(10));

/* Add column id to the table tab_1*/
alter table tab_3 
add id number;
commit;

/* Add aconstraint */
alter table tab_3 add constraint pk_tab1_id primary key(id);

/* Adding Foreign Key */
alter table tab_3 
add constraints fk_tab2
foreign key (id)
references tab_2(id);

/* Drop the contraint*/
alter table tab_3 
drop constraint fk_tab2;
--------------------------------------------------------------------------------
----------------------- DATA DICTIONARY ----------------------------------------

select * from user_source;

select * from user_tables; -- infor about tables

select * from user_tables; -- contains information about tables

select * from user_objects; -- info about procedures/functions and other objects

select * from user_users; -- users information

select * from user_constraints; -- constraints PK, FK, Check etc.
select * from user_cons_columns; -- Constraints Columns

select * from user_roles;
select * from user_indexes;
select * from user_views;
select * from user_sequences; 


--------------------------------------------------------------------------------
-------------------------- ALTERING THE TABLE ----------------------------------

alter table tab_3 drop column price;

alter table tab_3 add price number(5);

alter table tab_3 modify price number(10);

alter table tab_3 add address varchar2(50) default 'default address' not null;

--------------------------------------------------------------------------------
-------------------------- Relationships ---------------------------------------
/* One to One : one person has one birth date 
    Implemented with just one table
*/

/* One to Many : One Person has many 
    Implemented with two tables

*/

/* Many to Many : Many Students has many subjects
    Implemented with three tables


*/

--------------------------------------------------------------------------------
-- Set Theory- Top-N Analysis

/* Get the 5th Heighest salary*/
select empno, ename, sal from (select * from Emp order by sal desc) 
where rownum < 6
MINUS
select empno, ename, sal from (select * from Emp order by sal desc)
where rownum < 5;

--------------------------------------------------------------------------------
-- GROUP BY Clause
-- sum, count, max, min, avg

/* how many clerks, salesman etc ate there */
select job, count(deptno) ALL_EMPLOYEES from emp group by job;

-- HAVING Clause to put condition on groups
--
select job, sum(sal) Total_Sal_allEMP from emp 
where hiredate between '1-jan-1981' and '1-jun1981'
group by job
having sum(sal) < 4000;


--------------------------------------------------------------------------------
------ SQL JOINS

------------------- CREATING THE Table for the demonstration ------------------
create table Persons(P_id number(5), LastName varchar2(20), FirstName varchar2(20),
Address varchar2(50), City varchar2(10),
constraint pk_Persons_Tab PRIMARY KEY(P_id));

Insert into Persons values (1,'Hansen','Ola','Timoteivn 10', 'Sandnes');
Insert into Persons values (2,'Svendson','Tove','Borgvn 23', 'Sandnes');
Insert into Persons values (3,'Pettersen','Kari','Storgt 20', 'Stavanger');

select * from Persons;

create table Orders(O_id number(2), OrderNo number(5), P_id number(2),
constraint pk_Orders_Tab PRIMARY KEY(O_id));

Insert into Orders values (1, 77895,3);
Insert into Orders values (2, 44678,3);
Insert into Orders values (3, 22456,1);
Insert into Orders values (4, 24562,1);
Insert into Orders values (5, 34764,15);

select * from Orders;

alter table Orders 
add constraints fk_Orders_tab
foreign key (P_id)
references Persons(P_id);

commit;

/* Inner Join, Equi Join, Natural Join 
Matching data is returned */
select PERSONS.FIRSTNAME, PERSONS.LASTNAME, ORDERS.ORDERNO
from PERSONS, ORDERS
where PERSONS.P_ID = ORDERS.P_ID;

/* Inner Join, Equi Join, Natural Join */
select PERSONS.FIRSTNAME, PERSONS.LASTNAME, ORDERS.ORDERNO
from PERSONS left outer join ORDERS ON PERSONS.P_ID = ORDERS.P_ID;

/* Right Outer Join */
select PERSONS.FIRSTNAME, PERSONS.LASTNAME, ORDERS.ORDERNO
from PERSONS right outer join ORDERS ON PERSONS.P_ID = ORDERS.P_ID;

/* Full Outer Join */
select PERSONS.FIRSTNAME, PERSONS.LASTNAME, ORDERS.ORDERNO
from PERSONS full outer join ORDERS ON PERSONS.P_ID = ORDERS.P_ID;

/* If we use any condition other than equality, join becomes non-equi join.*/

/* Statement that use unequal operation (<>, >, <, !=, betweem etc...)*/
/* Inner non-equi join example */
Select e.ename, e.sal, s.grade
from emp e, salgrade s
where E.SAL between S.LOSAL and S.HISAL;

-- SELF JOIN
/* To avoid cross join in a Self Join, We MUST have n-1 conditions for n tables*/
select e1.ename||' works for '||e2.ename AS "Employees - Managers" 
from emp e1 JOIN emp e2 ON(e1.mgr = e2.empno);

/* AVOID CARTESIAN PRODUCT or CROSS JOIN*/