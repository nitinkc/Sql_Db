-- Sales Schema
SET search_path TO sales, public;
SHOW search_path;

-- GROUP BY & HAVING
-- Creates a group for every unique value present in the column (or list of columns)

-- Rules for using GROUP BY
-- Only the columns mentioned in GROUP BY can be present in SELECT clause. 

-- FINDING DISTINCT
select distinct deal_size from Sales_order; -- Small, Medium, Large

select deal_size --, count(*), avg(sales)
from sales_order 
group by deal_size;


-- 1) Find the average sales order price based on deal size
select deal_size 
    , ROUND(AVG(sales)::decimal, 2) AS avg_sales --Casting AS decimal FOR rounding
from sales_order 
group by deal_size; 

select count(*), avg(sales)
from sales_order ;


-- SELECT clause cannot mention columns which are not present in GROUP BY clause.
-- OR Columns not present in GROUP By can be mentioned in SELECT only 
-- if they are enclosed within a aggregate function.

select deal_size , avg(sales) as avg_sales  -- aggregating ON deal size
from sales_order 
group by deal_size;	

select deal_size , avg(sales) as avg_sales, status -- aggregating ON deal SIZE AND status
from sales_order 
group by deal_size, status;

select deal_size , avg(sales) as avg_sales, max(status) -- WORKS
from sales_order 
group by deal_size;
