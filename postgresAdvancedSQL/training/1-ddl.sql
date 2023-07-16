drop table if exists hospitals_tab;
drop table if exists hospitals;

create table hospitals_tab
(
	hospital_code	int,
	hospital_name	varchar(50), 
	location		varchar(200), 
	contact_no		int
);

-- Renaming table name
alter table hospitals_tab 
rename to hospitals;

-- Removing a column 
alter table hospitals
drop column contact_no;

-- Adding a column
alter table hospitals
add column contact_no int;

-- Changing the Datatype of a column and making it store non-null values 
ALTER TABLE hospitals
ALTER COLUMN contact_no TYPE BIGINT,
ALTER COLUMN contact_no SET NOT NULL;

-- Adding primary key constraint after table creaiton
alter table hospitals add constraint pk_hospital_code primary key (hospital_code);

-- Adding primary key constraint after table creaiton
alter table hospitals add constraint not_null_hospital_name not null (hospital_name);

-- Drop Vs Delete Vs Truncate

delete from hospitals
where hospital_code = 12345 ;

truncate table hospitals;

drop table hospitals;

-- Difference between DELETE and TRUNCATE
	-- DELETE can either delete few records or all records but 
	-- TRUNCATE ALWAYS REMOVES all data/records/rows. 
	-- TRUNCATE is much faster than DELETE and keeps the structure of the table intact
-- Drop table removes the data and the structure 