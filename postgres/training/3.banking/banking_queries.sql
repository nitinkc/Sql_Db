SET search_path TO banking, public;
SHOW search_path;

-- 1) Fetch the transaction id, date and amount of all debit transactions.
select t.transaction_id, t.transaction_date 
from transactions t 
where t.credit_debit_flag = 'D';

--2) Fetch male employees who earn more than 5000 salary.
select * from employees e 
where gender = 'M' 
and salary > 5000;

--3) Fetch employees whose name starts with J or whose salary is greater than or equal to 7000.
select * from employees e 
where emp_name like 'J%'
OR salary >= 7000;

-- 4) Fetch accounts with balance in between 1000 to 3000
SELECT * FROM accounts a WHERE balance BETWEEN 1000 AND 3000;

-- 5) Using SQL, find out if a given number is even or odd ? (Given numbers are 432, 77)
WITH temp_num as(
	SELECT 432 AS num 
	UNION 
	SELECT 77 AS num
)
SELECT a.num,
	CASE
	   WHEN a.num % 2 = 0 THEN 'Even'
	   ELSE 'Odd'
	END AS number_type
FROM temp_num a;


--6) Find customers who did not provide a phone no.
SELECT * FROM customers c WHERE phone IS NULL;

--7) Find all the different products purchased by the customers.
SELECT DISTINCT (ca.prod_id) FROM customer_accounts ca;

--8) Sort all the active accounts based on highest balance and based on the earliest opening date.
SELECT * FROM accounts a 
WHERE a.account_status IN ('ACTIVE')
ORDER BY balance DESC, date_of_opening ;

--9) Fetch the oldest 5 transactions.
--sample inserts to verify result:
insert into Accounts values (1100444107, 3300, UPPER('Active'), to_date('15-11-2023','dd-mm-yyyy'));
insert into Accounts values (1100444108, 3300, UPPER('Active'), to_date('01-11-2023','dd-mm-yyyy'));

SELECT * FROM transactions t 
ORDER BY transaction_date 
LIMIT 5;

--10) Find customers who are either from Bangalore/Chennai and their phone number is available OR those who were born before 1990.


--11) Find total no of transactions in Feb 2023.

--12) How total no of products purchased by customer "Satya Sharma".

--13) Display the full names of all employees and customers.

--14) Categorise accounts based on their balance.
--[Below 1k is Low balance, between 1k to 2k is average balance, above 2k is high balance]

--15) Find the total balance of all savings account.
SELECT SUM(a.balance) AS total 
FROM accounts a 
JOIN customer_accounts ca ON ca.account_no = a.account_no  
where ca.prod_id -- using a sub query 
	IN (SELECT p.prod_id FROM products p WHERE p.prod_name = 'Savings Account');

-- using multiple join
select sum(a.balance) as tot_balance
from accounts a
join customer_accounts ca on ca.account_no=a.account_no
join products p on p.prod_id = ca.prod_id
where p.prod_name='Savings Account';

--16) Display the total account balance in all the current and savings account.
select sum(a.balance), p.prod_name  as tot_balance
from accounts a
join customer_accounts ca on ca.account_no=a.account_no
join products p on p.prod_id = ca.prod_id
where p.prod_name IN('Savings Account','Current Account')
GROUP BY p.prod_name ;
