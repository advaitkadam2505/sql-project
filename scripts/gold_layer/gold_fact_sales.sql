/*

Creating the fact_sales view

Purpose:
  This script creates the view of the fact_sales which combines the product and customer
  dimensions created in the gold layer of the DataWarehouse. The column names are adjusted 
  so that we have names which are easily interpreted for the business reasons and decision
  making for business problems.

*/

CREATE VIEW gold_fact_sales AS

SELECT  
sd.sls_ord_num as order_number, 
dp.product_key,
dc.customer_key,
sd.sls_order_dt as order_date, 
sd.sls_ship_dt as shipping_date, 
sd.sls_due_dt as due_date, 
sd.sls_sales as sales_amount, 
sd.sls_quantity as quantity, 
sd.sls_price as price
FROM silver_crm_sales_details as sd
LEFT JOIN gold_dim_products as dp ON sd.sls_prd_key= dp.product_number
LEFT JOIN gold_dim_customers as dc ON sd.sls_cust_id= dc.customer_id;
