-- =========================================================================================
-- PART-TO -WHOLE Analysis (to check the portionality of the business performance)

/*

The script below shows the proportionality of the sales across the categories which 
reflects the business has 96% of the products selling in the category Bikes while other 
categories are less than 2% contribution to the whole
This scenario can be addressed in two ways:
- The business can focus on the development of the Bikes since it is their most sold product
  and it makes sense to shut down other categories so as to minimise the deviation from the
  USP that the business holds
- The business can also be viewed as heavily reliant on the Bike category and might fail to 
  reach the vision if the demand for Bikes fall down or there is a competitor in the category.
  This suggests business to focus on other SKUs so as to get balanced proportionality.
Both the addressing methods are subject to the business context. It might be true that the business
is primarily into the Bikes and the result is observed so they can consider the first 
addressing methodolgy. While if the business is into the sports goods then maybe they should think
around the second methodology.

*/
-- =========================================================================================

WITH cte_category_sales AS (
	SELECT 
	category,
	SUM(sales_amount) as category_sales,
	(SELECT SUM(sales_amount) FROM gold_fact_sales) as total_sales
	FROM gold_fact_sales as f
	LEFT JOIN gold_dim_products as p ON p.product_key= f.product_key
	GROUP BY category
)

SELECT category,
CONCAT(ROUND((category_sales*100/total_sales), 2) , '%') as percent_contribution
FROM cte_category_sales;

-- ============================================================================================

WITH cte_country_sales AS (
	SELECT 
	country,
	SUM(sales_amount) as country_sales,
	(SELECT SUM(sales_amount) FROM gold_fact_sales) as total_sales
	FROM gold_fact_sales as f
	LEFT JOIN gold_dim_customers as c ON c.customer_key= f.customer_key
	GROUP BY country
)
SELECT country,
CONCAT(ROUND((country_sales*100/total_sales), 2) , '%') as percent_contribution
FROM cte_country_sales;
