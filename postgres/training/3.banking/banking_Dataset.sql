DROP TABLE IF EXISTS CUSTOMER_ACCOUNTS;
DROP TABLE IF EXISTS TRANSACTIONS;
DROP TABLE IF EXISTS ACCOUNTS;
DROP TABLE IF EXISTS CUSTOMERS;
DROP TABLE IF EXISTS PRODUCTS;
DROP TABLE IF EXISTS EMPLOYEES;


CREATE TABLE PRODUCTS
(
	PROD_ID		VARCHAR(10) PRIMARY KEY,
	PROD_NAME	VARCHAR(100) NOT NULL
);

CREATE TABLE EMPLOYEES
(
	EMP_ID		VARCHAR(10),
	EMP_NAME	VARCHAR(100),
	SALARY		FLOAT,
	GENDER		VARCHAR(10) CHECK (GENDER IN ('M', 'F')),
	CONSTRAINT PK_EMP PRIMARY KEY (EMP_ID)
);

CREATE TABLE CUSTOMERS
(
	CUSTOMER_ID		VARCHAR(10),
	FIRST_NAME		VARCHAR(40),
	LAST_NAME		VARCHAR(40),
	PHONE			BIGINT,
	ADDRESS			VARCHAR(200),
	DOB				DATE,
	CONSTRAINT PK_CUST PRIMARY KEY(CUSTOMER_ID)
);

CREATE TABLE ACCOUNTS
(
	ACCOUNT_NO			BIGINT PRIMARY KEY,
	BALANCE				INT,
	ACCOUNT_STATUS		VARCHAR(10) CHECK (ACCOUNT_STATUS IN ('ACTIVE', 'INACTIVE', 'SUSPENDED', 'ON HOLD')),
	DATE_OF_OPENING		DATE
);

CREATE TABLE TRANSACTIONS
(
	TRANSACTION_ID		INT GENERATED ALWAYS AS IDENTITY,
	TRANSACTION_DATE	DATE,
	TRANSACTION_AMOUNT	FLOAT,
	CREDIT_DEBIT_FLAG	VARCHAR(1),
	ACCOUNT_NO			BIGINT,
	CONSTRAINT FK_ACC FOREIGN KEY (ACCOUNT_NO) REFERENCES ACCOUNTS(ACCOUNT_NO)
);

CREATE TABLE CUSTOMER_ACCOUNTS
(
	CUSTOMER_ID		VARCHAR(10),
	ACCOUNT_NO		BIGINT,
	PROD_ID			VARCHAR(10),
	CONSTRAINT FK_ACC1 FOREIGN KEY (CUSTOMER_ID) REFERENCES CUSTOMERS(CUSTOMER_ID),
	CONSTRAINT FK_ACC2 FOREIGN KEY (ACCOUNT_NO) REFERENCES ACCOUNTS(ACCOUNT_NO),
	CONSTRAINT FK_ACC3 FOREIGN KEY (PROD_ID) REFERENCES PRODUCTS(PROD_ID)
);

------------#################################--------------
----------------------- INSERT DATA -----------------------
------------#################################--------------

insert into products values ('PRD0001', 'Savings Account');
insert into products (prod_id, prod_name) values ('PRD0002', 'Current Account');
insert into products values ('PRD0003', 'Home Loan');
insert into products values ('PRD0004', 'Personal Loan');

insert into Employees values
	('E1', 'Mohan Kumar', 5000, 'M'),
	('E2', 'James Bond', 6000, 'M'),
	('E3', 'David Smith', 7000, 'M'),
	('E4', 'Alice Mathew', 5000, 'F');

insert into Customers values ('C1', 'Satya', 'Sharma', 9900889911, 'Bangalore', to_date('01-03-1990', 'dd-mm-yyyy'));
insert into Customers values ('C2', 'Jaswinder', 'Singh', 9900889922, 'Mumbai', to_date('024-03-1980', 'dd-mm-yyyy'));
insert into Customers values ('C3', 'Satya', 'Sharma', 9900889933, 'Pune', to_date('11-08-1992', 'dd-mm-yyyy'));
insert into Customers values ('C4', 'Maryam', 'Parveen', 9900889944, 'Delhi', to_date('01-12-1993', 'dd-mm-yyyy'));
insert into Customers values ('C5', 'Steven', 'Smith', null, 'Chennai', to_date('20-12-1994', 'dd-mm-yyyy'));
insert into Customers values ('C6', 'Jason', 'Holder', null, 'Chennai', to_date('01-02-1995', 'dd-mm-yyyy'));

insert into Accounts values (1100444101, 100, upper('Active'), to_date('01-01-2020','dd-mm-yyyy'));
insert into Accounts values (1100444102, 900, upper('Active'), to_date('10-01-2020','dd-mm-yyyy'));
insert into Accounts values (1100444103, 500, upper('Active'), to_date('21-11-2021','dd-mm-yyyy'));
insert into Accounts values (1100444104, 1100, upper('Active'), to_date('15-10-2022','dd-mm-yyyy'));
insert into Accounts values (1100444105, 2200, upper('Active'), to_date('10-12-2022','dd-mm-yyyy'));
insert into Accounts values (1100444106, 3300, upper('Active'), to_date('05-11-2022','dd-mm-yyyy'));

insert into Transactions values (default,current_date, 200, 'C', 1100444101);
insert into Transactions (Transaction_Date, Transaction_Amount, Credit_Debit_flag, Account_No) values (current_date-1, 100, 'C', 1100444101);
insert into Transactions (Transaction_Date, Transaction_Amount, Credit_Debit_flag, Account_No) values (current_date-1, 50, 'D', 1100444101);
insert into Transactions (Transaction_Date, Transaction_Amount, Credit_Debit_flag, Account_No) values (current_date-1, 100, 'C', 1100444102);
insert into Transactions (Transaction_Date, Transaction_Amount, Credit_Debit_flag, Account_No) values (current_date-2, 200, 'C', 1100444102);
insert into Transactions (Transaction_Date, Transaction_Amount, Credit_Debit_flag, Account_No) values (current_date-2, 100, 'D', 1100444102);
insert into Transactions (Transaction_Date, Transaction_Amount, Credit_Debit_flag, Account_No) values (current_date-3, 100, 'C', 1100444103);
insert into Transactions (Transaction_Date, Transaction_Amount, Credit_Debit_flag, Account_No) values (current_date-4, 200, 'C', 1100444104);
insert into Transactions (Transaction_Date, Transaction_Amount, Credit_Debit_flag, Account_No) values (current_date-5, 100, 'C', 1100444105);
insert into Transactions (Transaction_Date, Transaction_Amount, Credit_Debit_flag, Account_No) values (current_date-5, 200, 'D', 1100444105);

insert into Customer_Accounts values ('C1', 1100444101, 'PRD0001');
insert into Customer_Accounts values ('C1', 1100444102, 'PRD0003');
insert into Customer_Accounts values ('C1', 1100444103, 'PRD0004');
insert into Customer_Accounts values ('C2', 1100444105, 'PRD0002');
insert into Customer_Accounts values ('C3', 1100444106, 'PRD0002');
insert into Customer_Accounts values ('C1', 1100444104, 'PRD0004');


select * from products;
select * from Employees;
select * from Customers;
select * from Accounts;
select * from Transactions;
select * from Customer_Accounts;
