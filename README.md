# Oracle-PL-SQL


Advanced SQL concepts via postgresql

## Working with dBeaver

Can connect with DB and work with github database at the same time.

Import data dump from mySQL Workbench


https://nitinkc.github.io/sql/sql-revisions/


### 
Start mySql :

	  `brew services start mysql`

#### MySql Data dump initialization 

The mySqlData dump has 121 MB of data including the 1Million record table that can be used for testing performance

[Upload multipart data dump](https://nitinkc.github.io/developer%20tools/largefile-on-github/)

#### Start postgreSQL

Mac os : [Postgres app](https://postgresapp.com/downloads.html) is the best

To access the `psql` [pgadmin](https://www.pgadmin.org/download/) can alsobe used. Just the client app is fine and the DB can used from Postgres app for Mac.


### Postgres DB data dump from amazon sampleDB

[Amazon Sample DB](https://github.com/aws-samples/aws-database-migration-samples/tree/master/PostgreSQL/sampledb/v1)

```sql
\cd /Users/nichaurasia/Downloads/aws-database-migration-samples-master/PostgreSQL/sampledb/v1/

\i install-postgresql.sql
```

from terminal
```sh
# Log into the psql shell
sudo -iu postgres psql

# Or run full command
psql -h localhost -d mydb -U admin -p 5432 -a -q -f /Users/nichaurasia/Downloads/aws-database-migration-samples-master/PostgreSQL/sampledb/v1/install-postgresql.sql
```

If the path of the script is set, then the installation should be smooth and spits out the following logs `install-postgresql.sql`

##### Logs
```log
mydb=# \cd /Users/nichaurasia/Downloads/aws-database-migration-samples-master/PostgreSQL/sampledb/v1/
mydb=# \i install-postgresql.sql

 Setting appropriate search path 
---------------------------------
 
(1 row)

SET
 Creating the tables 
---------------------
 
(1 row)

psql:schema/create-table.sql:5: NOTICE:  trigger "player_id_trg" for relation "dms_sample.player" does not exist, skipping
DROP TRIGGER
psql:schema/create-table.sql:10: NOTICE:  trigger "sporting_event_id_trg" for relation "dms_sample.sporting_event" does not exist, skipping
DROP TRIGGER
psql:schema/create-table.sql:15: NOTICE:  trigger "sport_team_id_trg" for relation "dms_sample.sport_team" does not exist, skipping
DROP TRIGGER
DROP TABLE
DROP TABLE
DROP TABLE
DROP TABLE
psql:schema/create-table.sql:35: ERROR:  cannot drop table person because other objects depend on it
DETAIL:  constraint set_person_id_997578592 on table sporting_event_ticket depends on table person
view sporting_event_ticket_info depends on table person
HINT:  Use DROP ... CASCADE to drop the dependent objects too.
DROP TABLE
DROP TABLE
DROP TABLE
psql:schema/create-table.sql:51: ERROR:  cannot drop table sporting_event because other objects depend on it
DETAIL:  view sporting_event_info depends on table sporting_event
view sporting_event_ticket_info depends on view sporting_event_info
HINT:  Use DROP ... CASCADE to drop the dependent objects too.
psql:schema/create-table.sql:55: ERROR:  cannot drop table sporting_event_ticket because other objects depend on it
DETAIL:  view sporting_event_ticket_info depends on table sporting_event_ticket
HINT:  Use DROP ... CASCADE to drop the dependent objects too.
DROP TABLE
DROP TABLE
psql:schema/create-table.sql:67: ERROR:  cannot drop table sport_location because other objects depend on it
DETAIL:  constraint home_field_fk_565577053 on table sport_team depends on table sport_location
constraint se_location_id_fk_901578250 on table sporting_event depends on table sport_location
view sporting_event_info depends on table sport_location
view sporting_event_ticket_info depends on view sporting_event_info
HINT:  Use DROP ... CASCADE to drop the dependent objects too.
psql:schema/create-table.sql:71: ERROR:  cannot drop table sport_team because other objects depend on it
DETAIL:  constraint se_away_team_id_fk_885578193 on table sporting_event depends on table sport_team
constraint se_home_team_id_fk_869578136 on table sporting_event depends on table sport_team
view sporting_event_info depends on table sport_team
view sporting_event_ticket_info depends on view sporting_event_info
HINT:  Use DROP ... CASCADE to drop the dependent objects too.
psql:schema/create-table.sql:75: ERROR:  cannot drop table sport_type because other objects depend on it
DETAIL:  constraint st_sport_type_fk_581577110 on table sport_team depends on table sport_type
constraint se_sport_type_fk_853578079 on table sporting_event depends on table sport_type
HINT:  Use DROP ... CASCADE to drop the dependent objects too.
DROP TABLE
psql:schema/create-table.sql:85: NOTICE:  schema "dms_sample" already exists, skipping
CREATE SCHEMA
DROP SEQUENCE
psql:schema/create-table.sql:94: ERROR:  cannot drop sequence sporting_event_seq because other objects depend on it
DETAIL:  default value for column id of table sporting_event depends on sequence sporting_event_seq
HINT:  Use DROP ... CASCADE to drop the dependent objects too.
psql:schema/create-table.sql:98: ERROR:  cannot drop sequence sporting_event_ticket_seq because other objects depend on it
DETAIL:  default value for column id of table sporting_event_ticket depends on sequence sporting_event_ticket_seq
HINT:  Use DROP ... CASCADE to drop the dependent objects too.
psql:schema/create-table.sql:102: ERROR:  cannot drop sequence sport_location_seq because other objects depend on it
DETAIL:  default value for column id of table sport_location depends on sequence sport_location_seq
HINT:  Use DROP ... CASCADE to drop the dependent objects too.
psql:schema/create-table.sql:106: ERROR:  cannot drop sequence sport_team_seq because other objects depend on it
DETAIL:  default value for column id of table sport_team depends on sequence sport_team_seq
HINT:  Use DROP ... CASCADE to drop the dependent objects too.
CREATE SEQUENCE
psql:schema/create-table.sql:122: ERROR:  relation "sporting_event_seq" already exists
psql:schema/create-table.sql:130: ERROR:  relation "sporting_event_ticket_seq" already exists
psql:schema/create-table.sql:138: ERROR:  relation "sport_location_seq" already exists
psql:schema/create-table.sql:146: ERROR:  relation "sport_team_seq" already exists
CREATE TABLE
CREATE TABLE
CREATE TABLE
CREATE TABLE
psql:schema/create-table.sql:244: NOTICE:  relation "person" already exists, skipping
CREATE TABLE
CREATE TABLE
CREATE TABLE
CREATE TABLE
psql:schema/create-table.sql:297: NOTICE:  relation "sporting_event" already exists, skipping
CREATE TABLE
psql:schema/create-table.sql:313: NOTICE:  relation "sporting_event_ticket" already exists, skipping
CREATE TABLE
CREATE TABLE
CREATE TABLE
psql:schema/create-table.sql:352: NOTICE:  relation "sport_location" already exists, skipping
CREATE TABLE
psql:schema/create-table.sql:367: NOTICE:  relation "sport_team" already exists, skipping
CREATE TABLE
psql:schema/create-table.sql:377: NOTICE:  relation "sport_type" already exists, skipping
CREATE TABLE
CREATE TABLE
 Creating required indexes 
---------------------------
 
(1 row)

CREATE INDEX
psql:schema/create-index.sql:9: ERROR:  relation "se_start_date_fcn" already exists
psql:schema/create-index.sql:15: ERROR:  relation "set_ev_id_tkholder_id_idx" already exists
psql:schema/create-index.sql:21: ERROR:  relation "set_seat_idx" already exists
psql:schema/create-index.sql:27: ERROR:  relation "set_sporting_event_idx" already exists
psql:schema/create-index.sql:33: ERROR:  relation "set_ticketholder_idx" already exists
psql:schema/create-index.sql:39: ERROR:  relation "sport_team_u" already exists
CREATE INDEX
CREATE INDEX
ALTER TABLE
psql:schema/create-index.sql:63: ERROR:  multiple primary keys for table "person" are not allowed
ALTER TABLE
ALTER TABLE
psql:schema/create-index.sql:83: ERROR:  constraint "chk_sold_out" for relation "sporting_event" already exists
psql:schema/create-index.sql:88: ERROR:  multiple primary keys for table "sporting_event" are not allowed
psql:schema/create-index.sql:93: ERROR:  multiple primary keys for table "sporting_event_ticket" are not allowed
ALTER TABLE
ALTER TABLE
psql:schema/create-index.sql:108: ERROR:  multiple primary keys for table "sport_location" are not allowed
psql:schema/create-index.sql:113: ERROR:  multiple primary keys for table "sport_team" are not allowed
psql:schema/create-index.sql:118: ERROR:  multiple primary keys for table "sport_type" are not allowed
ALTER TABLE
 Creating dms_user user: 
-------------------------
 
(1 row)

psql:user/create-user.sql:1: ERROR:  role "dms_user" cannot be dropped because some objects depend on it
DETAIL:  privileges for schema dms_sample
privileges for sequence sporting_event_seq
privileges for sequence sporting_event_ticket_seq
privileges for sequence sport_location_seq
privileges for sequence sport_team_seq
privileges for table person
privileges for table sporting_event
privileges for table sporting_event_ticket
privileges for table sport_location
privileges for table sport_team
privileges for table sport_type
psql:user/create-user.sql:2: ERROR:  role "dms_user" already exists
GRANT
GRANT
GRANT
 Copying base data into tables 
-------------------------------
 
(1 row)

COPY 2230
COPY 5360
COPY 2928
COPY 32
COPY 6
psql:install-postgresql.sql:21: ERROR:  duplicate key value violates unique constraint "sport_location_pk"
DETAIL:  Key (id)=(1) already exists.
CONTEXT:  COPY sport_location, line 2
COPY 14
COPY 2
psql:install-postgresql.sql:31: ERROR:  duplicate key value violates unique constraint "person_pk"
DETAIL:  Key (id)=(1) already exists.
 Loading NFL and MLB teams 
---------------------------
 
(1 row)

CREATE FUNCTION
CREATE FUNCTION
psql:install-postgresql.sql:37: ERROR:  duplicate key value violates unique constraint "sport_team_u"
DETAIL:  Key (sport_type_name, sport_league_short_name, name)=(baseball, MLB, New York Mets) already exists.
CONTEXT:  SQL statement "INSERT INTO dms_sample.sport_team (name, abbreviated_name, sport_type_name, sport_league_short_name, sport_division_short_name)
        VALUES (trec.l_name, trec.a_name, 'baseball', 'MLB', v_div)"
PL/pgSQL function loadmlbteams() line 31 at SQL statement
psql:install-postgresql.sql:38: ERROR:  duplicate key value violates unique constraint "sport_team_u"
DETAIL:  Key (sport_type_name, sport_league_short_name, name)=(football, NFL, Baltimore Ravens) already exists.
CONTEXT:  SQL statement "INSERT INTO dms_sample.sport_team (name, abbreviated_name, sport_type_name, sport_league_short_name, sport_division_short_name)
    VALUES ('Baltimore Ravens', 'BAL', v_sport_type, v_league, v_division)"
PL/pgSQL function loadnflteams() line 8 at SQL statement
UPDATE 1
UPDATE 1
UPDATE 1
UPDATE 1
UPDATE 1
UPDATE 1
UPDATE 1
UPDATE 1
UPDATE 1
UPDATE 1
UPDATE 1
UPDATE 1
UPDATE 1
UPDATE 1
UPDATE 1
UPDATE 1
UPDATE 1
UPDATE 1
UPDATE 1
UPDATE 1
UPDATE 1
UPDATE 1
UPDATE 1
UPDATE 1
UPDATE 1
UPDATE 1
UPDATE 1
UPDATE 1
UPDATE 1
UPDATE 1
CREATE FUNCTION
 setnflteamhomefield 
---------------------
 
(1 row)

 Generating game seats 
-----------------------
 
(1 row)

CREATE FUNCTION
CREATE FUNCTION
psql:install-postgresql.sql:47: NOTICE:  table "seat_tab" does not exist, skipping
psql:install-postgresql.sql:47: NOTICE:  table "seat_type_tab" does not exist, skipping
 generateseats 
---------------
 
(1 row)

 generateseats 
---------------
 
(1 row)

 generateseats 
---------------
 
(1 row)

 generateseats 
---------------
 
(1 row)

 Creating players 
------------------
 
(1 row)

CREATE FUNCTION
CREATE FUNCTION
CREATE FUNCTION
 loadmlbplayers 
----------------
 
(1 row)

 loadnflplayers 
----------------
 
(1 row)

 Creating the MLB and NFL seasons 
----------------------------------
 
(1 row)

CREATE FUNCTION
CREATE FUNCTION
CREATE FUNCTION
CREATE FUNCTION
psql:install-postgresql.sql:62: ERROR:  insert or update on table "sporting_event" violates foreign key constraint "se_sport_type_fk_853578079"
DETAIL:  Key (sport_type_name)=(baseball) is not present in table "sport_type".
CONTEXT:  SQL statement "INSERT INTO dms_sample.sporting_event (sport_type_name, home_team_id, away_team_id, location_id, start_date_time, start_date)
                VALUES ('baseball', var_v_t1_id, var_v_t2_id, var_v_t1_home_id, var_v_event_date, dms_sample.edate_add(var_v_event_date::TIMESTAMP, 
                (FLOOR((RANDOM() * (19::NUMERIC - 12::NUMERIC + 1::NUMERIC))::NUMERIC) + 12::NUMERIC)::TEXT, 'HOUR'::TEXT)::TIMESTAMP WITHOUT TIME ZONE)"
PL/pgSQL function generatemlbseason() line 59 at SQL statement
CREATE FUNCTION
CREATE FUNCTION
psql:install-postgresql.sql:64: ERROR:  insert or update on table "sporting_event" violates foreign key constraint "se_sport_type_fk_853578079"
DETAIL:  Key (sport_type_name)=(football) is not present in table "sport_type".
CONTEXT:  SQL statement "INSERT INTO dms_sample.sporting_event (sport_type_name, home_team_id, away_team_id, location_id, start_date_time, start_date)
                        VALUES ('football', var_v_team1_id, var_v_team2_id, var_v_team1_home_field_id, dms_sample.edate_add(var_v_event_date::TIMESTAMP, (FLOOR((RANDOM() * (19::NUMERIC - 12::NUMERIC + 1::NUMERIC))::NUMERIC) + 12::NUMERIC)::TEXT, 'HOUR'::TEXT)::TIMESTAMP WITHOUT TIME ZONE, var_v_event_date)"
PL/pgSQL function generatenflseason() line 97 at SQL statement
 Generating game tickets for MLB and NFL 
-----------------------------------------
 
(1 row)

CREATE FUNCTION
 generatesporttickets 
----------------------
 <unnamed portal 1>
(1 row)

 generatesporttickets 
----------------------
 <unnamed portal 2>
(1 row)

 Creating functions to sell and transfer tickets 
-------------------------------------------------
 
(1 row)

CREATE FUNCTION
 generateticketactivity 
------------------------
 
(1 row)

CREATE FUNCTION
CREATE FUNCTION
 generatetransferactivity 
--------------------------
 
(1 row)

ALTER TABLE
ALTER TABLE
ALTER TABLE
ALTER TABLE
ALTER TABLE
psql:schema/foreign-keys.sql:45: ERROR:  constraint "home_field_fk_565577053" for relation "sport_team" already exists
psql:schema/foreign-keys.sql:52: ERROR:  constraint "st_sport_type_fk_581577110" for relation "sport_team" already exists
psql:schema/foreign-keys.sql:60: ERROR:  constraint "se_away_team_id_fk_885578193" for relation "sporting_event" already exists
psql:schema/foreign-keys.sql:68: ERROR:  constraint "se_home_team_id_fk_869578136" for relation "sporting_event" already exists
psql:schema/foreign-keys.sql:76: ERROR:  constraint "se_location_id_fk_901578250" for relation "sporting_event" already exists
psql:schema/foreign-keys.sql:84: ERROR:  constraint "se_sport_type_fk_853578079" for relation "sporting_event" already exists
psql:schema/foreign-keys.sql:92: ERROR:  constraint "set_person_id_997578592" for relation "sporting_event_ticket" already exists
ALTER TABLE
ALTER TABLE
ALTER TABLE
CREATE VIEW
CREATE VIEW
mydb=# 
```


# Gooogle Spanner Emulator

Pre requisites
    * Google CLI installed
    * Docker installed, up and running

```sh
#Optional
gcloud components update 

gcloud emulators spanner start
```

## Setup Cloud Spanner Project & Instance

```sh
# If confir is present then no need to run
gcloud config configurations create emulator
# Disable authentication
gcloud config set auth/disable_credentials true
# Create test project
gcloud config set project sql-spanner-project
# Set API override
gcloud config set api_endpoint_overrides/spanner http://localhost:9020/
# Set the config
gcloud config configurations activate emulator

```

### Run from DBeaver

Select the DB connection to Google Spanner. Ensure that the Driver Properties is set to true `autoConfigEmulator : true`

Connect with the DB via Emulator.

### Run from CLI
```sh
#Set Congit
gcloud config configurations activate emulator

# Create Instance
gcloud spanner instances create test-instance --config=emulator-config --description=”MySpannerDbInstance” --nodes=1
# Create DB 
gcloud spanner databases create test-database --instance test-instance --ddl "CREATE TABLE TestTable (Key INT64, Value STRING(MAX)) RIMARY KEY (Key)"
# Insert Data
gcloud spanner rows insert --table=TestTable --database=test-database --instance=test-instance --data=Key=1,Value=TestValue1

# Run SQL commands
gcloud spanner databases execute-sql test-database --instance test-instance --sql "select * from TestTable"
``` 

### Load Data into Spanner Emulator

Follow this link [https://github.com/nitinkc/springboot-spanner-db#create-spanner-table-from-cloud-console](https://github.com/nitinkc/springboot-spanner-db#create-spanner-table-from-cloud-console)
