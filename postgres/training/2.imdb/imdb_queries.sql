-- Fetch all data from imdb table 
select * from imdb_top_movies;

-- Fetch only the name and release year for all movies.
select series_title, released_year
from imdb_top_movies; 


-- Fetch the name, release year and imdb rating of movies which are UA certified.
select series_title, released_year, imdb_rating
from imdb_top_movies 
where certificate = 'UA';

-- Fetch the name and genre of movies which are UA certified and have a Imdb rating of over 8.
select series_title, genre, imdb_rating
from imdb_top_movies
where certificate = 'UA'
and imdb_rating > 8;

-- Find out how many movies are of Drama genre.
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


6) How many movies are directed by 
					"Quentin Tarantino", "Steven Spielberg", "Christopher Nolan" and "Rajkumar Hirani".

select count(1) 
from imdb_top_movies 
where director in ('Quentin Tarantino', 'Steven Spielberg', 'Christopher Nolan', 'Rajkumar Hirani')

select *
from imdb_top_movies 
where director in ('Quentin Tarantino', 'Steven Spielberg', 'Christopher Nolan', 'Rajkumar Hirani')





