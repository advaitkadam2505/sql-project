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
