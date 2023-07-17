SET search_path TO imdb, public;
SHOW search_path;

-- 2) Fetch only the name and release year for all movies.
select series_title, released_year
from imdb_top_movies; 


-- 3) Fetch the name, release year and imdb rating of movies which are UA certified.
select series_title, released_year, imdb_rating
from imdb_top_movies 
where certificate = 'UA';

-- 4) Fetch the name and genre of movies which are UA certified and have a Imdb rating of over 8.
select series_title, genre, imdb_rating
from imdb_top_movies
where certificate = 'UA'
and imdb_rating > 8;

-- 5) Find out how many movies are of Drama genre.
select count(*)
from imdb_top_movies
where genre like '%Drama%' -- 724

select count(*)
from imdb_top_movies
where upper(genre) like '%DRAMA%' -- 724

select count(1)
from imdb_top_movies
where genre like '%Drama%' -- 724

select count(series_title) as no_of_movies
from imdb_top_movies
where genre like '%Drama%' -- 724

select count(certificate) as no_of_movies
from imdb_top_movies
where genre like '%Drama%' -- 644

select count(1) from imdb_top_movies where series_title is null; -- 0
select count(1) from imdb_top_movies where certificate is null; -- 101


-- 6) How many movies are directed by "Quentin Tarantino", "Steven Spielberg", "Christopher Nolan" and "Rajkumar Hirani".

select count(1) 
from imdb_top_movies 
where director in ('Quentin Tarantino', 'Steven Spielberg', 'Christopher Nolan', 'Rajkumar Hirani')

select *
from imdb_top_movies 
where director in ('Quentin Tarantino', 'Steven Spielberg', 'Christopher Nolan', 'Rajkumar Hirani')


-- 7) What is the highest imdb rating given so far?
select max(imdb_rating) as max_rating
from imdb_top_movies  movies


-- FUNCTIONS --> It returns a value. Basically performs some action/calculation.
-- Inbuilt functions  --> Functions which are available by default in database. 
	-- string functions,  -- to_char, 
	-- date functions, -- to_date
	-- aggregate functions -- min, max, sum, avg, count
	-- numeric functions
	-- window functions
-- User defined functions --> Which the user has to create. 

-- Examples of inbuilt functions are
-- to_date, min, max, length, concat, sum, substring, count, cast, lpad, rpad, trim, to_char, upper, datediff, avg, charindex, getdate(), lower, right, left, coalesce, list_agg, 


-- 8) What is the highest and lowest imdb rating given so far?
select max(imdb_rating) as highest_rating,  min(imdb_rating) as lowest_rating
from imdb_top_movies

-- 8a) Solve the above problem but display the results in different rows.
select max(imdb_rating) as highest_rating
from imdb_top_movies
union  
select min(imdb_rating) as lowest_rating
from imdb_top_movies

-- union, union all, intersect, except, minus, 

-- 8b) Solve the above problem but display the results in different rows. 
-- And have a column which indicates the value as lowest and highest.
select max(imdb_rating) as movie_rating, 'Highest rating' as high_low
from imdb_top_movies
union  
select min(imdb_rating) , 'Lowest rating' as high_low
from imdb_top_movies


--9) Find out the total business done by movies staring "Aamir Khan".
select sum(gross)
from imdb_top_movies
where star1 = 'Aamir Khan'
or star2 = 'Aamir Khan'
or star3 = 'Aamir Khan'
or star4 = 'Aamir Khan';

select sum(gross)
from imdb_top_movies
where 'Aamir Khan' IN (star1, star2, star3, star4);

select * from imdb_top_movies 
where star1 = 'Aamir Khan' or star2 = 'Aamir Khan'


--10) Find out the average imdb rating of movies which are neither directed 
--	by "Quentin Tarantino", "Steven Spielberg", "Christopher Nolan" 
--	and are not acted by any of these stars "Christian Bale", "Liam Neeson"
--		, "Heath Ledger", "Leonardo DiCaprio", "Anne Hathaway".

select avg(imdb_rating) as avg_rating
from imdb_top_movies
where director not in ('Quentin Tarantino', 'Steven Spielberg', 'Christopher Nolan')
and (star1 not in ('Christian Bale', 'Liam Neeson', 'Heath Ledger', 'Leonardo DiCaprio', 'Anne Hathaway') 
	and star2 not in ('Christian Bale', 'Liam Neeson', 'Heath Ledger', 'Leonardo DiCaprio', 'Anne Hathaway') 
	and star3 not in ('Christian Bale', 'Liam Neeson', 'Heath Ledger', 'Leonardo DiCaprio', 'Anne Hathaway') 
	and star4 not in ('Christian Bale', 'Liam Neeson', 'Heath Ledger', 'Leonardo DiCaprio', 'Anne Hathaway') 
	);

-- 11) Mention the movies involving both "Steven Spielberg" and "Tom Cruise".
select * from imdb_top_movies itm 
where director = 'Steven Spielberg'
and (star1 = 'Tom Cruise'
or star2 = 'Tom Cruise'
or star3 = 'Tom Cruise'
or star4 = 'Tom Cruise');


-- 12) Display the movie name and watch time (in both mins and hours) which have over 9 imdb rating.
select series_title
, runtime as runtime_mins -- String value
, cast(replace(runtime, ' min', '') as decimal)/60  as runtime_hrs
, round(replace(runtime, ' min', '')::decimal /60, 2)  as runtime_hrs -- ::decimal is Casting of String to Decimal
from imdb_top_movies
where imdb_rating > 9;

--13) What is the average imdb rating of movies and average runtime which are released in the last 
-- 10 years and have less than 2 hrs of runtime.
select 
 round(avg(replace(runtime, ' min', '')::decimal /60),2)  as avg_runtime_hrs -- ::decimal is Casting of String to Decimal
 , round (avg(imdb_rating),2) as avg_imdb_rating 
from imdb_top_movies
where extract(year FROM current_date) - released_year::int <= 10 -- last 10 years from current year
and round(replace(runtime, ' min', '')::decimal /60, 2) < 2;


-- 14) Identify the Batman movie which is not directed by "Christopher Nolan".
select * from imdb_top_movies itm 
where upper(series_title) like '%BATMAN%' 
--and director != 'Christopher Nolan';
and director <> 'Christopher Nolan';

-- 15) Display all the A and UA certified movies which are either directed by "Steven Spielberg", "Christopher Nolan" or which are directed by other directors but have a rating of over 8.



-- 16) What are the different certificates given to movies?
select distinct certificate
from imdb_top_movies
order by 1;

select distinct certificate
from imdb_top_movies
order by certificate;


-- 17) Display all the movies acted by Tom Cruise in the order of their release. Consider only movies which have a meta score.


--18) Segregate all the Drama and Comedy movies released in the last 10 years as per their runtime. 
--	Movies shorter than 1 hour should be termed as short film. 
--	Movies longer than 2 hrs should be termed as longer movies. 
--	All others can be termed as Good watch time.
select * from imdb_top_movies  where released_year = 'PG'


select series_title as movie_name
, case when round(replace(runtime, ' min', '')::decimal /60,2) < 1 then 'Short film'
	   when round(replace(runtime, ' min', '')::decimal /60,2) > 2 then 'Longer Movies'
       else 'Good watch time'
  end as category
from imdb_top_movies
where released_year <> 'PG'
and extract(year from current_date ) - released_year::int <= 10
and (upper(genre) like '%DRAMA%' 
    or lower(genre) like '%comedy%')
order by category;

-- LIMIT , TOP

select * from imdb_top_movies  limit 5; -- syntax in postgresql, oracle and mysql.

select top 5 * from imdb_top_movies; -- Syntax in sql server


-- 19) Write a query to display the "Christian Bale" movies which released in odd year and even year. Sort the data as per Odd year at the top.

-- 20) Re-write problem #18 without using case statement.


------------------------ Extra Assignment ------------------------ 
-- 1) Split the value '1234_1234' into 2 seperate columns having 1234 each.
SELECT
    substring('1234_1234', 1, position('_' in '1234_1234')-1) AS column1,
    substring('1234_1234', position('_' in '1234_1234')+1) AS column2;


--2) We see a string value 'PG' in released_year and we hardcoaded it, 
--can we make a query dynamic to identify string value. If we have
--multiple string values, it will be helpful

-- Write a query to identify non numeric values in a column.
-- Use of a Regular expression 
 select * from imdb_top_movies
 where released_year !~ '[0-9]';

select * from imdb_top_movies  where released_year = 'PG'


SELECT
    series_title AS movie_name,
    CASE
        WHEN round(replace(runtime, ' min', '')::decimal / 60, 2) < 1 THEN 'Short film'
        WHEN round(replace(runtime, ' min', '')::decimal / 60, 2) > 2 THEN 'Longer Movies'
        ELSE 'Good watch time'
    END AS category
FROM
    imdb_top_movies
where
	released_year ~ '[0-9]' -- Removing all the rows that has non numeric values
    AND extract(year FROM current_date) - released_year::int <= 10
    AND (upper(genre) LIKE '%DRAMA%' OR lower(genre) LIKE '%comedy%')
ORDER BY
    category;
