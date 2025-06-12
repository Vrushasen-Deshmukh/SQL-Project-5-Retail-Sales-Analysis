SELECT * FROM Retail_Sale_Data

ALTER TABLE Retail_Sale_Data
ALTER COLUMN sale_date DATE

ALTER TABLE Retail_Sale_Data
ALTER COLUMN sale_time TIME

SELECT * FROM Retail_Sale_Data

ALTER TABLE Retail_Sale_Data
ALTER COLUMN sale_time TIME(0);
-- ----------------------------------------------------

-- DATA CLEANING
-- Checking null values
SELECT * FROM Retail_Sale_Data
WHERE transactions_id IS NULL
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

DELETE FROM [dbo].[Retail_Sale_Data]
WHERE transactions_id IS NULL
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

SELECT COUNT(*) FROM [dbo].[Retail_Sale_Data]
-- --------------------------------------------------------

-- DATA EXPLORATION

-- 1. Find out total sales.
SELECT COUNT(*) as total_sale FROM Retail_Sale_Data

-- 2. Find out no. of unique customers.
SELECT COUNT(DISTINCT customer_id) FROM Retail_Sale_Data

-- 3. Find out no. unique categories.
SELECT DISTINCT category FROM Retail_Sale_Data
-- -------------------------------------------------------


-- 1. Write a SQL query to retrieve all columns for sales made on '2022-11-05'.
SELECT * FROM Retail_Sale_Data
WHERE sale_date = '2022-11-05'


-- 2. Write a SQL query to retrieve all transactions where the category is 'Clothing' and the quantity sold > 10 in the month of Nov-2022
SELECT * 
FROM Retail_Sale_Data
WHERE category = 'Clothing'
AND quantiy > 2
AND sale_date BETWEEN '2022-11-01' AND '2022-11-30'
ORDER BY sale_date

-- 3. Write a SQL query to calculate the total sales(total_sales) for each category.
SELECT category, SUM(total_sale) as total_sales
FROM Retail_Sale_Data
GROUP BY category

-- 4. Write a SQL query to find the average age of customers who purchased items from the 'Beauty' category.
SELECT ROUND(AVG(age),2) as average_age
FROM Retail_Sale_Data
WHERE category = 'Beauty'

-- 5. Write a SQL query to find all transactions where the total_sale > 1000.
SELECT *
FROM Retail_Sale_Data
WHERE total_sale > 1000

-- 6. Write a SQL query to find the total number of transactions(transactions_id) made by each gender in each category.
SELECT gender, category, COUNT(transactions_id) as total_transactions
FROM Retail_Sale_Data
GROUP BY gender, category
ORDER BY category

-- 7. Write a SQL query to calculate the average sale for each month. Find out best selling month in each year.
SELECT 
	YEAR(sale_date) AS sale_year,
	MONTH(sale_date) AS sale_month,
	ROUND(AVG(total_sale),2) AS avg_monthly_sale
FROM Retail_Sale_Data
GROUP BY YEAR(sale_date), MONTH(sale_date)
ORDER BY sale_year, sale_month

-- 8. Write a SQL query to find the top 5 customers based on the highest total sales.
SELECT TOP 5 
customer_id, SUM(total_sale) as total_sale
FROM Retail_Sale_Data
GROUP BY customer_id
ORDER BY customer_id

-- 9. Write a SQL query to find the number of unique customers who purchased items from each category.
SELECT category, COUNT(DISTINCT customer_id) as unique_customers
FROM Retail_Sale_Data
GROUP BY category

-- 10. Write a SQL query to create each shift and number of orders(Example Morning<=12, Afternoon Between 12 & 17, Evening >17)
SELECT 
    CASE 
        WHEN DATEPART(HOUR, sale_time) < 12 THEN 'Morning'
        WHEN DATEPART(HOUR, sale_time) BETWEEN 12 AND 17 THEN 'Afternoon'
        ELSE 'Evening'
    END AS shift,
    COUNT(*) AS number_of_orders
FROM 
    Retail_Sale_Data
GROUP BY 
    CASE 
        WHEN DATEPART(HOUR, sale_time) < 12 THEN 'Morning'
        WHEN DATEPART(HOUR, sale_time) BETWEEN 12 AND 17 THEN 'Afternoon'
        ELSE 'Evening'
    END;
