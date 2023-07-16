DROP VIEW if exists hospital.patient_record_view;

create or replace view patient_record_view as
SELECT
    p.id AS patient_id,
    (p.first_name || ' ' || p.last_name) AS patient_name,
    CASE
        WHEN p.gender = 'F' THEN 'Female'
        WHEN p.gender = 'M' THEN 'Male'
        ELSE p.gender
    END AS gender,
    COALESCE(mr.problem, 'No Problem') AS problem
FROM
    patients p
LEFT JOIN
    medical_records mr ON p.id = mr.patient_id;

select * from patient_record_view;

select * from information_schema.tables 
where table_schema='hospital'
and table_type = 'VIEW';