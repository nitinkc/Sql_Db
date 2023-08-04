DROP TABLE IF EXISTS A;
DROP TABLE IF EXISTS B;

create table A (Color varchar(10));
create table B (Color varchar(10));

INSERT INTO A (color) VALUES('Red');
INSERT INTO A (color) VALUES ('Green');
INSERT INTO A (color) VALUES ('Green');
INSERT INTO A (color) VALUES ('Blue');
INSERT INTO A (color) VALUES (null);
INSERT INTO A (color) VALUES (null);

insert into B (color) values ('Violet');
insert into B (color) values ('Green');
insert into B (color) values ('Green');
insert into B (color) values ('Blue');
insert into B (color) values (null);

select * from A;
select * from B;


----------###################----------
	-- Inner Join
----------###################----------

SELECT A.Color as A_COLOR, B.Color as B_COLOR 
FROM A INNER JOIN B 
ON A.Color = B.Color;


SELECT A.Color as A_COLOR, B.Color as B_COLOR 
FROM A INNER JOIN B 
ON A.Color NOT IN ('Green','Blue');
----------###################----------
-- OUTER JOINS --
----------###################----------

-- Left Outer Join
SELECT A.Color as A_COLOR, B.Color as B_COLOR 
FROM A Left JOIN B 
ON A.Color = B.Color;
 
SELECT A.Color as A_COLOR, B.Color as B_COLOR 
FROM A LEFT OUTER JOIN B 
ON A.Color = B.Color 
WHERE B.Color IS NULL;

-- Right Outer Join
SELECT A.Color as A_COLOR, B.Color as B_COLOR 
FROM A RIGHT OUTER JOIN B 
ON A.Color = B.Color;

SELECT A.Color as A_COLOR, B.Color as B_COLOR 
FROM A RIGHT OUTER JOIN B 
ON A.Color = B.Color
AND A.Color IS NULL ;

--Full outer Join
SELECT A.Color as A_COLOR, B.Color as B_COLOR 
FROM A FULL OUTER JOIN B 
ON A.Color = B.Color;
