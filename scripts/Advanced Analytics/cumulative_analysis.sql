-- CUMULATIVE ANALYSIS (to check the growth YoY)

/*

Purpose:
  The purpose of the script is to analyse the period over period growth of the sales total on 
  monthly basis. We have also calculated the moving average of price over the period of time and witnessed 
  a decline in the moving average through the years. The data is aggregated over the months in the 
  form of 'YYYY-mm'

*/

SELECT *,
SUM(total_sales) OVER(ORDER BY order_month ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW) as running_total,
ROUND(AVG(average_price) OVER(ORDER BY order_month ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW), 2) as moving_average
FROM (
	SELECT
	DATE_FORMAT(order_date, '%Y-%m') as order_month,
	SUM(sales_amount) as total_sales,
    AVG(price) as average_price
	FROM gold_fact_sales
	WHERE order_date is NOT NULL
	GROUP BY DATE_FORMAT(order_date, '%Y-%m')
) t;
