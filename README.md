# Data Warehouse and Analytics Project

Welcome to the **Data Warehouse and Analytics Project** repository! 🚀  
This project demonstrates a comprehensive data warehousing and analytics solution, from building a data warehouse to generating actionable insights. Designed as a portfolio project, it highlights industry best practices in data engineering and analytics.

---
## 🏗️ Data Architecture

The data architecture for this project follows Medallion Architecture **Bronze**, **Silver**, and **Gold** layers:
![Data Architecture](docs/data_architecture.png)

1. **Bronze Layer**: Stores raw data as-is from the source systems. Data is ingested from CSV Files into SQL Server Database.
2. **Silver Layer**: This layer includes data cleansing, standardization, and normalization processes to prepare data for analysis.
3. **Gold Layer**: Houses business-ready data modeled into a star schema required for reporting and analytics.

---
## 📖 Project Overview

This project involves:

1. **Data Architecture**: Designing a Modern Data Warehouse Using Medallion Architecture **Bronze**, **Silver**, and **Gold** layers.
2. **ETL Pipelines**: Extracting, transforming, and loading data from source systems into the warehouse.
3. **Data Modeling**: Developing fact and dimension tables optimized for analytical queries.
4. **Analytics & Reporting**: Creating SQL-based reports and dashboards for actionable insights.

🎯 This repository is an excellent resource for professionals and students looking to showcase expertise in:
- SQL Development
- Data Architect
- Data Engineering  
- ETL Pipeline Developer  
- Data Modeling  
- Data Analytics  

---

## 🚀 Project Requirements

### Building the Data Warehouse (Data Engineering)

#### Objective
Develop a modern data warehouse using SQL Server to consolidate sales data, enabling analytical reporting and informed decision-making.

#### Specifications
- **Data Sources**: Import data from two source systems (ERP and CRM) provided as CSV files.
- **Data Quality**: Cleanse and resolve data quality issues prior to analysis.
- **Integration**: Combine both sources into a single, user-friendly data model designed for analytical queries.
- **Scope**: Focus on the latest dataset only; historization of data is not required.
- **Documentation**: Provide clear documentation of the data model to support both business stakeholders and analytics teams.

---

### BI: Analytics & Reporting (Data Analysis)

#### Objective
Develop SQL-based analytics to deliver detailed insights into:
- **Customer Behavior**
- **Product Performance**
- **Sales Trends**

These insights empower stakeholders with key business metrics, enabling strategic decision-making.  

For more details, refer to [docs/requirements.md](docs/requirements.md).

## 📂 Repository Structure
```
sql-project
├── datasets/ 
│ ├── CRM/
│ │ ├── cust_info.csv
│ │ ├── prd_info.csv
│ │ └── sales_details.csv
│ └── ERP/
│ ├── CUST_AZ12.csv
│ ├── LOC_A101.csv
│ └── PX_CAT_G1V2.csv
│
├── docs/ 
│ ├── data_architecture.png
│ ├── data_flow.png
│ └── data_integration.png
│
├── scripts/
│ ├── Advanced Analytics/
│ │ ├── cumulative_analysis.sql
│ │ ├── customer_report.sql
│ │ ├── data_segmentation.sql
│ │ ├── part_to_whole.sql
│ │ ├── performance_analysis.sql
│ │ ├── product_report.sql
│ │ └── time_trends.sql
│ ├── EDA/ 
│ │ ├── dim_date_exploration.sql
│ │ ├── dim_measure.sql
│ │ ├── measure_report.sql
│ │ ├── metadata_exploration.sql
│ │ └── top_performers.sql
│ ├── bronze_layer/ 
│ │ ├── ddl_bronze_layer.sql
│ │ └── init_database.sql
│ ├── silver_layer/ 
│ │ ├── data_cleansing.sql
│ │ └── ddl_silver_layer.sql
│ └── gold_layer/ 
│ ├── gold_dim_customers.sql
│ ├── gold_dim_products.sql
│ └── gold_fact_sales.sql
│
├── tests/ 
│ ├── quality_check_gold.sql
│ └── quality_check_silver.sql
│
├── LICENSE
└── README.md
```
---
