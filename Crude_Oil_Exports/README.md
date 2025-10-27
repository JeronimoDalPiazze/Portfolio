# 🛢️ Crude_Oil_Exports

End-to-end data engineering project to process and analyze Canada’s crude oil export data, built entirely with open-source tools and a modern ELT architecture.
---
## 🚀 Overview

This project demonstrates a complete **data engineering pipeline**, including:

1. **Ingestion** → raw CSV files are placed manually in the `data/raw/` directory (automatic ingestion via Python + pandas planned for future versions)  
2. **Transformation** → data cleaning, typing, and modeling using **dbt Core**  
3. **Storage** → local **DuckDB** database  
4. **Orchestration** → handled by **Prefect** (optional flow)  
5. **Visualization** → interactive dashboards built in **Metabase**

The goal is to simulate a modern data-engineering workflow — from ingestion to visualization — using open-source technologies.
---
## 🧩 Tech Stack

| Stage | Tool | Purpose |
|-------|------|----------|
| Ingestion | Manual (future: Python + pandas) | Raw data placed in `data/raw/` |
| Storage | 🦆 DuckDB | Local analytical database |
| Transformation | dbt Core | SQL-based modeling and testing |
| Orchestration | Prefect | Workflow automation |
| Visualization | Metabase | BI dashboards and data exploration |
---
## 🧱 Project Structure

```graphql
Crude_Oil_Exports/
├── data/
│   └── raw/                  # 🗂️ Raw CSV data (manually placed)
├── dbt/
│   ├── dbt_project.yml       # Main dbt configuration
│   ├── profiles/             # Connection settings
│   └── models/
│       ├── staging/          # Cleans and types raw data
│       └── marts/            # Analytical models ready for dashboards
├── warehouse/                # 🦆 DuckDB database file
├── prefect/                  # ⚙️ Prefect orchestration flows
├── metabase/                 # 📊 Dashboard configuration and Docker setup
├── docs/                     # 📄 Technical documentation
├── .env / .env.example       # Environment variables
├── requirements.txt          # Python dependencies
└── README.md                 # This file
```
---
## ⚙️ How to Run Locally

```graphql
# 1. Clone the repository
git clone https://github.com/JeronimoDalPiazze/Portfolio.git
cd Portfolio/Crude_Oil_Exports

# 2. Create the virtual environment
python -m venv .venv
source .venv/bin/activate
pip install -r requirements.txt

# 3. Create the .env file
cp .env.example .env

# 4. Place the raw CSV files in data/raw/
# (see expected file names in data/raw/README.md)

# 5. Run dbt
set -a; source .env; set +a
dbt build --project-dir dbt
```