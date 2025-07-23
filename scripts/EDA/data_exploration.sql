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
