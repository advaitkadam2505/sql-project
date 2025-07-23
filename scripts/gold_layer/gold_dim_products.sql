/*

Creating the product dimension

Purpose:
	The gold layer of the DataWarehouse has the product dimension for which we have created a
	view. We have introduced a surrogate key which holds no meaning in the data, it just serves
	as an identification. We have also considered just the present data by eliminating the 
	rows which has prd_end_dt as NOT NULL.

*/

CREATE VIEW gold_dim_products AS 
SELECT 
	ROW_NUMBER() OVER(Order by pi.prd_start_dt, pi.prd_key) as product_key,
	pi.prd_id as product_id,
	pi.prd_key as product_number,
	pi.prd_nm as product_name, 
	pi.cat_id as category_id,
	pc.cat as category,
	pc.subcat as subcategory,
	pc.maintenance,
	pi.prd_cost as cost, 
	pi.prd_line as product_line, 
	pi.prd_start_dt as start_date
FROM silver_crm_prd_info as pi
LEFT JOIN silver_erp_px_cat_g1v2 as pc ON pi.cat_id= pc.id
WHERE pi.prd_end_dt is NULL;
