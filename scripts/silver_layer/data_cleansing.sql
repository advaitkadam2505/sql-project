/*

We are inserting the cleaned data into the silver layer. The silver layer has the clean data which we will join with
to create logics and complete data information to make it business ready.

Purpose:
  This script cleans the data from the bronze layer and inserts the cleaned data into the silver layer.
  The script has been executed in MySQL.

Warning:
  This script is created for one-time purpose only. Executing the query twice will lead to duplication
  of the data entered. Ensure to truncate the initial table first to avoid the unnecessary duplication.

*/


/*
We have inserted the table into silver layer of cust_info.
We have trimmed the firstname and lastname. Also standardised the marital status and the gender
column. By considering only rn=1, we ensure that the only data being transferred is unique and 
in case of duplicates the last updated input is getting transferred to the silver layer

*/
INSERT INTO silver_crm_cust_info (
cst_id, cst_key, cst_firstname, cst_lastname, cst_marital_status, cst_gndr, cst_create_date
)
SELECT 
	cst_id, 
    cst_key, 
    TRIM(cst_firstname) as cst_firstname, 
    TRIM(cst_lastname) as cst_lastname, 
    CASE WHEN UPPER(TRIM(cst_marital_status))= 'S' THEN 'Single'
		 WHEN UPPER(TRIM(cst_marital_status))= 'M' THEN 'Married'
         ELSE 'Unknown'
	END cst_marital_status,
    CASE WHEN UPPER(TRIM(cst_gndr))= 'M' THEN 'Male'
		 WHEN UPPER(TRIM(cst_gndr))= 'F' THEN 'Female'
         ELSE 'Others'
	END cst_gndr,
    cst_create_date
FROM (
  SELECT *,
  ROW_NUMBER() OVER(PARTITION BY cst_id ORDER BY cst_create_date DESC) as rn
  FROM bronze_crm_cust_info
) t 
WHERE rn=1;

/*

In the silver layer of the prd_info, we have extracted the category id which we will be 
requiring while building gold layer with the additional information from the ERP source.
Also we have extracted the prd_key. We have also standardised the column prd_line info by 
checking the data source interpretation. Also there were some instances where the end date was
before start date so that is also managed by carefully partitioning and taking the start of 
the next period as the end of the previous one.

*/

INSERT INTO silver_crm_prd_info (
prd_id, cat_id, prd_key, prd_nm, prd_cost, prd_line, prd_start_dt, prd_end_dt
)

SELECT 
prd_id,
REPLACE(LEFT(prd_key, 5), '-', '_') cat_id,
SUBSTRING(prd_key, 7, LENGTH(prd_key)) AS prd_key,
prd_nm, 
IFNULL(prd_cost, 0) as prd_cost, 
CASE WHEN UPPER(TRIM(prd_line))='R' THEN 'Road'
	 WHEN UPPER(TRIM(prd_line))='M' THEN 'Mountain'
     WHEN UPPER(TRIM(prd_line))='S' THEN 'Others'
     WHEN UPPER(TRIM(prd_line))='T' THEN 'Touring'
     ELSE 'Unknown'
END as prd_line, 
CAST(prd_start_dt AS DATE) AS prd_start_dt,
CAST(DATE_ADD(LEAD(prd_start_dt) OVER(PARTITION BY prd_key ORDER BY prd_start_dt), INTERVAL -1 day) AS DATE) as prd_end_dt
FROM bronze_crm_prd_info;

/*

We have inserted the table into the silver layer of the sales details. Note that we have changed the
date format to YYYY-MM-DD pattern. Also there were some missing values, zeros and negatives in the sales and price
We have rectified it by applying the calculations on top of the previous ones

*/

INSERT INTO silver_crm_sales_details (
sls_ord_num, sls_prd_key, sls_cust_id, sls_order_dt, sls_ship_dt, sls_due_dt, sls_sales, sls_quantity, sls_price
)

SELECT
sls_ord_num, 
sls_prd_key, 
sls_cust_id,
CASE WHEN sls_order_dt=0 OR LENGTH(sls_order_dt)!=8 THEN NULL
	 ELSE STR_TO_DATE(sls_order_dt, '%Y%m%d')
END as sls_order_dt,
CASE WHEN sls_ship_dt=0 OR LENGTH(sls_ship_dt)!=8 THEN NULL
	 ELSE STR_TO_DATE(sls_ship_dt, '%Y%m%d')
END as sls_ship_dt, 
CASE WHEN sls_due_dt=0 OR LENGTH(sls_due_dt)!=8 THEN NULL
	 ELSE STR_TO_DATE(sls_due_dt, '%Y%m%d')
END as sls_due_dt, 
CASE WHEN sls_sales is NULL OR sls_sales<=0 OR sls_sales <> ABS(sls_price)*sls_quantity
	 THEN ABS(sls_price)*sls_quantity
     ELSE sls_sales
END sls_sales, 
sls_quantity, 
CASE WHEN sls_price is NULL OR sls_price<=0
	 THEN ROUND(ABS(sls_sales)/NULLIF(sls_quantity, 0), 0)
     ELSE sls_price
END sls_price 
FROM bronze_crm_sales_details;

/*

The customer id (cid) had NAS in some of the entires which dont match with the cst_key in the 
customer table. We will be mapping the tables in the gold layer. ALso its technically impossible that someone is having birthday
after the data collection, so we have nullified the data

*/

INSERT INTO silver_erp_cust_az12 (
cid, bdate, gen
)
SELECT
CASE WHEN cid LIKE 'NAS%' THEN SUBSTRING(cid, 4, LENGTH(cid))
	 ELSE cid
END as cid,
CASE WHEN bdate > CURDATE() THEN NULL
	 ELSE bdate
END as bdate,
CASE WHEN UPPER(TRIM(gen)) = 'M' or UPPER(TRIM(gen)) = 'MALE' THEN 'Male'
	 WHEN UPPER(TRIM(gen)) = 'F' or UPPER(TRIM(gen)) = 'FEMALE' THEN 'Female'
     ELSE 'Others'
END as gen
FROM bronze_erp_cust_az12;

/*

The data had duplications in the country name like Germany has been differently identified as
Germany and DE. We have standardised the names of the country and called the missing country as
'n/a'. Also there is - which we have replaced with empty string to make the gold layer mapping.

*/

INSERT INTO silver_erp_loc_a101 (
cid, cntry
)

SELECT 
REPLACE(cid,'-','') as cid,
CASE
	WHEN TRIM(cntry) IN ('US', 'USA', 'United States') THEN 'USA'
    WHEN TRIM(cntry) IN ('DE', 'Germany') THEN 'Germany'
    WHEN TRIM(cntry) IN ('', NULL) THEN 'n/a'
    ELSE TRIM(cntry)
END as cntry
FROM bronze_erp_loc_a101

/*

  The data is inserted. This data was having good quality so we haven't done any transformations

*/

INSERT INTO silver_erp_px_cat_g1v2 (
id, cat, subcat, maintenance
)

SELECT 
id,
cat, 
subcat,
maintenance
FROM bronze_erp_px_cat_g1v2;
