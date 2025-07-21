/*
Create Database

Purpose: 
This script creates the new database DataWarehouse by first looking if the database already exists. If the database named DataWarehouse
does exist then the database is not created and we use the existing database.

*/

-- Create the main project database
CREATE DATABASE IF NOT EXISTS DataWarehouse;

GO

-- Use the database
USE DataWarehouse;
