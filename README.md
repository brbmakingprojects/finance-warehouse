# Financial Transactions Data Warehouse

A end-to-end data warehouse project built to demonstrate core data engineering
and analytics skills relevant to financial services environments.

## Project overview

This project simulates a financial transactions data warehouse for a retail
banking context. It covers the full data lifecycle: raw ingestion, staged
cleaning, dimensional modelling, data quality testing, and auto-generated
documentation.

## Tech stack

| Tool         | Purpose                          | Cost  |
|--------------|----------------------------------|-------|
| PostgreSQL   | Local data warehouse engine      | Free  |
| dbt Core     | Transformation & documentation   | Free  |
| DBeaver      | SQL GUI & schema explorer        | Free  |

## Architecture

Raw data (PostgreSQL) → Staging models (dbt) → Mart models (dbt)

### Staging layer (`models/staging/`)
One model per source table. Responsible for light cleaning only:
renaming columns, trimming whitespace, casting types, and adding a
`data_quality_flag` field to surface invalid records at source.

| Model                  | Source table            |
|------------------------|-------------------------|
| stg_customers          | raw.dim_customer        |
| stg_merchants          | raw.dim_merchant        |
| stg_dates              | raw.dim_date            |
| stg_payment_methods    | raw.dim_payment_method  |
| stg_transactions       | raw.fact_transactions   |

### Mart layer (`models/mart/`)
Analysis-ready tables joining all dimensions onto the fact table.

| Model                      | Description                                      |
|----------------------------|--------------------------------------------------|
| mart_transactions          | Wide table — one row per transaction with full   |
|                            | customer, merchant, date, and payment context    |
| mart_flagged_transactions  | Filtered fraud review layer — flagged records    |
|                            | only, ordered by amount descending               |

## Data model

Star schema with one fact table and four dimensions:

- `fact_transactions` — 500 synthetic transactions (2024)
- `dim_customer` — 20 customers with country and risk tier
- `dim_merchant` — 15 UK and international merchants
- `dim_date` — every calendar day in 2024 with time attributes
- `dim_payment_method` — 6 payment methods (card, digital, bank transfer)

## Data quality & governance

33 dbt schema tests across all models covering:

- **Uniqueness** — primary keys on all dimension and fact tables
- **Not null** — all critical fields validated
- **Referential integrity** — foreign key relationships enforced
- **Accepted values** — risk_tier and payment method type validation
- **Custom quality flag** — transactions flagged for invalid amounts
  or missing foreign keys via `data_quality_flag` field

Run all tests:
```
dbt test
```

## How to run this project

### Prerequisites
- macOS with Homebrew
- PostgreSQL 16 (`brew install postgresql@16`)
- Python 3.8+ with dbt-postgres (`pip3 install dbt-postgres`)
- DBeaver Community Edition

### Setup

1. Create the database:
```
createdb financedb
```

2. Run the seed SQL script in DBeaver to create raw schema and load data.

3. Configure `~/.dbt/profiles.yml` with your local PostgreSQL credentials.

4. Build all models:
```
dbt run
```

5. Run tests:
```
dbt test
```

6. View documentation:
```
dbt docs generate && dbt docs serve
```

## Skills demonstrated

- Dimensional modelling (star schema, fact and dimension tables)
- ETL pipeline design (raw → staging → mart)
- SQL data transformation and profiling
- Data quality framework with 33 automated tests
- Data lineage and governance documentation
- Regulatory awareness (risk tiering, fraud flagging, GDPR-relevant fields)