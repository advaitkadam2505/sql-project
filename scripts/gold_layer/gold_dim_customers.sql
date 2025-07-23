/*

Creating the customers dimension of the data.

Purpose:
	The script creates a view of the customer dimension which falls under the gold
	layer of the DataWarehouse. We have assumed the CRM to be the master data and 
	the gender if not available in the CRM is checked into the ERP.
	Also the below script does the left join to ensure that no data is skipped

*/

CREATE VIEW gold_dim_customers AS
SELECT 
	ROW_NUMBER() OVER(Order by ci.cst_id) as customer_key,
	ci.cst_id as customer_id, 
	ci.cst_key as customer_number, 
	ci.cst_firstname as first_name, 
	ci.cst_lastname as last_name,
    cl.cntry as country,
    CASE WHEN ci.cst_gndr <> 'Others' THEN ci.cst_gndr
		 ELSE COALESCE(ca.gen, 'n/a')
	END as gender,
    ci.cst_marital_status as marital_status,
    ca.bdate as birth_date,
	ci.cst_create_date as create_date
FROM silver_crm_cust_info as ci
LEFT JOIN silver_erp_cust_az12 as ca ON ci.cst_key= ca.cid 
LEFT JOIN silver_erp_loc_a101 as cl ON ci.cst_key= cl.cid;
