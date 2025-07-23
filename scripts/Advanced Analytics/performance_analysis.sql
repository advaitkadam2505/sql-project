-- =====================================================================================================================
-- PERFORMANCE ANALYSIS (to check the business performance as compared to benchmark)
/*

The below script is created to compare the business performance over the years for a specific
product with the average sales made by the respective product over the period of time. Note that 
we have considered the benchmark value as the average value.

The benchmark could be anything:
- Average value
- Maximum or minimum value
- Previous performance
- Self-set benchmark (maybe the HQ is selected as the baseline for all the stores)

*/
-- =====================================================================================================================

WITH yearly_product_sales AS (
	SELECT
	YEAR(order_date) as order_year,
	product_name,
	SUM(sales_amount) as current_sales
	FROM gold_fact_sales as f
	LEFT JOIN gold_dim_products as p ON f.product_key= p.product_key
	WHERE YEAR(order_date) is NOT NULL
	GROUP BY YEAR(order_date), product_name
)

SELECT
	order_year,
    product_name,
    current_sales,
    ROUND(AVG(current_sales) OVER(PARTITION BY product_name), 0) as avg_sales,
    (current_sales- ROUND(AVG(current_sales) OVER(PARTITION BY product_name), 0)) as diff_avg,
    CASE WHEN (current_sales- ROUND(AVG(current_sales) OVER(PARTITION BY product_name), 0))>0 THEN 'Above avg'
		 WHEN (current_sales- ROUND(AVG(current_sales) OVER(PARTITION BY product_name), 0))<0 THEN 'Below avg'
         ELSE 'Average'
	END as dev_avg
FROM yearly_product_sales
ORDER BY product_name, order_year;
