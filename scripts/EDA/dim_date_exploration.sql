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
