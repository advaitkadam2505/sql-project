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
