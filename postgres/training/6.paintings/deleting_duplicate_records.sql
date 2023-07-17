SET search_path TO painting;
SHOW search_path;

-- 6) Suppose you insert the below 2 records to the artists table. 
    insert into artists values (5,'Kate','Smith');--duplicate row
    insert into artists values (6,'Natali','Wein');--duplicate row

-- Write a query to identify the duplicate artists.

-- Most common interview question:
-- How do you remove duplicate data from a table?
	
-- 1) Identify the duplicate data
-- 2) Once identified, then redelete move the duplicate data.
	
select * from artists;

//Finding the duplicate names
select first_name ||' '||last_name AS fullName, count(1) AS count_FullName
from artists 
group by fullName
having count(1) > 1;
	
-- Wrong way of deleting duplicate data, if not using the ID
delete from artists 
where (first_name, last_name) in 
	(select first_name, last_name
		from artists 
		group by first_name, last_name
		having count(1)>1
	);--Deletes 4 ROWS, that means 2 duplicate AND 2 original

select * from artists;

-- Reinserting the deleted data for further testing
insert into artists values (2,'Kate','Smith');
insert into artists values (3,'Natali','Wein');
insert into artists values (5,'Kate','Smith');
insert into artists values (6,'Natali','Wein');


select max(id)
from artists 
group by first_name, last_name
having count(1)>1;

-- Method 1: Works when there is single duplicate record but not when there are multiple duplicates
delete from artists 
where id in 
	(select max(id) -- This subquery returns the id of the duplicate record
		from artists 
		group by first_name, last_name
		having count(1)>1);-- Getting the largest/max id, among the duplicate.
	

select * from artists;
insert into artists values (5,'Kate','Smith');
insert into artists values (6,'Natali','Wein');
insert into artists values (7,'Kate','Smith');
insert into artists values (8,'Natali','Wein'); 

-- Method 2: This works even when there are multiple duplicate records
delete from artists 
	where id not in (select min(id) -- This subquery returns all unique records
					from artists 
					group by first_name, last_name);

-- Method 3: When the table is large
select * from artists;

create table artists_bkp 
as
select min(id) as id, first_name, last_name
from artists 
group by first_name, last_name;
	
select * from artists_bkp;
	
-- Sub method 1: using drop  (Not recommended in production or live environment. Its ok for Dev or test environment)
drop table artists;
alter table artists_bkp rename to artists;
	
-- Sub method 2: Using Truncate
insert into artists values (1,'Thomas','Black');
insert into artists values (2,'Kate','Smith');
insert into artists values (3,'Natali','Wein');
insert into artists values (4,'Francesco','Benelli');
insert into artists values (5,'Kate','Smith');
insert into artists values (6,'Natali','Wein');
insert into artists values (7,'Kate','Smith');
insert into artists values (8,'Natali','Wein');

select * from artists;
select * from artists_bkp;
	
truncate table artists;
	
insert into artists 
select * from artists_bkp;
	
drop table artists_bkp;
	
-- method 5: 
	insert into artists values (2,'Kate','Smith');
	insert into artists values (3,'Natali','Wein');
	insert into artists values (2,'Kate','Smith');
	insert into artists values (3,'Natali','Wein');
	
select * from artists order by id;

delete from artists 
where ctid not in (select min(ctid) -- This subquery returns all unique records
					from artists 
					group by first_name, last_name);

				
select a.*, a.ctid from artists a order by id;  -- works in Postgres
	select a.*, a.rowid from artists a order by id;  -- works in Oracle