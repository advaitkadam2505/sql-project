/*
============================================================================================
Product Report
============================================================================================
Purpose:
	- This report highlights the key product metrics and behaviour understanding
Highlights:
	- Gathers the product's hierarchial information
    - Segments the customer into categories
    - Aggregates the product-metrics like:
		- total orders placed
        - total sales
        - total quantity sold
        - total customers
        - lifespan (in months)
	- Calculates the KPIs important for data driven decision making:
		- recency (months since last order)
        - average order revenue (AOR)
        - average monthly revenue
============================================================================================
*/

-- Retrieving the base CTE to create the report

WITH base_cte AS (
	SELECT 
		f.order_number,
		f.order_date,
		f.customer_key,
		f.sales_amount,
		f.quantity,
		p.product_key,
        p.product_name,
		p.category,
        p.subcategory,
		p.cost
	FROM gold_fact_sales as f
	LEFT JOIN gold_dim_products as p ON p.product_key= f.product_key
	WHERE order_date is NOT NULL
)
, product_aggregations AS (
	SELECT 
		product_key,
        category,
        subcategory,
		product_name,
		cost,
		TIMESTAMPDIFF(month, MIN(order_date), MAX(order_date)) as lifespan,
        MAX(order_date) as last_order,
        COUNT(distinct order_number) as total_orders,
        SUM(sales_amount) as total_sales,
        SUM(quantity) as total_quantity,
        COUNT(distinct customer_key) as total_unique_customers
	FROM base_cte
	GROUP BY product_key, category, subcategory, product_name, cost
)

SELECT 
	product_key, 
    category, 
    subcategory,
    product_name,
    cost,
    TIMESTAMPDIFF(month, last_order, CURDATE()) as recency,
    CASE WHEN total_sales>50000 THEN 'High Performer'
		 WHEN total_sales>=10000 THEN 'Mid Performer'
         ELSE 'Low Performer'
	END as product_segment,
    lifespan,
    total_orders,
    total_sales,
    total_quantity,
    total_unique_customers,
    ROUND(total_sales/NULLIF(total_orders, 0), 0) as avg_order_revenue,
    ROUND(total_sales/NULLIF(lifespan, 0), 0) as avg_monthly_revenue
FROM product_aggregations;
