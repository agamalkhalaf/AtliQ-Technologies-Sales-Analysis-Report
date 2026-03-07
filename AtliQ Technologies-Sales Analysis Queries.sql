use sales;
go


#############################################################
-- some data cleaning steps

-- first_step : delete rows where sales_amount<=0
delete from sales.transactions
where sales_amount <=0;

-- Remove all markets outside India, as the company no longer operates internationally.
delete from sales.markets
where zone not in ('South','Central','North');



############################################################

-- overview on date table
SELECT * FROM sales.date;

-- The operational period of the company
SELECT 
MIN(date) AS first_date,
MAX(date) AS last_date,
format(DATEDIFF(MAX(date), MIN(date))/365,'N0') AS "operational period (years)"
FROM sales.date;



############################################################

-- overview on markets table
SELECT * FROM sales.markets;

-- count of all markets
select count(*) as markets_numbers from sales.markets;



############################################################
-- overview on customers table

SELECT * FROM sales.customers;

-- count of all customers
select count(*) as customers_numbers from sales.customers;



############################################################

-- overview on products table
SELECT * FROM sales.products;

-- count of all products
select count(*) as products_numbers from sales.products;



############################################################

-- overview on transactions table
SELECT * FROM sales.transactions;

-- count of all transaction
select count(*) from sales.transactions;

-- Retrive of all transaction in chennai city (using join)
select * from sales.transactions as st
inner join sales.markets as sm
on st.market_code=sm.markets_code 
and sm.markets_name='Chennai';

-- Retrieve pf all transactions in Mumbai city ( using subquerry )
SELECT * FROM sales.transactions as st
INNER JOIN sales.markets as sm
ON st.market_code = sm.markets_code
WHERE st.market_code=(
SELECT sm.markets_code
FROM sales.markets as sm
WHERE sm.markets_name = 'Mumbai');

-- Retrive of all transcation in 2020 
select * from sales.transactions
where year(order_date)=2020
order by order_date;

-- Retrieve transactions for products with total sales greater than 1000
select product_code,sum(sales_amount) as sales_amount from sales.transactions
group by product_code
having sum(sales_amount)>1000
order by sum(sales_amount)