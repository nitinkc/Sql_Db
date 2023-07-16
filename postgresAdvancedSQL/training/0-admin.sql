-- Create a Schema
create schema training;

ALTER SCHEMA training RENAME TO hospital;

select * from information_schema.tables
where table_schema='public';



