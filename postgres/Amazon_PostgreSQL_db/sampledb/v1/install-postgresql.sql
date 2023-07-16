-- Sample PostgreSQL database for Database Migration Service testing

-- \cd /Users/nichaurasia/Downloads/aws-database-migration-samples-master/PostgreSQL/sampledb/v1/
-- \i install-postgresql.sql

-- Creating schema and tables
select null as "Setting appropriate search path";
set search_path = dms_sample;
select null as "Creating the tables";
-- /ir stands for the relative path
\ir ./schema/create-table.sql
select null as "Creating required indexes";
\ir ./schema/create-index.sql
select null as "Creating dms_user user:";
\ir ./user/create-user.sql

-- Copying base data
select null as "Copying base data into tables";
\copy mlb_data from './data/csv/mlb_data.csv' DELIMITER ',' CSV HEADER;
\copy name_data from './data/csv/name_data.csv' DELIMITER ',' CSV HEADER;
\copy nfl_data from './data/csv/nfl_data.csv' DELIMITER ',' CSV HEADER;
\copy nfl_stadium_data from './data/csv/nfl_stadium_data.csv' DELIMITER ',' CSV HEADER;
\copy seat_type from './data/csv/seat_type.csv' DELIMITER ',' CSV HEADER;
\copy sport_location from './data/csv/sport_location.csv' DELIMITER ',' CSV HEADER;
\copy sport_division from './data/csv/sport_division.csv' DELIMITER ',' CSV HEADER;
\copy sport_league from './data/csv/sport_league.csv' DELIMITER ',' CSV HEADER;
INSERT /*+ APPEND */ INTO person(id, full_name, last_name, first_name)
SELECT row_number() OVER() as rownum
       ,first.name || ' ' || last.name
       ,last.name
       ,first.name 
FROM   name_data first, name_data last
WHERE  first.name_type != 'LAST'
AND    last.name_type  = 'LAST';

-- loading NFL and MLB teams
select null as "Loading NFL and MLB teams";
\ir ./schema/functions/loadmlbteams.sql
\ir ./schema/functions/loadnflteams.sql
select loadmlbteams();
select loadnflteams();
\ir ./schema/functions/set_mlb_team_home_field.sql
\ir ./schema/functions/setnflhomefield.sql
select setnflteamhomefield();

-- generating seats
select null as "Generating game seats";
\ir ./schema/functions/esubstr.sql
\ir ./schema/functions/generateseats.sql
select generateseats();
select generateseats();
select generateseats();
select generateseats();

-- loading mlb and nfl players
select null as "Creating players";
\ir ./schema/functions/loadmlbplayers.sql
\ir ./schema/functions/loadnflplayers.sql
select loadmlbplayers();
select loadnflplayers();

-- generating mlb and nfl seasons
select null as "Creating the MLB and NFL seasons";
\ir ./schema/functions/generatemlbseason.sql
select generatemlbseason();
\ir ./schema/functions/generatenflseason.sql
select generatenflseason();

-- generating tickets for game events
select null as "Generating game tickets for MLB and NFL";
\ir ./schema/functions/generatesporttickets.sql
-- generating football and baseball tickets
select generatesporttickets('football');
select generatesporttickets('baseball');

-- Sell tickets and generating ticket activities
select null as "Creating functions to sell and transfer tickets";
\ir ./schema/functions/generateticketactivity.sql
-- generating some initial ticket purchases
select generateticketactivity(5000);

-- Generating transfer activity procedures and views
\ir ./schema/functions/transferticket.sql
\ir ./schema/functions/generatetransferactivity.sql
select generatetransferactivity(1000);

-- adding Foreign Keys
\ir ./schema/foreign-keys.sql

-- creating required views
\ir ./schema/create-view.sql
