/*
 * Instriped from https://stackoverflow.com/questions/13997365/sql-joins-as-venn-diagram
 * */

CREATE SCHEMA IF NOT EXISTS joins;

SET search_path TO joins, public;
SHOW search_path;

SET search_path TO joins;
SHOW search_path;

DROP TABLE IF EXISTS A;
create table A
(Colour varchar(10));

DROP TABLE IF EXISTS B;
create table B
(Colour varchar(10));

insert into A values ('Red'),('Green'),('Green'),('Blue'),(null),(null);
insert into B values ('Violet'),('Green'),('Green'),('Blue'),(null);

select * from A;
select * from B;

---------------------
-- Inner Join
SELECT A.Colour, B.Colour 
FROM A INNER JOIN B 
ON A.Colour = B.Colour;


SELECT A.Colour, B.Colour 
FROM A INNER JOIN B 
ON A.Colour NOT IN ('Green','Blue');
----------###################----------
-- OUTER JOINS --
----------###################----------

-- Left Outer Join
SELECT A.Colour, B.Colour 
FROM A Left JOIN B 
ON A.Colour = B.Colour;
 
SELECT A.Colour, B.Colour 
FROM A LEFT OUTER JOIN B 
ON A.Colour = B.Colour 
WHERE B.Colour IS NULL;

-- Right Outer Join
SELECT A.Colour, B.Colour 
FROM A RIGHT OUTER JOIN B 
ON A.Colour = B.Colour;

SELECT A.Colour, B.Colour 
FROM A RIGHT OUTER JOIN B 
ON A.Colour = B.Colour
AND a.colour IS NULL ;

--Full outer Join
SELECT A.Colour, B.Colour 
FROM A FULL OUTER JOIN B 
ON A.Colour = B.Colour;
