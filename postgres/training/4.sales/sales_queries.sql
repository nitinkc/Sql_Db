SET search_path TO sales, public;
SHOW search_path;

select * from Sales_order;
select * from Customers;
select * from Products;
select distinct status from Sales_order;

-- INNER JOIN or JOIN
-- INNER Join always fetches MATCHING records between the 2 tables.

-- 2) Find all the orders which do not belong to customers from USA and are still in process.

select s.*
from Sales_order s
JOIN customers c -- joining second table
	on c.customer_id = s.customer -- Join condition
where coalesce(country,'x') <> 'USA' -- Replacing NULL countries WITH x FOR better comparison
and s.status = 'In Process';

select coalesce (null,null, 'INDIA', 'USA'); -- RETURNS FIRST non NULL argument
select * from Customers where country is null;
-- select count(1) from Customers where coalesce(country,'x') <> 'USA'; 95 total ; 36 = USA ; 

-- 3) Find all orders for Planes, Ships and Trains which are neither Shipped nor In Process nor Resolved.

select s.*
from Sales_order s
join Products p on p.product_code = s.product
where s.status not in ('Shipped', 'In Process', 'Resolved')
and p.product_line in ('Planes','Ships','Trains');


-- 7) Find orders which sold the product for price higher than its original price.
-- Find the original price
-- compare org price with sold price

select s.order_number, s.price_each as sold_price, p.price as org_price
, round((s.price_each - p.price)::decimal,2) as price_diff
from sales_order s
join products p on s.product = p.product_code
where s.price_each > p.price;




-- 1) Fetch all the small shipped ORDERS from August 2003 till the end of year 2003.
SELECT *
FROM sales_order
WHERE deal_size = 'Small'
AND status = 'Shipped'
AND order_date between to_date('01-08-2003', 'dd-mm-yyyy') and to_date('31-12-2003', 'dd-mm-yyyy');

select *
from sales_order
where deal_size = 'Small'
and status = 'Shipped'
and year_id=2003 -- fixating ON the YEAR AND selecting the MONTH FROM Aug onwards
and month_id >= 8;


-- 2) Find all the orders which do not belong to customers from USA and are still in process.
fetch data from  orders table
exclude USA customers
fetch orders which are in process

select s.*
from sales_order s
join customers c on c.customer_id = s.customer
where c.country <> 'USA'
and s.status = 'In Process';


3) Find all orders for Planes, Ships and Trains which are neither Shipped nor In Process nor Resolved.
        select *
        from Sales_order s
        join products p on p.product_code=s.product
        where p.product_line in ('Planes', 'Ships', 'Trains')
        and s.deal_size not in ('Shipped', 'In Process', 'Resolved');


4) Find customers whose phone number has either parenthesis "()" or a plus sign "+".
        select *
        from Customers
        where phone like '%+%' or phone like '%(%' or phone like '%)%';


5) Find customers whose phone number does not have any space.
        select *
        from Customers
        where phone not like '% %';


6) Fetch all the orders between Feb 2003 and May 2003 where the quantity ordered was an even number.
        select *
        from Sales_order
        where order_date between to_date('01-02-2003', 'dd-mm-yyyy') and to_date('31-05-2003', 'dd-mm-yyyy')
        and quantity_ordered % 2 = 0;


7) Find orders which sold the product for price higher than its original price.
        select s.order_number, s.price_each, p.price, p.product_line, p.product_code
        from Sales_order s
        join products p on p.product_code=s.product
        where s.price_each > p.price;


8) Find the average sales order price
        select round(avg(sales)::decimal,2) as avg_sales
        from Sales_order;


9) Count total no of orders.
        select count(1) as total_orders from Sales_order;


10) Find the total quantity sold.
        select sum(quantity_ordered) as total_items_sold from Sales_order;


11) Fetch the first order date and the last order date.
        select min(order_date) first_order_date, max(order_date) last_order_date
        from sales_order;
        
       
1) Fetch all the small shipped orders from August 2003 till the end of year 2003.
2) Find all the orders which do not belong to customers from USA and are still in process.
3) Find all orders for Planes, Ships and Trains which are neither Shipped nor In Process nor Resolved.
4) Find customers whose phone number has either parenthesis "()" or a plus sign "+".
5) Find customers whose phone number does not have any space.
6) Fetch all the orders between Feb 2003 and May 2003 where the quantity ordered was an even number.
7) Find orders which sold the product for price higher than its original price.
8) Find the average sales order price
9) Count total no of orders.
10) Find the total quantity sold.
11) Fetch the first order date and the last order date.


-- Extra Assignments:
1) calculate year month days difference from 2 dates eg - 2022/03/16 2023/08/27 how i write this query?
2) 


select * from Sales_order;
select * from Customers;
select * from Products;

3) Display the total sales figure for each quarter. Represent each quarter with their respective period.

select sum(sales) as total_sales
, case when qtr_id = 1 then 'JAN-MAR'
	   when qtr_id = 2 then 'APR-JUN'
	   when qtr_id = 3 then 'JUL-SEP'
	   when qtr_id = 4 then 'OCT-DEC'
  end period
from sales_order 
group by qtr_id; 

select sum(sales) as total_sales
, case when qtr_id = 1 then 'JAN-MAR'
	   when qtr_id = 2 then 'APR-JUN'
	   when qtr_id = 3 then 'JUL-SEP'
	   else 'OCT-DEC'
  end period
from sales_order 
group by qtr_id; 


select sum(sales) as total_sales
, case when extract(month from s.order_date) between 1 and 3 then 'JAN-MAR'
	   when extract(month from s.order_date) between 4 and 6 then 'APR-JUN'
	   when extract(month from s.order_date) between 7 and 9 then 'JUL-SEP'
	   when extract(month from s.order_date) between 10 and 12 then 'OCT-DEC'
  end as qtr
from sales_order s
group by 

case when extract(month from s.order_date) between 1 and 3 then 'JAN-MAR'
			   when extract(month from s.order_date) between 4 and 6 then 'APR-JUN'
			   when extract(month from s.order_date) between 7 and 9 then 'JUL-SEP'
			   when extract(month from s.order_date) between 10 and 12 then 'OCT-DEC'
		  end;

select qtr_id, sum(sales) as total_sales
, case when extract(month from s.order_date) between 1 and 3 then 'JAN-MAR'
	   when extract(month from s.order_date) between 4 and 6 then 'APR-JUN'
	   when extract(month from s.order_date) between 7 and 9 then 'JUL-SEP'
	   when extract(month from s.order_date) between 10 and 12 then 'OCT-DEC'
  end as qtr
from sales_order s
group by qtr_id, case when extract(month from s.order_date) between 1 and 3 then 'JAN-MAR'
					   when extract(month from s.order_date) between 4 and 6 then 'APR-JUN'
					   when extract(month from s.order_date) between 7 and 9 then 'JUL-SEP'
					   when extract(month from s.order_date) between 10 and 12 then 'OCT-DEC'
				  end
order by qtr_id;				


select qtr_id, sum(sales) as total_sales
, case when extract(month from s.order_date) between 1 and 3 then 'JAN-MAR'
	   when extract(month from s.order_date) between 4 and 6 then 'APR-JUN'
	   when extract(month from s.order_date) between 7 and 9 then 'JUL-SEP'
	   when extract(month from s.order_date) between 10 and 12 then 'OCT-DEC'
  end as qtr
from sales_order s
group by qtr_id, qtr
order by qtr_id;



select * from Sales_order;
select * from Customers;
select * from Products;

-- 4) Identify how many cars, Motorcycles, trains and ships are available in the inventory.
-- Treat all type of cars as just "Cars".


select 
	case 
		when product_line like '%Cars%' then 'Cars' 
		else product_line 
	end as products
, count(1) as no_of_vehicles
from Products
where product_line in ('Motorcycles','Trains','Ships','Classic Cars','Vintage Cars')
group by products;


select case when product_line like '%Cars%' then 'Cars' 
			else product_line 
	   end as products
, count(1) as no_of_vehicles
from Products
where product_line in ('Motorcycles','Trains','Ships','Classic Cars','Vintage Cars')
group by 
	case 
		when product_line like '%Cars%' then 'Cars' 
		else product_line 
	end;


-- Solution using UNION:
select product_line
	, count(1) as no_of_vehicles
	from Products
	where product_line in ('Motorcycles','Trains','Ships')
	group by product_line
union
select 'Cars' as prd, count(1) as no_of_vehicles
	from products 
	where product_line like '%Cars%'




select * from Sales_order;
select * from Customers;
select * from Products;

-- 6) Find the countries which have done more than 10 motorcycles orders.

select c.country, count(1) as no_of_orders
from Sales_order s
join Customers c on c.customer_id = s.customer
join products p on p.product_code = s.product
where p.product_line = 'Motorcycles'
group by c.country
having count(1) > 10
order by no_of_orders desc;


-- Order of Execution:
SELECT 		-- 6 
FROM 		-- 1
JOIN		-- 2
WHERE 		-- 3
GROUP BY	-- 4
HAVING		-- 5
ORDER BY	-- 7
LIMIT 		-- 8


select * from Sales_order;
select * from Customers;
select * from Products;

11) Find out the vehicles which was sold the most and which was sold the least. 
	Output should be a single record which 2 columns. One column for most sold vehicle and other for least sold vehicle.

-- count -- no of records
-- sum -- add the values 		 

-- Sub query - A query inside a query


select max(x.total_sold) highest_sold, min(x.total_sold) lowest_sold
from (
	SELECT sum(s.quantity_ordered) as total_sold, p.product_line
	FROM Sales_order S
	JOIN products P on p.product_code = s.product
	group by  p.product_line
	order by total_sold
	) x;


-- Extra problem
1) From given string "2-10B,Bangalore:JP Nagar#Slikboard,500072" please help me to print "JP NAGAR"

select position(':' in '2-10B,Bangalore:JP Nagar#Slikboard,500072') -- 16
select position('#' in '2-10B,Bangalore:JP Nagar#Slikboard,500072') -- 25
select length('2-10B,Bangalore:JP Nagar#Slikboard,500072') -- 41

select substring('2-10B,Bangalore:JP Nagar#Slikboard,500072'
				 , position(':' in '2-10B,Bangalore:JP Nagar#Slikboard,500072') + 1
				 , position('#' in '2-10B,Bangalore:JP Nagar#Slikboard,500072') - position(':' in '2-10B,Bangalore:JP Nagar#Slikboard,500072') - 1);

				 
--- ASSIGNMENTS --- 

1) Find the average sales order price based on deal size
2) Find total no of orders per each day. Sort data based on highest orders.
3) Display the total sales figure for each quarter. Represent each quarter with their respective period.
4) Identify how many cars, Motorcycles, trains and ships are available in the inventory.
Treat all type of cars as just "Cars".
5) Identify the vehicles in the inventory which are short in number.
Shortage of vehicle is considered when there are less than 10 vehicles.
6) Find the countries which have purchased more than 10 motorcycles.
7) Find the orders where the sales amount is incorrect.
8) Fetch the total sales done for each day.
9) Fetch the top 3 months which have been doing the lowest sales.
10) Find total no of orders per each day of the week (monday to sunday). Sort data based on highest orders.
11) Find out the vehicles which was sold the most and which was sold the least. Output should be a single record which 2 columns. One column for most sold vehicle and other for least sold vehicle.
				 
				 
