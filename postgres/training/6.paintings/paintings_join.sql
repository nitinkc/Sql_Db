SET search_path TO painting;
SHOW search_path;
-- Using the NEW Painting Sales dataset:
select * from paintings;
select * from artists;
select * from collectors;
select * from sales;

-- 1) Fetch names of all the artists along with their painting name.
-- If an artist does not have a painting yet, display as "NA"

-- Using Coalesce
select 
	concat(a.first_name,' ',a.last_name) as artist_name
	, coalesce(p.name,'NA') as painting_name 
	-- The COALESCE function returns the first non-null value from a list
	--the COALESCE function is used to handle null values
from 
	artists a
left join 
	paintings p on p.artist_id = a.id;

-- Using CASE
select concat(a.first_name,' ',a.last_name) as artist_name
, case 
	when p.name is null then 'NA' 
	else p.name 
  end as painting_name
from artists a
left join paintings p on p.artist_id = a.id;


-- Solve the above problem without using LEFT JOIN
select concat(a.first_name,' ',a.last_name) as artist_name
, coalesce(p.name,'NA') as painting_name
from paintings p
right join artists a on p.artist_id = a.id

-- 2) Find collectors who did not purchase any paintings.
select concat(c.first_name,' ',c.last_name) as collector_name, s.id
from collectors c
left join sales s on s.collector_id = c.id
where s.collector_id is null;-- IF the collector does NOT make any purchase, collector id will be null  

-- 3) Find how much each artist made from sales. And how many paintings did they sell.

select artist_id, sum(sales_price) as total_price
from sales s
group by artist_id

select a.id, count(s.id) as no_of_painting_sold
from artists a
left join sales s on s.artist_id = a.id
group by a.id;

-- Solution 
select b.id , coalesce(total_price,0) as total_price, no_of_painting_sold
from (select artist_id, sum(sales_price) as total_price
	from sales s
	group by artist_id) a
right join 
	(select a.id, count(s.id) as no_of_painting_sold
	from artists a
	left join sales s on s.artist_id = a.id
	group by a.id) b
		on a.artist_id = b.id
order by 1;

-- Re-write using simple solution: MUCH BETTER SOLUTION
select a.id
, concat(a.first_name,' ',a.last_name) as artist_name
, coalesce(sum(sales_price),0) as total_price
, count(s.id) as no_of_painting_sold
from artists a
left join sales s on s.artist_id = a.id
group by a.id,a.first_name,a.last_name
order by a.id

select * from paintings;
select * from artists;
select * from collectors;
select * from sales;

-- 4) Display all the available paintings and all the artist. 
-- If a painting was sold then mark them as "Sold".
--    and if more than 1 painting of an artist was sold then display a "**" beside their name.

select p.id as paiting_id, p.name as painting_name
, a.id as artist_id
, trim(case when no_of_paintings > 1 then concat(a.first_name,' ',a.last_name, '**')
	   else concat(a.first_name,' ',a.last_name) 
  end) as artist_name
, s.sales_price
, case when s.id is not null then 'SOLD' end as sold_or_not
from paintings p
full join artists a on p.artist_id = a.id
left join sales s on s.painting_id = p.id 
left join ( select artist_id,count(1) as no_of_paintings
			from sales 
			group by artist_id ) x on x.artist_id = a.id


-- ASIGNMENT: Solve the above problem without using FULL JOIN