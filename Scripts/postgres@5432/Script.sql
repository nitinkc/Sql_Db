-- Create a Schema
create schema training;

select * from information_schema.tables
where table_schema='public';

create table hospitals_tab
(
	hospital_code	int,
	hospital_name	varchar(50), 
	location		varchar(200), 
	contact_no		bigint
);

-- Renaming table name
alter table hospitals_tab 
rename to hospitals;

-- Removing a column 
alter table hospitals
drop column contact_no;

-- Adding a column
alter table hospitals
add column contact_no bigint;