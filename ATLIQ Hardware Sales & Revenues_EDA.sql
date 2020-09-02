-- preview dataset
SELECT * FROM sales.transactions LIMIT 5;

SELECT COUNT(*) FROM sales.transactions;
-- '150283'

-- transactions in chennai
SELECT * FROM sales.transactions WHERE market_code="Mark001";

SELECT COUNT(*) FROM sales.transactions WHERE market_code="Mark001";
-- '1035'

-- transactions in USD
SELECT * FROM sales.transactions where currency='USD';

SELECT COUNT(*) FROM sales.customers;
-- '38'

-- transactions by date
-- concatenate the transactions and dates records
SELECT sales.transactions.*, sales.date.* 
FROM sales.transactions INNER JOIN sales.date 
ON sales.transactions.order_date=sales.date.date;

-- all transactions in 2020
SELECT sales.transactions.*, sales.date.*
FROM sales.transactions INNER JOIN sales.date
ON sales.transactions.order_date = sales.date.date
WHERE sales.date.year = 2020;

-- total revenue in 2020
SELECT SUM(sales.transactions.sales_amount) AS total_revenue_2020
FROM sales.transactions INNER JOIN sales.date
ON sales.transactions.order_date = sales.date.date
WHERE sales.date.year = 2020;
-- '142235559'

-- total revenue in 2019
SELECT SUM(sales.transactions.sales_amount) AS total_revenue_2019
FROM sales.transactions INNER JOIN sales.date
ON sales.transactions.order_date = sales.date.date
WHERE sales.date.year = 2019;
-- '336452114'

-- over all revenues are declining

-- revenue in chennai in 2020
SELECT SUM(sales.transactions.sales_amount) AS total_revenue_2020_chennai
FROM sales.transactions INNER JOIN sales.date
ON sales.transactions.order_date = sales.date.date
WHERE sales.date.year = 2020 and sales.transactions.market_code = "Mark001";
-- '2463024'

-- revenue in chennai in 2019
SELECT SUM(sales.transactions.sales_amount) AS total_revenue_2019_chennai
FROM sales.transactions INNER JOIN sales.date
ON sales.transactions.order_date = sales.date.date
WHERE sales.date.year = 2019 and sales.transactions.market_code = "Mark001";
-- '5123768'

-- products sold in chennai
SELECT DISTINCT product_code FROM sales.transactions WHERE market_code = "MARK001";

-- garbage values
SELECT * FROM sales.transactions WHERE sales_amount <= 0;
SELECT COUNT(*) FROM sales.transactions WHERE sales_amount <= 0; -- '1611'

-- duplicate data
USE sales;
SELECT DISTINCT currency FROM transactions;
-- 'INR'
-- 'INR\r'
-- 'USD'
-- 'USD\r'
SELECT COUNT(currency) FROM transactions WHERE currency='INR'; -- '279'
SELECT COUNT(currency) FROM transactions WHERE currency='INR\r'; -- ''150000'
SELECT COUNT(currency) FROM transactions WHERE currency='USD'; -- '2'
SELECT COUNT(currency) FROM transactions WHERE currency='USD\r'; -- '2'

SELECT * FROM transactions WHERE currency='USD\r' or currency='USD'; -- duplicate records

-- revenue in 2020 without duplicates
SELECT SUM(transactions.sales_amount)
FROM transactions INNER JOIN date
ON transactions.order_date = date.date
WHERE date.year=2020 AND transactions.currency='INR\r' OR transactions.currency='USD\r';
-- '142225295'

-- revenue in Jan 2020 without duplicates
SELECT SUM(transactions.sales_amount)
FROM transactions INNER JOIN date
ON transactions.order_date = date.date
WHERE date.year=2020 AND date.month_name = 'January'
	AND (transactions.currency='INR\r' OR transactions.currency='USD\r');
-- '25656567'

-- revenue in Chennai 2020
SELECT SUM(transactions.sales_amount)
FROM transactions INNER JOIN date
ON transactions.order_date = date.date
WHERE date.year=2020 AND transactions.market_code='Mark001';
-- '2463024'

