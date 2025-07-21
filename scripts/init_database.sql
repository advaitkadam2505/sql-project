/*
Create Database

Purpose: 
  This script creates the new database DataWarehouse by first looking if the database already exists. If the 
  database already exists then the existing one is dropped and recreated.

Warning:
  This script will drop the entire database 'DataWarehouse' and the data will be permenantly deleted.
  Make sure the data is properly backed up before executing this script.

*/

-- Create the main project database and drop if already exists
DROP DATABASE IF EXISTS DataWarehouse;
CREATE DATABASE DataWarehouse;

-- Use the database
USE DataWarehouse;
