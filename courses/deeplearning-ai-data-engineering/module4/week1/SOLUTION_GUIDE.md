# Module 4 Week 1: Data Modeling with dbt

**Status**: 🚀 Ready to Run

---

## 📋 Assignment Overview

This assignment implements two data modeling techniques using **dbt (data build tool)** on a PostgreSQL database:
1. **Star Schema**: Fact and Dimension tables
2. **One Big Table (OBT)**: Denormalized table for analytics

---

## 🚀 Quick Start Guide (Coursera Terminal)

### 1. Pull Latest Code
```bash
cd ~/project
git pull origin main
```

### 2. Setup dbt Project
```bash
# Initialize project (if not already done)
dbt init classicmodels_modeling

# Copy configuration files
cp ./scripts/packages.yml ./classicmodels_modeling/
cp ./scripts/profiles.yml ./classicmodels_modeling/
cp ./scripts/schema.yml ./classicmodels_modeling/models/

# Copy models
cp -r ./models/star_schema ./classicmodels_modeling/models/
cp -r ./models/obt ./classicmodels_modeling/models/
```

### 3. Configure Database Connection
1. Run the notebook cell to get the AWS Console URL.
2. Go to **RDS** -> **Databases** -> `de-c4w1-rds`.
3. Copy the **Endpoint**.
4. Edit `profiles.yml` and replace `<DATABASE_ENDPOINT>` with the actual endpoint.

### 4. Run dbt
```bash
cd classicmodels_modeling

# Install dependencies
dbt deps

# Run models
dbt run

# Run tests
dbt test
```

---

## 📂 Project Structure

```
module4/week1/
├── models/
│   ├── star_schema/       # Fact and Dimension tables
│   │   ├── fact_orders.sql
│   │   ├── dim_customers.sql
│   │   ├── dim_employees.sql
│   │   ├── dim_offices.sql
│   │   ├── dim_products.sql
│   │   └── dim_date.sql
│   └── obt/               # One Big Table
│       └── obt_sales_overview.sql
├── scripts/
│   ├── packages.yml       # dbt dependencies
│   ├── profiles.yml       # Connection profile template
│   └── schema.yml         # Model documentation & tests
└── C4_W1_Assignment.ipynb # Jupyter Notebook
```

---

## 🛠️ dbt Models

### Star Schema
- **Fact Table**: `fact_orders` (Transactions)
- **Dimensions**:
  - `dim_customers`
  - `dim_employees`
  - `dim_offices`
  - `dim_products`
  - `dim_date`

### OBT
- `obt_sales_overview`: Joins all facts and dimensions into a single table.

---

## ✅ Success Criteria

- [ ] `dbt run` completes successfully for all 7 models.
- [ ] `dbt test` passes for all defined tests (unique, not_null).
- [ ] Tables are created in the PostgreSQL database.
