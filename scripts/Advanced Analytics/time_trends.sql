-- =========================================================================================
-- TIME TRENDS ANALYSIS (to find the best period of the business)
-- =========================================================================================

/*

The purpose of this script is to find the time trends of the sales, number of customers,
items sold and orders placed. The time details are changed to analyse the seasonality of the 
demand being obseved in the past 4 years from quarter-year to month to quarter to weekday. 

The observation is that the sales are on the peak during the Quarter 4 of each year possibly
because of the Christmas period as the data is collected from the western countries primarily.
The business has also witnessed increased demand on Tuesdays.

*/

-- Year-Quarter wise trend observation

SELECT 
CONCAT(YEAR(order_date), ' ','Q',QUARTER(order_date)) as order_quarter,
COUNT(distinct order_number) as total_orders,
SUM(quantity) as total_quantity,
COUNT(distinct customer_key) as total_customers,
SUM(sales_amount) as total_sales
FROM gold_fact_sales
WHERE order_date is NOT NULL
GROUP BY CONCAT(YEAR(order_date), ' ','Q',QUARTER(order_date))
ORDER BY CONCAT(YEAR(order_date), ' ','Q',QUARTER(order_date));

-- Month wise trends of the sales

SELECT 
MONTH(order_date) as order_month,
COUNT(distinct order_number) as total_orders,
SUM(quantity) as total_quantity,
COUNT(distinct customer_key) as total_customers,
SUM(sales_amount) as total_sales
FROM gold_fact_sales
WHERE order_date is NOT NULL
GROUP BY MONTH(order_date)
ORDER BY MONTH(order_date);

-- Quarter wise trends

SELECT 
QUARTER(order_date) as order_quarter,
COUNT(distinct order_number) as total_orders,
SUM(quantity) as total_quantity,
COUNT(distinct customer_key) as total_customers,
SUM(sales_amount) as total_sales
FROM gold_fact_sales
WHERE order_date is NOT NULL
GROUP BY QUARTER(order_date)
ORDER BY QUARTER(order_date);

-- Weekday wise trends observed

SELECT 
WEEKDAY(order_date) as order_weekday,
COUNT(distinct order_number) as total_orders,
SUM(quantity) as total_quantity,
COUNT(distinct customer_key) as total_customers,
SUM(sales_amount) as total_sales
FROM gold_fact_sales
WHERE order_date is NOT NULL
GROUP BY WEEKDAY(order_date)
ORDER BY WEEKDAY(order_date);
