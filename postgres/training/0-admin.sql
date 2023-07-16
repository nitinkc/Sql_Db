-- Create a Schema
create schema training;

ALTER SCHEMA training RENAME TO hospital;

select * from information_schema.tables
where table_schema='public';


create user random_auditors with password 'audit';

-- Providing Access to the VIEW
grant select on patient_record_view to random_auditors;

GRANT USAGE ON SCHEMA hospital TO random_auditors;

-- After the Audit is done, remove the access
revoke select on patient_record_view from random_auditors;


-- Create a Schema
create schema imdb;
create schema banking;
create schema sales;
create schema painting;
CREATE SCHEMA creditCard;
CREATE SCHEMA joins;