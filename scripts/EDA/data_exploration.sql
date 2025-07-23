-- ========================================================================
-- EXPLORING THE METADATA OF THE PROJECT DATABASE -> 'DataWarehouse'
-- ========================================================================

/*

Purpose of this script is to explore the data we have created in the DataWarehouse.
SQL stores the data information in the metadata which can be explored before diving
into the advanced analytics and basic exploration of the business scenarios.

*/

-- In the below query, we are simply looking for the tables stored under the project database

SELECT * FROM INFORMATION_SCHEMA.TABLES
WHERE TABLE_SCHEMA='DataWarehouse';

-- In the below query, we are looking for the columns present, which sums up to 101 columns so far.

SELECT * FROM INFORMATION_SCHEMA.COLUMNS
WHERE TABLE_SCHEMA='DataWarehouse'
-- AND TABLE_NAME= 'gold_dim_customers' -- This query specifically extracts the data specifically for the TABLE_NAME specified

-- ====================================================================================================================
-- EXPLORATORY DATA ANALYSIS (EDA) ON THE PROJECT DATABASE -> 'DataWarehouse'
-- ====================================================================================================================

-- ====================================================================================================================
-- Dimensions Exploration.
/*
  
  In this section of the script we intent to explore the dimesnions of the table
  before diving into the explorations based on aggregations to have a rough idea of the cadinality.
  The dimensions explored are low cardinality ones (like in country) while products are arranged
  into hierarychy of category then subcategory then product_name
  
*/

SELECT distinct country 
FROM gold_dim_customers;

SELECT distinct category, subcategory, product_name
FROM gold_dim_products
ORDER BY category, subcategory, product_name;

-- ====================================================================================================================

-- Date Exploration

SELECT MIN(order_date) as first_order_date,
MAX(order_date) as last_order_date,
TIMESTAMPDIFF(year, MIN(order_date), MAX(order_date)) as years_of_data
FROM gold_fact_sales;

SELECT 
MIN(birth_date) as eldest_birth_date,
TIMESTAMPDIFF(year,MIN(birth_date), CURDATE()) as eldest_customer,
MAX(birth_date) as youngest_birth_date,
TIMESTAMPDIFF(year,MAX(birth_date), CURDATE()) as youngest_customer
FROM gold_dim_customers;

-- ====================================================================================================================

-- Report on the measures exploration. The below report has multiple dimension aggregations applied to have
-- brief overview on the measures in the gold layer. We will be deep diving into Advanced Analytics

SELECT 'Total Sales' as measure_name, SUM(sales_amount) as measure_value FROM gold_fact_sales
UNION ALL
SELECT 'Total Quantity' as measure_name, SUM(quantity) as measure_value FROM gold_fact_sales
UNION ALL
SELECT 'Avg Order Price' as measure_name, ROUND(AVG(price), 0) as measure_value FROM gold_fact_sales
UNION ALL
SELECT 'Total Orders' as measure_name, COUNT(distinct order_number) as measure_value FROM gold_fact_sales
UNION ALL
SELECT 'Total Products' as measure_name, COUNT(distinct product_key) as measure_value FROM gold_dim_products
UNION ALL
SELECT 'Total Customers' as measure_name, COUNT(distinct customer_key) as measure_value FROM gold_dim_customers
UNION ALL
SELECT 'Ordering Customers' as measure_name, COUNT(distinct customer_key) as measure_value FROM gold_fact_sales;

-- ====================================================================================================================
-- DIMENSION WISE MEASURE AGGREGATIONS

-- Country-wise customer count

SELECT country,
COUNT(customer_key) as total_customers
FROM gold_dim_customers
GROUP BY country
ORDER BY COUNT(customer_key) DESC;

-- Gender-wise customer count

SELECT gender,
COUNT(customer_key) as total_customers
FROM gold_dim_customers
GROUP BY gender
ORDER BY COUNT(customer_key) DESC;

-- MaritalStatus-wise customer count

SELECT marital_status,
COUNT(customer_key) as total_customers
FROM gold_dim_customers
GROUP BY marital_status
ORDER BY COUNT(customer_key) DESC;

-- Category wise product distribution

SELECT category,
COUNT(product_key) as total_products
FROM gold_dim_products
GROUP BY category
ORDER BY COUNT(product_key) DESC;

-- Category wise mean cost

SELECT category,
ROUND(AVG(cost), 0) as average_costs
FROM gold_dim_products
GROUP BY category
ORDER BY AVG(cost) DESC;

-- Category wise revenue generated

SELECT 
p.category,
SUM(f.sales_amount) as total_revenue
FROM gold_fact_sales as f
LEFT JOIN gold_dim_products as p
ON p.product_key=f.product_key
GROUP BY p.category
ORDER BY SUM(f.sales_amount) DESC;

-- Customer wise revenue generated

SELECT
c.customer_key,
CONCAT(IFNULL(c.first_name,''), ' ', IFNULL(c.last_name,'')) as full_name,
SUM(f.sales_amount) as total_revenue
FROM gold_fact_sales as f
LEFT JOIN gold_dim_customers as c
ON f.customer_key= c.customer_key
GROUP BY c.customer_key, c.first_name, c.last_name
ORDER BY SUM(f.sales_amount) DESC;

-- Country wise distribution of the quantity

SELECT country,
SUM(quantity) as items_sold
FROM gold_fact_sales as f
LEFT JOIN gold_dim_customers as c ON c.customer_key= f.customer_key
GROUP BY country
ORDER BY items_sold DESC;

-- ====================================================================================================================
-- QUERYING THE TOP PERFORMERS

-- Finding the top 5 performing products

SELECT product_name
FROM (SELECT product_name,
SUM(sales_amount) as total_sales,
DENSE_RANK() OVER(ORDER BY SUM(sales_amount) DESC) as rnk
FROM gold_fact_sales as f
LEFT JOIN gold_dim_products as p ON p.product_key= f.product_key
GROUP BY product_name) t
WHERE rnk<=5;

-- Finding the top 10 customers based on revenue-generated

SELECT full_name
FROM (
	SELECT
	c.customer_key,
	CONCAT(IFNULL(c.first_name,''), ' ', IFNULL(c.last_name,'')) as full_name,
	SUM(f.sales_amount) as total_revenue,
    DENSE_RANK() OVER(ORDER BY SUM(f.sales_amount) DESC) as rnk
	FROM gold_fact_sales as f
	LEFT JOIN gold_dim_customers as c
	ON f.customer_key= c.customer_key
	GROUP BY c.customer_key, c.first_name, c.last_name
) t 
WHERE rnk<=10;
-- ====================================================================================================================
