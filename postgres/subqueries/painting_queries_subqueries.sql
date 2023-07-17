SET search_path TO painting;
SHOW search_path;

-- SUBQUERIES
-- A query inside another query.

/*
-- Types of subqueries:
1) Scalar subquery -- A subquery which returns 1 column and 1 row.
2) Multiple row subquery -- 
	a) Multi row, single column subquery -- A subquery which returns multiple rows but just a single column.
	b) Multi row, multi column subqeury  -- A subquery which returns multiple rows and multiple columns.
3) Correlated subquery -- A subquery which depends on outer query.
*/
-- Example Problems:

select * from paintings;
select * from artists;
select * from collectors;
select * from sales;

-- 1) Fetch paintings that are priced higher than the average painting price.

-- FIRST, find the average price OF the painting
select avg(listed_price) from paintings; -- 1587.5

select * -- Outer Query / Main query
from paintings
where listed_price > 
(select avg(listed_price) from paintings); -- Subquery / Inner query


-- 2) Fetch all collectors who purchased paintings.
-- solution using subqeury
select * 
from collectors c
where c.id in (select distinct collector_id from sales);

-- solution using JOINS
select distinct c.*
from collectors c
join sales s on s.collector_id = c.id;

-- 3) Fetch the total amount of sales for each artist who has sold at least one painting.
-- Display artist name and total sales amount

select distinct artist_id from sales; -- 3

-- Solution using JOINS
select (a.first_name||' '||a.last_name) as artist_name
, sum(sales_price) as total_sales_amt
from sales s
join artists a on a.id = s.artist_id
group by artist_name;

-- Solution using Subqeury

select (a.first_name||' '||a.last_name) as artist_name
, s.total_sales_amt
from artists a
join (select artist_id, sum(sales_price) as total_sales_amt -- return a resultset
	  from sales
	  group by artist_id) s on a.id = s.artist_id; --GET the id TO find the names



-- 5) Find the names of the artists who had zero sales.

-- Using Correlated subquery
select (a.first_name||' '||a.last_name) as artist_name, a.id
from artists a
where not exists (select 1
				  from sales s
				  where s.artist_id = a.id);

-- Using multi row subquery
select (a.first_name||' '||a.last_name) as artist_name, a.id
from artists a
where a.id not in (select s.artist_id
				  from sales s);


-- 6) Identify the customer who has done the most transaction value 
	without involving in any fraudulent transactions.

-- 2) Do you eliminate customers who have done any fraud transactions?
select crd.cust_id, sum(transaction_value) as total_trns_value
from Transaction_base trn
join Card_base crd on crd.card_number = trn.credit_card_id
where crd.cust_id not in (select distinct crd.cust_id
						from Fraud_base frd 
						join Transaction_base trn on frd.transaction_id = trn.transaction_id
						join Card_base crd on crd.card_number = trn.credit_card_id)
group by crd.cust_id
order by total_trns_value desc
limit 1;


-- 1) Do you eliminate only transaction which are fraud?
select crd.cust_id, sum(transaction_value) as total_trns_value
from Transaction_base trn
join Card_base crd on crd.card_number = trn.credit_card_id
where trn.transaction_id not in (select distinct trn.transaction_id
								from Fraud_base frd 
								join Transaction_base trn on frd.transaction_id = trn.transaction_id
								join Card_base crd on crd.card_number = trn.credit_card_id)
group by crd.cust_id
order by total_trns_value desc
limit 1;




--- Assignments: Using Painting Sales dataset --
4) Fetch the total amount of sales for each artist who has sold either 1 or 2 paintings only.
Display also the no of paintings sold.

6) Suppose you insert the below 2 records to the artists table. Write a query to identify the duplicate artists.
    insert into artists values (5,'Kate','Smith');
    insert into artists values (6,'Natali','Wein');

7) How would you delete the duplicate records in artists table?

                   
8) For each collector, calculate the number of paintings purchased


-- USING the CREDIT CARD dataset:
select * from Card_base; -- 500 
select * from Customer_base; -- 5674
select * from Fraud_base; -- 109
select * from Transaction_base; -- 10000


6) Identify the customer who has done the most transaction value 
	without involving in any fraudulent transactions.

-- 2) Do you eliminate customers who have done any fraud transactions?
select crd.cust_id, sum(transaction_value) as total_trns_value
from Transaction_base trn
join Card_base crd on crd.card_number = trn.credit_card_id
where crd.cust_id not in (select distinct crd.cust_id
						from Fraud_base frd 
						join Transaction_base trn on frd.transaction_id = trn.transaction_id
						join Card_base crd on crd.card_number = trn.credit_card_id)
group by crd.cust_id
order by total_trns_value desc
limit 1;


-- 1) Do you eliminate only transaction which are fraud?
select crd.cust_id, sum(transaction_value) as total_trns_value
from Transaction_base trn
join Card_base crd on crd.card_number = trn.credit_card_id
where trn.transaction_id not in (select distinct trn.transaction_id
								from Fraud_base frd 
								join Transaction_base trn on frd.transaction_id = trn.transaction_id
								join Card_base crd on crd.card_number = trn.credit_card_id)
group by crd.cust_id
order by total_trns_value desc
limit 1;