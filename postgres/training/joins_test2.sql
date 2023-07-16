
-- Scenario 2
DROP TABLE IF EXISTS table3;
create table table3
(id1 int);

DROP TABLE IF EXISTS table4;
create table table4
(id2 int);

insert into table3 values (null),(0),(null),(0),(0),(1),(1);
insert into table4 values (1),(0),(0),(0),(null),(null);

select * from table3;
select * from table4;

-- Inner join, intersection
select *
from table3 t3
join table4 t4 on t3.id1 = t4.id2;

select *
from table3 t3
left join table4 t4 on t3.id1 = t4.id2;

select *
from table3 t3
right join table4 t4 on t3.id1 = t4.id2;

select *
from table3 t3
full join table4 t4 on t3.id1 = t4.id2;

select *
from table3 t3
NATURAL join table4 t4;

select *
from table3 t3
cross join table4 t4;