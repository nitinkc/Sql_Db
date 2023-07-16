-- Scenario 1
DROP TABLE IF EXISTS table1;
create table table1
(id1 int);

DROP TABLE IF EXISTS table2;
create table table2
(id2 int);

insert into table1 values (1),(1),(1),(2),(3),(3),(3);
insert into table2 values (1),(1),(2),(2),(4),(null);

select * from table1;
select * from table2;

-- Inner Join - Returns intersection Data between 2 tables
select *
from table1 t1
join table2 t2 on t1.id1 = t2.id2;

--Brings all the data from Left table and including the intercection
select *
from table1 t1
left join table2 t2 on t1.id1 = t2.id2;

--Brings all the data from Right table and including the intercection
select *
from table1 t1
right join table2 t2 on t1.id1 = t2.id2;

--Full join, Brings rows for each of LEFT & RIGHT table
select *
from table1 t1
full join table2 t2 on t1.id1 = t2.id2;

-- Natural Join
select *
from table1 t1
NATURAL join table2 t2;

-- Each row on one table is mapped with each row of another
select *
from table1 t1
cross join table2 t2;