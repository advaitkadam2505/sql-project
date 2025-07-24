/*
============================================================================================
Customer Report
============================================================================================
Purpose:
	- This report highlights the key customer metrics and behaviour understanding
Highlights:
	- Gathers the personal information and the transactional information of the customer
    - Segments the customer into categories based on the engagement and spending behaviour
    - We will also group up the ages of the customers
    - Aggregates the customer-metrics like:
		- total orders placed
        - total spending
        - total items purchased
        - number of products purchased
        - lifetime of the customer (with the company)
	- Calculates the KPIs important for data driven decision making:
		- recency (months since last order)
        - average order value
        - average monthly spend
============================================================================================
*/

-- Retrieving the base CTE to create the report

WITH base_cte AS (
	SELECT 
		f.order_number,
		f.product_key,
		f.order_date,
		f.sales_amount,
		f.quantity,
		c.customer_key,
        c.customer_number,
		CONCAT(IFNULL(first_name, ''), ' ', IFNULL(last_name,'')) as full_name,
		TIMESTAMPDIFF(year, birth_date, CURDATE()) as age
	FROM gold_fact_sales as f
	LEFT JOIN gold_dim_customers as c ON c.customer_key= f.customer_key
	WHERE order_date is NOT NULL
)
, customer_aggregations AS (
	SELECT 
		customer_key,
		customer_number,
		full_name,
		age,
		COUNT(distinct order_number) as total_orders,
		SUM(sales_amount) as total_spend,
		SUM(quantity) as total_quantity,
		COUNT(distinct product_key) as products_purchased,
		TIMESTAMPDIFF(month, MIN(order_date), MAX(order_date)) as lifetime_months,
        MAX(order_date) as last_order
	FROM base_cte
	GROUP BY customer_key, customer_number, full_name, age
)

SELECT 
	customer_key, 
    customer_number, 
    full_name, 
    age,
    CASE WHEN age < 18 THEN 'Under 18'
		 WHEN age BETWEEN 18 AND 35 THEN '18-35'
         WHEN age BETWEEN 36 AND 50 THEN '36-50'
         ELSE 'Above 50'
	END as age_group,
    CASE WHEN total_spend>5000 AND lifetime_months>=12 THEN 'VIP'
		 WHEN total_spend<=5000 AND lifetime_months>=12 THEN 'Regular'
		 ELSE 'New'
	END as customer_segment,
    total_orders,
    total_spend,
    total_quantity,
    products_purchased,
    lifetime_months,
    TIMESTAMPDIFF(month, last_order, CURDATE()) as recency,
    ROUND(total_spend/NULLIF(total_orders, 0), 0) as avg_order_value,
    IFNULL(ROUND(total_spend/NULLIF(lifetime_months, 0), 0), total_spend) as avg_monthly_value
FROM customer_aggregations;
