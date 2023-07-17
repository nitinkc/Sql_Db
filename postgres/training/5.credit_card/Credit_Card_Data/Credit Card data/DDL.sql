CREATE SCHEMA IF NOT EXISTS creditcard;

SET search_path TO creditcard;
SHOW search_path;

drop table if exists Card_base;
create table if not exists Card_base
(
	Card_Number		varchar(50),
	Card_Family		varchar(30),
	Credit_Limit	int,
	Cust_ID			varchar(20)
);


drop table if exists Customer_base;
create table if not exists Customer_base
(
	Cust_ID						varchar(20),
	Age 						int,
	Customer_Segment			varchar(30),
	Customer_Vintage_Group		varchar(20)
);


drop table if exists Fraud_base;
create table if not exists Fraud_base
(
	Transaction_ID		varchar(20),
	Fraud_Flag			int
);


drop table if exists Transaction_base;
create table if not exists Transaction_base
(
	Transaction_ID			varchar(20),
	Transaction_Date		date,
	Credit_Card_ID			varchar(50),
	Transaction_Value		decimal,
	Transaction_Segment		varchar(20)
);

-- Import all the data from the CSV files into the respective tables

select count(1) from Card_base; -- 500 
select count(1) from Customer_base; -- 5674
select count(1) from Fraud_base; -- 109
select count(1) from Transaction_base; -- 10000