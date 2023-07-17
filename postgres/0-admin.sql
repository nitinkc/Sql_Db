-- Create a Schema
CREATE SCHEMA training;

CREATE SCHEMA IF NOT EXISTS imdb;
CREATE SCHEMA IF NOT EXISTS banking;
CREATE SCHEMA IF NOT EXISTS sales;
create SCHEMA IF NOT EXISTS painting;
CREATE SCHEMA IF NOT EXISTS creditCard;
CREATE SCHEMA IF NOT EXISTS joins;
CREATE SCHEMA IF NOT EXISTS hospital;
CREATE SCHEMA IF NOT EXISTS student;
CREATE SCHEMA IF NOT EXISTS problems;


SET search_path TO myschema, public;
SHOW search_path;

--ALTER SCHEMA myschema RENAME TO student;
--ALTER SCHEMA training RENAME TO hospital;

select * from information_schema.tables
where table_schema='public';


--###############################################--
--################## CREATING USERS #############--
--###############################################--

create user random_auditors with password 'audit';

-- Providing Access to the VIEW
grant select on patient_record_view to random_auditors;

GRANT USAGE ON SCHEMA hospital TO random_auditors;

-- After the Audit is done, remove the access
revoke select on patient_record_view from random_auditors;
