/* Find the popularity percentage for each user on Meta/Facebook.
The popularity percentage is defined as the total number of friends the user has divided by the
total number of users on the platform, then converted into a percentage by multiplying by 100.
Output each user along with their popularity percentage. Order records in ascending order by user id.
*/

SET search_path TO problems;
SHOW search_path;

drop table facebook_friends;
create table facebook_friends
    (
        user1       int,
        user2       int
    );

insert into facebook_friends values (2,1);
insert into facebook_friends values (1,3);
insert into facebook_friends values (4,1);
insert into facebook_friends values (1,5);
insert into facebook_friends values (1,6);
insert into facebook_friends values (2,6);
insert into facebook_friends values (7,2);
insert into facebook_friends values (8,3);
insert into facebook_friends values (3,9);
commit;

SELECT * FROM facebook_friends ff;

-- Total number of friends each user has

/*
2	1 --> 2 is frined with 1 : COUNT = 1
1	3 --> 1 is friend with 3 or 3 is frinds with 1 : COUNT = 2
4	1 --> 4 is friends with 1 : COUNT = 3
1	5 --> 5 is friends with 1 : COUNT = 4
1	6 --> 6 is friends with 1 : COUNT = 5
2	6
7	2
8	3
3	9
 * */
-- The total number of friends can be calculated by counting the 
-- freind in both the columns, 5 friends with 1. 
-- OR TRICK:: count the occurance of 1's in the UNION ALL. !!DONT USE UNION!!
SELECT users, count(users) AS total_friends FROM 
	(SELECT user1 AS users FROM facebook_friends  
	UNION ALL -- UNION ALL will bring duplicates.
	SELECT user2 AS users FROM facebook_friends ) AS x
GROUP BY users
ORDER BY total_friends desc;


-- Total number of users in the table
SELECT count (DISTINCT users) FROM 
	(SELECT user1 AS users FROM facebook_friends  
	UNION ALL -- UNION ALL will bring duplicates. TODO : CHECK why UNION can't be used
	SELECT user2 AS users FROM facebook_friends ) AS x ;

-- Apply the percentage formula


-- FINAL QUERY using CTEs
WITH
	all_users AS
		(SELECT user1 AS users FROM facebook_friends  
		UNION ALL -- UNION ALL will bring duplicates. TODO : CHECK why UNION can't be used
		SELECT user2 AS users FROM facebook_friends )
	,no_of_friends AS --depndes ON ALL_users subquery
		(SELECT users, count(users) total_friends 
		FROM all_users GROUP BY users ORDER BY total_friends desc)
	,total_users AS -- Need TO divide FOR EACH users, hinting FOR a CROSS JOIN AS its a single valus needed FOR all
		(SELECT count(DISTINCT users) AS total FROM all_users)
SELECT users
, total_friends
, round((total_friends::NUMERIC(2,1) /total)*100, 2) AS percent_total -- total coming FROM total_users subquery
FROM no_of_friends CROSS JOIN total_users; -- NO ON CLAUSE ON THIS CORSS JOIN
