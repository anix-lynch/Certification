# C4 W1 Assignment Notes: Data Modeling with dbt

## 📅 Date: 2025-11-29
## 🎯 Assignment
Complete the "Data Modeling with dbt" assignment for Course 4 Week 1 of the DeepLearning.AI Data Engineering Certificate.

## ✅ Status
- **GitHub Repo:** Updated and synced. All dbt models, scripts, and configs are in `module4/week1/`.
- **Coursera Environment:**
  - `dbt init` completed.
  - Models and configs copied from repo.
  - `dbt run` **SUCCESSFUL**.
  - Tables created in schemas: `classicmodels_star_schema` and `classicmodels_obt`.
  - Row counts verified in `dbt run` logs (e.g., `fact_orders`: 2996 rows).

## ❌ Issue
**Grade Received: 0%**
The grader checks for row counts (e.g., `classicmodels_star_schema.fact_orders rows count output`) but awards 0 points.

## 🔍 Investigation Notes
1. **Schemas:** We configured `dbt_project.yml` to use `star_schema` and `obt` schemas. The `dbt run` output confirms tables were created there:
   - `created sql table model classicmodels_star_schema.fact_orders`
   - `created sql table model classicmodels_obt.orders_obt`
2. **Materialization:** We set `+materialized: table` in `dbt_project.yml`. The logs confirm `CREATE TABLE` (implied by "created sql table model").
3. **Row Counts:**
   - `fact_orders`: 2996
   - `dim_customers`: 122
   - `dim_dates`: 1095
   - `dim_employees`: 23
   - `dim_offices`: 7
   - `dim_products`: 110
   - `orders_obt`: 2996
   These counts look reasonable for the `classicmodels` dataset.

## 🛠️ Troubleshooting Notes
1. **Check Grader Expectations:** Does the grader expect **views** instead of tables?
2. **Schema Name:** Verify if the grader expects the default `public` schema or `classicmodels` schema instead of custom schemas. (Though the error message `classicmodels_star_schema.fact_orders` implies it *does* look in that schema).
3. **Permissions:** Ensure the grader user has `USAGE` on the new schemas.
4. **Data Freshness:** Did we query the right source data? (We used `source('classicmodels', '...')`).

## 📂 Key Files
- `module4/week1/scripts/dbt_project.yml`: Project config (schemas, materialization).
- `module4/week1/scripts/schema.yml`: Sources and model definitions.
- `module4/week1/models/`: SQL model files.
