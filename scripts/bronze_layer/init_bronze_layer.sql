/*
Bronze Layer: Raw Ingested Data Tables (CRM and ERP Sources)
These tables store unprocessed source data as received

Purpose:
  The below script creates the tables to store the data from CRM and ERP source.
  The script is created after looking for the datatypes in the data available. The
  name bronze_* says that the table is in the bronze layer. We will be building the 
  silver and gold layer on top. _crm_ says that the source is CRM.

*/

-- CRM Customer Information
CREATE TABLE bronze_crm_cust_info (
  cst_id INT,                         -- Customer ID (integer key)
  cst_key VARCHAR(15),               -- Alternate customer key
  cst_firstname VARCHAR(20),         -- First name
  cst_lastname VARCHAR(20),          -- Last name
  cst_marital_status VARCHAR(1),     -- Marital status ('M', 'S', etc.)
  cst_gndr VARCHAR(1),               -- Gender ('M', 'F', etc.)
  cst_create_date DATE               -- Customer creation date
);

-- CRM Product Information
CREATE TABLE bronze_crm_prd_info (
  prd_id INT,                        -- Product ID
  prd_key VARCHAR(50),              -- Product key from source
  prd_nm VARCHAR(75),               -- Product name
  prd_cost INT,                     -- Product cost (whole number)
  prd_line CHAR(1),                 -- Product line/category code
  prd_start_dt DATETIME,           -- Product availability start date
  prd_end_dt DATETIME              -- Product end-of-life date
);

-- CRM Sales Transactions
CREATE TABLE bronze_crm_sales_details (
  sls_ord_num VARCHAR(20),          -- Sales order number
  sls_prd_key VARCHAR(20),          -- Product key
  sls_cust_id INT,                  -- Customer ID
  sls_order_dt INT,                 -- Order date encoded as YYYYMMDD
  sls_ship_dt INT,                  -- Ship date encoded as YYYYMMDD
  sls_due_dt INT,                   -- Due date encoded as YYYYMMDD
  sls_sales INT,                    -- Total sales amount (whole number)
  sls_quantity INT,                 -- Quantity sold
  sls_price INT                     -- Unit price (whole number)
);

-- ERP Customer Demographics (AZ12 System)
CREATE TABLE bronze_erp_cust_az12 (
  cid VARCHAR(50),                  -- Customer ID
  bdate DATE,                       -- Birth date
  gen VARCHAR(10)                   -- Gender description ('Male', 'Female', etc.)
);

-- ERP Customer Location Mapping (A101 System)
CREATE TABLE bronze_erp_loc_a101 (
  cid VARCHAR(50),                  -- Customer ID
  cntry VARCHAR(20)                 -- Country
);

-- ERP Product Category Information (G1V2 System)
CREATE TABLE bronze_erp_px_cat_g1v2 (
  id VARCHAR(10),                   -- Product/category ID
  cat VARCHAR(20),                  -- Main category
  subcat VARCHAR(50),              -- Sub-category
  maintenance VARCHAR(5)           -- Maintenance status ('YES', 'NO', etc.)
);
