CREATE SCHEMA IF NOT EXISTS hospital;

SET search_path TO hospital, public;
SHOW search_path;

-- CREATING THE REST OF THE TABLES IN THE SCHEMA --
drop table if exists hospitals;
create table hospitals
(
	hospital_code	int ,
	hospital_name	varchar(50) , 
	location		varchar(200), 
	contact_no		bigint,
	constraint pk_hospitals primary key (hospital_code,hospital_name)
);

drop table if exists Doctors;
create table Doctors
(
	id				varchar(15),
	first_name		varchar(50) not null , 
	last_name		varchar(50) not null, 
	specilization	varchar(200), 
	gender			bigint,
	dob				date,
	salary			int,
	hospital_id		int
);

drop table if exists Patients;
create table Patients
(
	id				varchar(15) unique,
	first_name		varchar(50), 
	last_name		varchar(50), 
	gender			varchar(10) check (gender in ('M', 'F', 'Male', 'Female')),
	dob				date,
	phone_no		bigint,
	blood_group		varchar(15)
);

drop table if exists Medical_Records;
create table Medical_Records
(
	id 						int, 
	problem					varchar(200),
	date_of_examination		date, 
	patient_id				varchar(15), 
	doctor_id				varchar(15)
);

-- ADDING CONSTRAINTS
-- ALTER TABLE table_name ADD CONSTRAINT constraint_name constraint_definition;

ALTER TABLE DOCTORS alter column gender type varchar(10);
alter table doctors add constraint pk_doctor primary key (id);


-------------- ADDING DATA ---------------------
insert into hospitals values (1, 'Fortis Hospital', 'Bangalore', 9900099000);
insert into hospitals values (2, 'Manipal Hospital', 'Manipal', 9900099222);
insert into hospitals values (3, 'Apollo Hospital', 'Mumbai', 9900099333);
insert into hospitals values (4, 'St. Francis Hospital', 'New York', 17194440001);
insert into hospitals values (4, 'Duke Hospital', 'New York', 17194440022);

-- Inserting Date using to_date function
insert into Doctors values ('D1', 'Ragav', 'Jain', 'Cardiology', 'Male', to_date('01-01-1980', 'dd-mm-yyyy'), 250000, 4);
insert into Doctors values ('D2', 'Priyanka', 'Verma', 'Physician', 'female', to_date('01-01-1995', 'dd-mm-yyyy'), 350000, 3);
insert into Doctors values ('D3', 'Sheetal', 'Shetty', 'Neurology', 'F', to_date('01-01-1980', 'dd-mm-yyyy'), 200000, 3);
insert into Doctors values ('D4', 'David', 'Smith', 'Psyatry', 'M', to_date('01-01-1970', 'dd-mm-yyyy'), 150000, 1);
insert into Doctors values ('D5', 'James', 'Dias', 'Oncology', 'm', to_date('01-01-1985', 'dd-mm-yyyy'), 150000, 2);
insert into Doctors values ('D6', 'Ali', 'Abdal', 'Dermatology', 'M', to_date('01-01-1990', 'dd-mm-yyyy'), 250000, 5);
-- not null constraint of first name and last name 	first_name varchar(50) not null , last_name	varchar(50) not null, 
-- insert into Doctors values ('D6', null, null, 'Dermatology', 'M', to_date('01-01-1990', 'dd-mm-yyyy'), 250000, 5);

insert into Patients values ('P1', 'Vishva', 'Kumar', 'Male', to_date('10-05-1990', 'dd-mm-yyyy'), 9990099900, 'A+');
insert into Patients values ('P2', 'Steven', 'Smith', 'Male', to_date('10-05-1990', 'dd-mm-yyyy'), 9990099901, 'B+');
insert into Patients values ('P3', 'Ram', 'Kumar', 'Male', to_date('11-05-1990', 'dd-mm-yyyy'), 9990099902, 'O+');
insert into Patients values ('P4', 'Raju', 'Sharma', 'Male', to_date('14-05-1990', 'dd-mm-yyyy'), 9990099903, 'O-');
insert into Patients values ('P5', 'Eshal', 'Maryam', 'Female', to_date('10-07-1990', 'dd-mm-yyyy'), 9990099904, 'A-');
insert into Patients values ('P6', 'Reshal', 'Verma', 'F', to_date('10-05-1990', 'dd-mm-yyyy'), 9990099905, 'A+');
-- Duplicate Key Constraint error due to Key P5
--insert into Patients values ('P5', 'Rajeev', 'Verma', 'F', to_date('10-05-1990', 'dd-mm-yyyy'), 9990099905, 'A+');

insert into Medical_Records values (1, 'Food Poisoning', to_date('10-01-2023', 'dd-mm-yyyy'), 'P1', 'D2');
insert into Medical_Records values (2, 'Fever and Flu', to_date('11-01-2023', 'dd-mm-yyyy'), 'P6', 'D6');
insert into Medical_Records values (3, 'Back Spasm', to_date('15-01-2023', 'dd-mm-yyyy'), 'P7', 'D6');
insert into Medical_Records values (4, 'Headache', to_date('20-01-2023', 'dd-mm-yyyy'), 'P0', 'D7');

select * from hospitals;
select * from Patients;
select * from Doctors;
select * from Medical_Records;