select last_day(dt, month) Date_Ranges,
EXTRACT(day from dt),
 EXTRACT(ISOYEAR FROM dt) AS isoyear,
  EXTRACT(ISOWEEK FROM dt) AS isoweek,
  EXTRACT(YEAR FROM dt) AS year,
  EXTRACT(WEEK FROM dt) AS week
from unnest(generate_date_array('2023-01-01', current_date(), interval 1 month)) dt;