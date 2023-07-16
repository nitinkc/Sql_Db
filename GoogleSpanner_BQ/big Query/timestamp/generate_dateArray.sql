
select last_day(dt, month) Date_Ranges
from unnest(generate_date_array('2020-01-01', current_date(), interval 1 month)) dt;



--Find the dates of all Jun 11's since 1985
select  FORMAT_DATE('%A, %h %d %Y', dt)
from unnest(generate_date_array('1985-06-11', current_date(), interval 1 YEAR)) dt;