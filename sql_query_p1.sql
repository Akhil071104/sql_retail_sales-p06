--SQL Retail Sales Analysis - P1
CREATE DATABASE sql_project_p2;


--Create TABLE
DROP TABLE IF EXISTS retail_sales;
CREATE TABLE retail_sales
       (
         transactions_id INT PRIMARY KEY,
         sale_date	DATE,
		 sale_time	TIME,
		 customer_id INT,	
		 gender	VARCHAR(15),
		 age INT,	
		 category VARCHAR(15),
		 quantiy INT,
		 price_per_unit	FLOAT,
		 cogs FLOAT,
		 total_sale FLOAT
         );

SELECT * FROM retail_sales
LIMIT 10

SELECT COUNT(*) FROM retail_sales

SELECT * FROM retail_sales
WHERE transactions_id IS NULL

SELECT * FROM retail_sales
WHERE sale_date IS NULL

SELECT * FROM retail_sales
WHERE cogs IS NULL

SELECT * FROM retail_sales
WHERE cogs IS NULL

SELECT * FROM retail_sales
WHERE
     transactions_id IS NULL
	 OR
	 sale_date IS NULL
	 OR
	 sale_time IS NULL
	 OR
	 customer_id IS NULL
	 OR
	 gender IS NULL
	 OR
	 category IS NULL
	 OR
	 quantiy IS NULL
	 OR
	 price_per_unit IS NULL
	 OR
	 cogs IS NULL
	 OR
	 total_sale IS NULL

DELETE FROM retail_sales
WHERE
     transactions_id IS NULL
	 OR
	 sale_date IS NULL
	 OR
	 sale_time IS NULL
	 OR
	 customer_id IS NULL
	 OR
	 gender IS NULL
	 OR
	 category IS NULL
	 OR
	 quantiy IS NULL
	 OR
	 price_per_unit IS NULL
	 OR
	 cogs IS NULL
	 OR
	 total_sale IS NULL

--Data Exploration

--How many sales we have?
SELECT COUNT(*) as total_sale FROM retail_sales

--How many  unique customers we have?
SELECT COUNT(DISTINCT customer_id) as customer FROM retail_sales

--How many  unique category we have?
SELECT DISTINCT category FROM retail_sales

--Data ANALYSIS PROBLEMS
1.SQL query to retrieve all columns for sales made on '2022-11-05

SELECT * FROM retail_sales
WHERE sale_date='2022-11-05';

2.sql query to retrieve all transactions where category is clothing and quantity is sold more than 3 in month of nov-2022

SELECT 
*
FROM retail_sales
WHERE category='Clothing'
     AND
	 TO_CHAR(sale_date,'YYYY-MM') = '2022-11'
	 AND 
	 quantiy >= 4
GROUP BY 1

3.sql query to calculate the total sales for each category

SELECT
      category,
	  SUM(total_sale) as net_sale,
	  COUNT(*) as total_orders
FROM retail_sales

4.sql query to find the average age of customers who purchased items from 'beauty' category

SELECT
      ROUND (AVG(age), 2) as avg_age
FROM retail_sales
WHERE category='Beauty'

5.TO FIND THE ALL TRANSACTIONS WHRER TOTAL SALE IS GREATER THAN 1000.

SELECT * FROM retail_sales
WHERE total_sale > 1000
    
6.to find total number of transactions made by each gender in each category

SELECT
      category,
	  gender,
	  COUNT(*) as total_trans
FROM retail_sales
GROUP 
BY 
category,
gender
ORDER BY 1

7.AVERAGE SALE FOR EACH MONTH FIND OUT BEST SELLING MONTH IN EACH YEAR

SELECT 
      year,
	  month,
	  avg_sale 
FROM
(
SELECT
      EXTRACT(YEAR FROM sale_date) as year,
	  EXTRACT(MONTH FROM sale_date) as month,
	  AVG(total_sale) as avg_sale,
	  RANK() OVER(PARTITION BY  EXTRACT(YEAR FROM sale_date) ORDER BY AVG(total_sale)DESC) as RANK
FROM retail_sales
GROUP BY 1,2
) as t1
WHERE rank=1
ORDER BY 1,3 DESC

8.top 5 customers based on high total_sale

SELECT
       customer_id,
	   SUM(total_sale) as total_sales
FROM retail_sales
GROUP BY 1
ORDER BY 2 DESC
LIMIT 5

9.TO FIND NUMBER OF UNIQUE CUSTOMERS WHO PURCHASED ITEMS FROM EACH CATEGORY

SELECT
       category,
       COUNT(DISTINCT customer_id) 
FROM retail_sales
GROUP BY category

10.to create each shift and number of orders(example morning<=12,afternoon 12&17,evening>17)

WITH hourly_sale
AS
(
SELECT *,
    CASE
	     WHEN  EXTRACT(HOUR FROM sale_time)< 12 THEN 'Morning'
		 WHEN  EXTRACT(HOUR FROM sale_time) BETWEEN 12 AND 17 THEN 'Afternoon'
		 ELSE 'Evening'
	END as shift
FROM retail_sales
)
SELECT
      shift,
      COUNT(*) as total_orders
FROM hourly_sale
GROUP BY shift

--End of project
