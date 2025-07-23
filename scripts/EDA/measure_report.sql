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
