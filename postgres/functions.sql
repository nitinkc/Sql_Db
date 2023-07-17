SET search_path TO student, public;
SHOW search_path;

select to_char(current_date, 'yyyy') as year;
select extract(year from current_date ) as year;


select round(replace('142 min', ' min', '')::decimal /60,2) as hrs