# C3W2: Building a Data Lakehouse with AWS Lake Formation and Apache Iceberg

## 🎯 Assignment Overview
Built a production-grade Data Lakehouse using medallion architecture (Landing → Curated → Presentation zones) with AWS Lake Formation, Apache Iceberg tables, and Terraform IaC.

## 🏗️ Architecture
**Data Sources:**
- MySQL RDS database (classic car retailer data)
- S3 streaming service (product ratings JSON)

**Medallion Layers:**
1. **Landing Zone**: Raw data ingestion from RDS + S3
2. **Curated Zone**: Enriched, schema-enforced data in Glue Catalog
3. **Presentation Zone**: Business objects via Athena queries

**Technologies:**
- AWS Glue Jobs (ETL)
- Apache Iceberg (table format with ACID transactions)
- AWS Lake Formation (permissions & governance)
- Amazon Athena (serverless SQL queries)
- Terraform (Infrastructure as Code)

## ✅ Completed Graded Exercises

### 3.1.2: RDS Connection Configuration
- Configured AWS Glue Connection to MySQL RDS
- Set JDBC_CONNECTION_URL, USERNAME, PASSWORD in Terraform

### 4.1.2: Add Metadata Function
```python
source_pd['source'] = "classic_models_mysql"
source_schema.add(StructField("ingest_ts", TimestampType(), True))
```

### 4.1.3: Enforce Schema Function
```python
if isinstance(field_type, IntegerType):
    source_pd[field_name] = pd.to_numeric(source_pd[field_name], errors='coerce')
    source_pd[field_name] = source_pd[field_name].replace(np.nan, 0)
    source_pd[field_name] = source_pd[field_name].astype(np.int64)
elif isinstance(field_type, DoubleType):
    source_pd[field_name] = pd.to_numeric(source_pd[field_name], errors='coerce')
    source_pd[field_name] = source_pd[field_name].replace(np.nan, 0.0)
    source_pd[field_name] = source_pd[field_name].astype(np.float16)
elif isinstance(field_type, DateType):
    source_pd[field_name] = pd.to_datetime(source_pd[field_name])
```

### 4.2.1: Latest Ratings Query (Iceberg)
```sql
SELECT * 
FROM ratings 
WHERE ingest_ts = (SELECT MAX(ingest_ts) FROM ratings);
```

### 4.2.3: Iceberg Job Configuration
```hcl
default_arguments = {
  "--job-language"     = "python"
  "--datalake-formats" = "iceberg"
}
timeout = 7
number_of_workers = 2
```

### 4.2.4: Multi-Table Join Query
```sql
SELECT CAST(c.customerNumber AS INTEGER) AS customerNumber,
       c.city, c.state, c.postalCode, c.country, c.creditLimit,
       r.productCode, r.productRating,
       p.productLine, p.productScale, p.quantityInStock, p.buyPrice, p.MSRP
FROM ratings r 
JOIN products p ON p.productCode = r.productCode 
JOIN customers c ON c.customerNumber = r.customerNumber;
```

### 5.3: Presentation Layer - ratings_for_ml Table
```python
ctas_query = f"""CREATE TABLE ratings_for_ml WITH (
    table_type = 'ICEBERG',
    location = 's3://{DATA_LAKE_BUCKET_NAME}/presentation_zone/ratings_for_ml',
    is_external = false
) AS
SELECT customerNumber, city, state, postalCode, country, creditLimit, 
       productCode, productLine, productScale, quantityinstock, buyprice, msrp, 
       productRating, CAST(process_ts AS VARCHAR) AS process_ts
FROM {CURATED_DATABASE_NAME}.ratings_for_ml;"""
```

### 5.5: Presentation Layer - ratings_per_product Table
```python
ctas_query = f"""CREATE TABLE ratings_per_product WITH (
    table_type = 'ICEBERG',
    location = 's3://{DATA_LAKE_BUCKET_NAME}/presentation_zone/ratings_per_product',
    is_external = false
) AS 
SELECT p.productcode, p.productname,
       AVG(productrating) AS avg_rating,
       COUNT(*) AS review_count
FROM {CURATED_DATABASE_NAME}.products p
LEFT JOIN {CURATED_DATABASE_NAME}.ratings r ON p.productcode = r.productcode
GROUP BY p.productcode, p.productname
ORDER BY review_count DESC, avg_rating;"""
```

## 🔑 Key Concepts Learned

### Apache Iceberg Features
1. **Schema Evolution**: Add/remove columns without rewriting data
2. **ACID Transactions**: Atomic commits ensure data consistency
3. **Time Travel**: Query historical snapshots via `FOR VERSION AS OF`
4. **Partitioning**: Optimize query performance on large datasets
5. **Metadata Management**: Separate metadata from data files

### Lake Formation Governance
- Fine-grained access control (database/table/column level)
- Data location permissions
- Role-based access management
- Integration with Glue Catalog

### ETL Best Practices
- Metadata enrichment (source, ingest_ts)
- Schema enforcement (type casting, null handling)
- Incremental updates (MERGE INTO for Iceberg)
- Compression (Parquet with Snappy/Gzip)

## 📊 Data Pipeline Flow

```
┌─────────────┐     ┌──────────────┐
│  MySQL RDS  │────▶│ Landing Zone │
└─────────────┘     │   (Raw CSV)  │
                    └──────┬───────┘
┌─────────────┐            │
│ S3 Streaming│────────────┘
│ (JSON)      │     
└─────────────┘     
                    ┌──────▼───────┐
                    │ Curated Zone │
                    │  (Parquet +  │
                    │   Iceberg)   │
                    └──────┬───────┘
                           │
                    ┌──────▼───────────┐
                    │ Presentation Zone│
                    │   (Iceberg)      │
                    │  - ratings       │
                    │  - ratings_for_ml│
                    │  - sales_report  │
                    │  - ratings_per_  │
                    │    product       │
                    └──────────────────┘
                           │
                    ┌──────▼───────┐
                    │ Amazon Athena│
                    │  (SQL Queries)│
                    └──────────────┘
```

## 🚀 Deployment Steps

1. **Setup**: Grant Lake Formation permissions to Glue role
2. **Landing Zone**: Deploy RDS + S3 ingestion Glue jobs
3. **Curated Zone**: Deploy transformation jobs (CSV + JSON → Iceberg)
4. **Presentation Zone**: Create business tables via Athena CTAS queries
5. **Optional**: Schema evolution, versioning, user permissions

## 📁 Key Files
- `terraform/modules/landing_etl/glue.tf` - RDS connection config
- `terraform/assets/transform_etl_jobs/de_c3w2a1_batch_transform.py` - CSV ETL
- `terraform/assets/transform_etl_jobs/de_c3w2a1_ratings_to_iceberg.py` - Iceberg merge
- `terraform/assets/transform_etl_jobs/de_c3w2a1_json_transform.py` - Multi-table join
- `terraform/modules/transform_etl/glue.tf` - Iceberg job config
- `C3_W2_Assignment.ipynb` - Main assignment notebook

## 🎓 Skills Demonstrated
- Data Lakehouse architecture design
- Apache Iceberg table management
- AWS Glue ETL development (PySpark)
- Lake Formation governance
- Terraform IaC for AWS data services
- SQL optimization for analytical queries
- Medallion architecture implementation

---

**Status**: ✅ All graded exercises completed  
**GitHub**: [View Assignment](https://github.com/anix-lynch/deeplearning-ai-data-engineering-certificate/tree/main/module3/week2)
