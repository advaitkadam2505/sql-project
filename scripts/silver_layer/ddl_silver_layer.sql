/*

Creating the table for silver layer.
We will now cleanse and load the data from the bronze layer into this silver layer.

Purpose:
  This script stands as the DDL for the silver layer which will be containing
  the clean data loaded from the bronze layer of the data warehouse. We have
  introduced with the CURDATE() feature which gives us the date when the
  silver layer is created. This script was executed in MySQL workbench.

*/

-- CRM Customer Information
CREATE TABLE silver_crm_cust_info (
  cst_id INT,                         -- Customer ID (integer key)
  cst_key VARCHAR(15),               -- Alternate customer key
  cst_firstname VARCHAR(20),         -- First name
  cst_lastname VARCHAR(20),          -- Last name
  cst_marital_status VARCHAR(10),     -- Marital status ('M', 'S', etc.)
  cst_gndr VARCHAR(10),               -- Gender ('M', 'F', etc.)
  cst_create_date DATE,              -- Customer creation date
  dwh_create_date DATE DEFAULT (CURDATE()) -- Creation date 
);

-- CRM Product Information
CREATE TABLE silver_crm_prd_info (
  prd_id INT,                        -- Product ID
  prd_key VARCHAR(50),              -- Product key from source
  prd_nm VARCHAR(75),               -- Product name
  prd_cost INT,                     -- Product cost (whole number)
  prd_line VARCHAR(10),             -- Product line/category code
  prd_start_dt DATETIME,           -- Product availability start date
  prd_end_dt DATETIME,              -- Product end-of-life date
  dwh_create_date DATE DEFAULT (CURDATE()) -- Creation date
);

-- CRM Sales Transactions
CREATE TABLE silver_crm_sales_details (
  sls_ord_num VARCHAR(20),          -- Sales order number
  sls_prd_key VARCHAR(20),          -- Product key
  sls_cust_id INT,                  -- Customer ID
  sls_order_dt DATE,                 -- Order date encoded as YYYYMMDD
  sls_ship_dt DATE,                  -- Ship date encoded as YYYYMMDD
  sls_due_dt DATE,                   -- Due date encoded as YYYYMMDD
  sls_sales INT,                    -- Total sales amount (whole number)
  sls_quantity INT,                 -- Quantity sold
  sls_price INT,                     -- Unit price (whole number)
  dwh_create_date DATE DEFAULT (CURDATE()) -- Creation date
);

-- ERP Customer Demographics (AZ12 System)
CREATE TABLE silver_erp_cust_az12 (
  cid VARCHAR(50),                  -- Customer ID
  bdate DATE,                       -- Birth date
  gen VARCHAR(10),                   -- Gender description ('Male', 'Female', etc.)
  dwh_create_date DATE DEFAULT (CURDATE()) -- Creation date
);

-- ERP Customer Location Mapping (A101 System)
CREATE TABLE silver_erp_loc_a101 (
  cid VARCHAR(50),                  -- Customer ID
  cntry VARCHAR(20),                 -- Country
  dwh_create_date DATE DEFAULT (CURDATE()) -- Creation date
);

-- ERP Product Category Information (G1V2 System)
CREATE TABLE silver_erp_px_cat_g1v2 (
  id VARCHAR(10),                   -- Product/category ID
  cat VARCHAR(20),                  -- Main category
  subcat VARCHAR(50),              -- Sub-category
  maintenance VARCHAR(5),           -- Maintenance status ('YES', 'NO', etc.)
  dwh_create_date DATE DEFAULT (CURDATE()) -- Creation date
);
