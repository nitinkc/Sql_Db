create schema imdb;

drop table if exists imdb_top_movies;
create table if not exists imdb_top_movies
(
	Poster_Link		varchar(4000),		
	Series_Title	varchar(500),
	Released_Year	varchar(20),
	Certificate		varchar(10),
	Runtime			varchar(20),
	Genre			varchar(100),
	IMDB_Rating		decimal,
	Overview		varchar(4000),
	Meta_score		int,
	Director		varchar(200),
	Star1			varchar(200),
	Star2			varchar(200),
	Star3			varchar(200),
	Star4			varchar(200),
	No_of_Votes		int,
	Gross			money
);

-- Use import Data as CSV option by right clicking on table name
