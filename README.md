# 🧠 SQL Data Analytics Project - CRM & ERP Integration

This project is a comprehensive end-to-end SQL-based data pipeline that unifies customer and product data from two core enterprise systems — CRM and ERP — into a centralized data warehouse. Built using the Medallion Architecture, it transforms raw operational data into trusted, analytics-ready datasets that drive better business decisions. By systematically cleaning, enriching, and integrating the data, the project enables reliable reporting and deep business insights through a star schema model. It supports key business use cases such as understanding customer lifetime value, tracking product performance, analyzing revenue trends, segmenting customers based on behavior, and measuring core KPIs like recency, frequency, and monetary value. With this foundation, the business gains a 360-degree view of its operations — helping stakeholders identify growth opportunities, optimize customer engagement, streamline product strategy, and make data-informed strategic choices across sales, marketing, and operations.

> 📍 **Repository:** [SQL Project GitHub Repo](https://github.com/advaitkadam2505/sql-project)

---

## 📌 Objective

The objective of this project is to design and build a scalable, analysis-ready SQL-based data pipeline that brings together data from multiple source systems into a centralized warehouse. By consolidating customer and product data from CRM and ERP platforms, the pipeline ensures that information is clean, consistent, and structured for downstream use. It enables both exploratory analysis and advanced analytics, allowing stakeholders to uncover trends, segment customers, evaluate product performance, and generate meaningful insights. Through well-defined data transformations and robust reporting views, the project aims to deliver KPI-driven dashboards and metrics that empower teams to make data-informed decisions across marketing, sales, and operations.

---

## 🏗️ Architecture

This project adopts the **Medallion Architecture** (Bronze → Silver → Gold) and is built around the **Star Schema** model for the gold layer.

📁 **Bronze Layer** – Raw ingestion  
📁 **Silver Layer** – Cleaned and standardized data  
📁 **Gold Layer** – Business-friendly dimensional views

![Data Architecture](docs/data_architecture.png)

---

## 🧾 Source Systems

**1. CRM System**  
- `cust_info.csv`  
- `prd_info.csv`  
- `sales_details.csv`

**2. ERP System**  
- `CUST_AZ12.csv`  
- `LOC_A101.csv`  
- `PX_CAT_G1V2.csv`

These datasets include customer records, product information, transactional sales data, geographic location, and product hierarchy.

---

## 🔃 ETL Workflow

### 🔸 Bronze Layer
- Data load initialization: `bronze_layer/init_database.sql`
- Schema creation: `bronze_layer/ddl_bronze_layer.sql`

### 🔸 Silver Layer
- Schema creation: `silver_layer/ddl_silver_layer.sql`
- Data cleansing & transformation: `silver_layer/data_cleansing.sql`
- Enrichment and standardization (e.g., date parsing, null handling, sales calculations)

### 🔸 Gold Layer
- Final fact and dimension views for business users:
  - `gold_fact_sales.sql`
  - `gold_dim_customers.sql`
  - `gold_dim_products.sql`

![Data Flow](docs/data_flow.png)
> Relationships modeled using the **Star Schema** for optimal analytical querying.

---

## 📊 Exploratory Data Analysis (EDA)

Directory: `scripts/EDA`

Scripts used:
- `dim_date_exploration.sql`
- `dim_measure.sql`
- `measure_report.sql`
- `metadata_exploration.sql`
- `top_performers.sql`

Focus areas:
- Understanding data distributions
- Validating completeness and granularity
- Identifying high-performing entities

---

## 📈 Advanced Analytics

Directory: `scripts/Advanced Analytics`

Analysis modules include:
- `time_trends.sql` – Monthly trends in revenue and quantity
- `cumulative_analysis.sql` – Running totals for growth tracking
- `part_to_whole.sql` – Category-wise contribution to sales
- `data_segmentation.sql` – Customer segments (VIP, Regular, New)
- `performance_analysis.sql` – Benchmarked product performance
- `customer_report.sql` – KPIs: Recency, AOV, Monthly Spend
- `product_report.sql` – KPIs: Recency, AOR, Avg Monthly Revenue

These insights help businesses:
- Target high-value customers
- Improve product assortment
- Track seasonality and growth
- Create performance benchmarks

---

## ✅ Data Quality Checks

Directory: `tests`

- `quality_check_silver.sql`  
- `quality_check_gold.sql`  

Checks for:
- Nulls, incorrect data types
- Invalid joins or orphan records
- Metric validation (e.g., derived sales = price × quantity)

---

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

## 🧠 Key Business Insights Delivered

This project goes beyond basic data exploration to deliver business-relevant insights that can inform strategic decisions and drive growth across sales, marketing, and product teams. Each analysis is designed to highlight opportunities, identify gaps, and support actions that directly impact performance:

- 🎯 **Customer Segmentation**: Classified customers into VIP, Regular, and New segments based on spending patterns and engagement history. This allows targeted retention strategies, loyalty programs, and personalized marketing campaigns.

- 📦 **Product Performance Tracking**: Identified top-performing and underperforming products over time, helping the business optimize inventory, discontinue low-yield SKUs, and prioritize high-margin offerings.

- 📈 **KPI Monitoring Framework**
  Introduced key customer and product-level performance metrics to establish benchmarks:
  - Customer KPIs:
     - Recency (time since last order)
     - Average Order Value (AOV)
     - Average Monthly Spend
  - Product KPIs:
      - Recency (last sold date)
      - Average Order Revenue (AOR)
      - Average Monthly Revenue

- 🌍 **Category-Level Sales Contribution**: Quantified the percentage contribution of each product category to total revenue, guiding category-level strategy and product assortment decisions.

- 📊 **Time Trend Analysis**: Analyzed sales performance month over month to identify growth patterns, seasonal shifts, and opportunities for boosting revenue during low-performing periods.

---

## 🛠️ Tools Used

- **SQL** – Core ETL and analytics scripting  
- **Medallion Architecture** – Bronze, Silver, Gold layer design  
- **Star Schema** – For optimized reporting  
- **GitHub** – Version control & documentation
- **draw.io** - Diagrams and models to showcase the flow and architecture 
- **MySQL Workbench** - Used to write down the queries

---

## 🌟 About Me

Hi there! I'm **Advait Kadam**. I’m an undergraduate at **Indian Institute of Technology Madras** with an exchange programme at **Karlsruhe Institute of Technology, Germany** in the department of Economics
and Management. I’m deeply passionate about solving real-world business problems with data. My interests lie at the intersection of data analytics, finance, and innovation. Whether it's building KPI-driven SQL data pipelines, crafting analytical reports, or managing projects end-to-end — I love translating raw datasets into insights that truly matter.

Let's stay in touch! Feel free to connect with me on LinkedIn:

[![LinkedIn](https://img.shields.io/badge/LinkedIn-0077B5?style=for-the-badge&logo=linkedin&logoColor=white)]([https://linkedin.com/in/baraa-khatib-salkini](https://www.linkedin.com/in/advait-kadam-29aa91253/))
