-- ========================================================================
-- EXPLORING THE METADATA OF THE PROJECT DATABASE -> 'DataWarehouse'
-- ========================================================================

/*

Purpose of this script is to explore the data we have created in the DataWarehouse.
SQL stores the data information in the metadata which can be explored before diving
into the advanced analytics and basic exploration of the business scenarios.

*/

-- In the below query, we are simply looking for the tables stored under the project database

SELECT * FROM INFORMATION_SCHEMA.TABLES
WHERE TABLE_SCHEMA='DataWarehouse';

-- In the below query, we are looking for the columns present, which sums up to 101 columns so far.

SELECT * FROM INFORMATION_SCHEMA.COLUMNS
WHERE TABLE_SCHEMA='DataWarehouse'
-- AND TABLE_NAME= 'gold_dim_customers' -- This query specifically extracts the data specifically for the TABLE_NAME specified
