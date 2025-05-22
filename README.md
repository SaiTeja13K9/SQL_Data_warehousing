# 🏗️ SQL Data Warehousing Project using Medallion Architecture

Welcome to the **SQL Data Warehousing Project**, a hands-on implementation of data architecture and engineering principles using the **Medallion Architecture**: Bronze, Silver, and Gold layers. This project demonstrates how to design, build, and manage a scalable SQL Server-based data warehouse from scratch, turning raw CSV files into insightful business reports.

---

## 🌐 Why This Project?

In real-world analytics, 90% of the effort lies in extracting, transforming, and preparing the data—not the final dashboard. This project reflects that reality.

Whether you're an aspiring Data Analyst, SQL Developer, or Data Engineer, this repository is a **portfolio-grade showcase** of your ability to:

- Build robust ETL pipelines  
- Cleanse and model data for analytics  
- Apply best practices in data warehousing  
- Create reliable, scalable reporting layers  

---

## 🔁 Medallion Architecture Overview

This project follows the **Medallion Architecture** with three progressive layers:

1. **Bronze Layer (Raw Ingestion):**
   - CSVs ingested directly using `BULK INSERT`
   - No transformation, purely raw landing tables

2. **Silver Layer (Cleansed & Enriched):**
   - Null handling, trimming, normalization
   - Business rules applied for gender, country, etc.
   - Deduplication using `ROW_NUMBER()`

3. **Gold Layer (Analytics-Ready):**
   - Star Schema modeled using dimension and fact views
   - Surrogate keys via `ROW_NUMBER()`
   - Aggregated and enriched data for analysis

---

## 📊 Project Scope

### 🔧 Data Engineering

- Setup database & schemas with `init_database.sql`
- Ingest CRM & ERP CSV data into the Bronze layer
- Cleanse and transform into Silver using business logic
- Build analytical models (Star Schema) in the Gold layer

### 📈 Analytics & Reporting

- Key insights delivered using SQL-based queries on:
  - Customer Demographics
  - Product Segments
  - Sales Trends
- Data validation scripts ensure:
  - Referential Integrity
  - Duplicate handling
  - Standardized formats (e.g., Dates, Gender)

---

## 🧩 Project Components

### 1. Bronze Layer

| File                         | Purpose                           |
|------------------------------|-----------------------------------|
| `Bronze_DDL_SQLQuery.sql`    | Creates raw staging tables        |
| `Bronze_storedProcedure.sql` | Loads CSVs via `BULK INSERT`      |

### 2. Silver Layer

| File                          | Purpose                             |
|-------------------------------|-------------------------------------|
| `Silver_DDL_SQLQuery.sql`     | Cleansed schema creation            |
| `Silver_storedProcedure.sql`  | ETL logic & transformations         |
| `Silver_Checks.sql`           | Data quality checks                 |

### 3. Gold Layer

| File                       | Purpose                                  |
|----------------------------|------------------------------------------|
| `Gold_DDL_SQLQuery.sql`    | Star schema views                        |
| `Gold_Checks.sql`          | Analytics validations                    |

---

## 🛠️ Tools & Technologies

- **SQL Server** (with SSMS)
- **CSV Datasets** (ERP & CRM)
- **Draw.io** – Data Flow & Star Schema Diagrams
- **Notepad++** – Quick data formatting & refactoring

Bonus Resources:
- [SQL Server Express](https://www.microsoft.com/en-us/sql-server/sql-server-downloads)  
- [SSMS Download](https://learn.microsoft.com/en-us/sql/ssms/download-sql-server-management-studio-ssms)  
- [Notion Project Steps](https://thankful-pangolin-2ca.notion.site/SQL-Data-Warehouse-Project-16ed041640ef80489667cfe2f380b269?pvs=4)

---

## 📂 Folder Structure

```
data-warehouse-project/
│
├── datasets/                   # CSV data sources
├── scripts/
│   ├── bronze/
│   ├── silver/
│   ├── gold/
├── docs/
│   ├── data_architecture.drawio
│   ├── data_catalog.md
│   ├── data_flow.drawio
│   ├── naming-conventions.md
├── tests/                      # Data quality & validation scripts
├── README.md
├── LICENSE
└── requirements.txt
```

---

## 📖 Sample SQL Queries

```sql
-- Preview cleaned customers
SELECT TOP 100 * FROM silver.crm_cust_info;

-- Verify product category joins
SELECT * FROM gold.fact_sales;
```

---

## 💡 Key Learnings

- Real-world ETL means handling inconsistent dates, invalid IDs, and malformed strings.
- Data should only be cleaned **once**—Silver handles all standardization.
- Star schemas enable fast reporting and easy Power BI integration.
- Talk to source system experts—assumptions can lead to poor modeling.
- Keep transformations modular and layer-specific (don’t cleanse in Gold!).

---

## 🌟 Who Is This For?

Ideal for learners who want to showcase experience in:
- SQL Development  
- Data Engineering  
- Data Modeling & ETL Pipelines  
- Business Intelligence Projects  

---

## 🔐 License

Released under the MIT License.

---

## 🙋 About the Creator

Hi there! I'm **Sai Teja**, passionate about turning messy data into powerful insights. This project reflects both academic learning and real-world know-how in building scalable, clean, and intelligent data infrastructure.
https://github.com/SaiTeja13K9
