# 🛢️ Crude_Oil_Exports

[![Python](https://img.shields.io/badge/Python-3.12-blue?logo=python)](https://www.python.org/)
[![dbt Core](https://img.shields.io/badge/dbt_Core-1.10-orange?logo=dbt)](https://docs.getdbt.com/)
[![DuckDB](https://img.shields.io/badge/DuckDB-1.1.3-yellow?logo=duckdb)](https://duckdb.org/)
[![Prefect](https://img.shields.io/badge/Prefect-3.x-blueviolet?logo=prefect)](https://www.prefect.io/)
[![Metabase](https://img.shields.io/badge/Metabase-Latest-brightgreen?logo=metabase)](https://www.metabase.com/)

End-to-end data engineering project to process and analyze Canada’s crude oil export data — built entirely with open-source tools and a modern ELT architecture.

## 📚 Table of Contents
- [🚀 Overview](#-overview)
- [🧩 Tech Stack](#-tech-stack)
- [🧱 Project Structure](#-project-structure)
- [⚙️ How to Run Locally](#️-how-to-run-locally)
- [📊 Example Outputs](#-example-outputs)

## 🚀 Overview

This project replicates a real-world **data engineering pipeline**, covering all stages from raw data ingestion to analytical visualization.  
It leverages open-source technologies to simulate a modern, production-style workflow.

### Pipeline Stages

1. **Ingestion** → raw CSV files are automatically downloaded from the [*Canada Energy Regulator*](https://open.canada.ca/data/en/dataset/0b7bf4b3-423a-45d0-a92b-e69be0b81ce4) open data portal using **Python + pandas**.  
2. **Transformation** → data cleaning, typing, and modeling using **dbt Core**.  
3. **Storage** → local **DuckDB** analytical database.  
4. **Orchestration** → managed with **Prefect** (optional flow).  
5. **Visualization** → interactive dashboards built with **Metabase**.

The goal is to demonstrate how raw, unstructured data can be transformed into reliable analytical assets in a maintainable, reproducible way.

## 🧩 Tech Stack

| Stage | Tool | Purpose |
|-------|------|----------|
| Ingestion | 🐍 Python + pandas + requests | Automated download of CSVs from the CER open data portal |
| Storage | 🦆 DuckDB | Local analytical OLAP database |
| Transformation | dbt Core | SQL-based modeling, testing, and documentation |
| Orchestration | Prefect | Workflow automation and scheduling |
| Visualization | Metabase | BI dashboards and data exploration |

## 🧱 Project Structure

```graphql
Crude_Oil_Exports/
├── data/
│   └── raw/                  # 🗂️ Raw CSV files automatically downloaded
├── scripts/
│   └── ingest_csvs.py        # 🐍 Python script to download and validate data
├── dbt/
│   ├── dbt_project.yml       # Main dbt configuration
│   ├── profiles/             # Connection settings
│   └── models/
│       ├── staging/          # Cleans and types raw data
│       └── marts/            # Analytical models ready for dashboards
├── warehouse/                # 🦆 DuckDB database file
├── prefect/                  # ⚙️ Prefect orchestration flows (to be implemented)
├── metabase/                 # 📊 Dashboard configuration and Docker setup
├── docs/
│   ├── architecture.md       # Pipeline overview and diagrams
│   ├── ingestion.md          # Details about the ingestion process
│   └── environment.md        # Local setup and configuration guide
├── .env / .env.example       # Environment variables
├── .gitignore                # Ignored files (raw data, cache, etc.)
├── requirements.txt          # Python dependencies
└── README.md                 # This file
```

## ⚙️ How to Run Locally   
```bash
# 1. Clone the repository
git clone https://github.com/JeronimoDalPiazze/Portfolio.git
cd Portfolio/Crude_Oil_Exports

# 2. Create and activate the virtual environment
python -m venv .venv

# On Linux/Mac:
source .venv/bin/activate

# On Windows:
.venv\Scripts\activate

# 3. Install dependencies
pip install -r requirements.txt

# 4. Create the .env file
cp .env.example .env

# 5. Run the data ingestion script
python scripts/ingest_csvs.py
# → This script downloads all required CSVs from the CER portal
#   and saves them to data/raw/

# Example output:
# ⬇️  Downloading crude-oil-exports-by-type-monthly.csv ...
# ✅ crude-oil-exports-by-type-monthly.csv: 120 rows, 7 columns
# 💾 Saved to data/raw/crude-oil-exports-by-type-monthly.csv

# 6. Run dbt transformations
set -a; source .env; set +a
dbt build --project-dir dbt

# 7. (Optional) Launch Metabase for visualization
docker-compose -f metabase/docker-compose.yml up
```



