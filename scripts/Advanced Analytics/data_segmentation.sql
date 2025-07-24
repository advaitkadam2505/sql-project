-- =================================================================================================================
-- DATA SEGMENTATION (to segment the customers based on their spending behaviour)

/*

This script segments customers based on their historical purchase behavior by analyzing first and 
last order dates, total spend, and engagement duration.

It categorizes customers into three groups:
  - 'VIP'     -> High spenders (over $5,000) with long-term engagement (12+ months)
  - 'Regular' -> Moderate spenders with consistent long-term presence (12+ months)
  - 'New'     -> Recently acquired customers or those with short purchase history

Understanding customer segments is crucial for building targeted marketing strategies, loyalty programs, and retention initiatives. 
By identifying VIPs, the business can prioritize high-value customers with exclusive offers. Recognizing Regulars helps strengthen 
brand loyalty, while tailored onboarding for new customers can boost conversion rates. This segmentation supports strategic decision-making 
in CRM and revenue optimization.

*/
-- =================================================================================================================

WITH segmented_customer_list AS (
	SELECT 
		c.customer_key,
		CONCAT(IFNULL(first_name, ''), ' ', IFNULL(last_name,'')) as full_name,
		MIN(order_date) as first_order,
		MAX(order_date) as last_order,
		SUM(sales_amount) as total_spend,
		CASE WHEN SUM(sales_amount)>5000 AND TIMESTAMPDIFF(month,MIN(order_date), MAX(order_date))>=12 THEN 'VIP'
			 WHEN SUM(sales_amount)<=5000 AND TIMESTAMPDIFF(month,MIN(order_date), MAX(order_date))>=12 THEN 'Regular'
			 ELSE 'New'
		END as customer_segment
	FROM gold_fact_sales as f
	LEFT JOIN gold_dim_customers as c ON c.customer_key= f.customer_key
	GROUP BY c.customer_key, CONCAT(IFNULL(first_name, ''), ' ', IFNULL(last_name,''))
	ORDER BY c.customer_key
)

SELECT 
customer_segment,
COUNT(DISTINCT customer_key) as total_customers
FROM segmented_customer_list
GROUP BY customer_segment;
