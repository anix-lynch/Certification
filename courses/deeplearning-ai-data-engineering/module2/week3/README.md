# Week 3: Testing Data Quality with Great Expectations

## Assignment: Data Quality Validation Pipeline
**Status**: ✅ Completed & Submitted  
**Grade**: Passed  
**Date**: January 15, 2026

## Overview
Implemented a comprehensive data quality validation workflow using Great Expectations (GX) to validate a MySQL database containing taxi trip data. Configured S3-backed stores for expectations, validations, checkpoints, and data documentation.

**Key Achievement**: All 6 exercises completed successfully, with actual execution outputs preserved in the notebook. The notebook demonstrates a complete GX workflow from setup to validation execution.

## Technologies Used
- **Great Expectations (GX)**: Data quality validation framework
- **Python**: Core programming language
- **MySQL**: Source database (taxi_trips)
- **AWS S3**: Backend storage for GX artifacts and data docs
- **AWS RDS**: MySQL database hosting
- **Libraries**:
  - `great_expectations`: Data validation framework
  - `pymysql`: MySQL database connector
  - `boto3`: AWS SDK for S3 operations

## What We Accomplished

### 1. Great Expectations Setup
- Initialized GX project with `great_expectations init`
- Configured S3 backend stores for:
  - Expectations Store
  - Validations Store
  - Checkpoint Store
  - Data Docs Site
- Set up MySQL connection via config variables

### 2. Data Context & Data Source
- Created File Data Context backed by S3 buckets
- Connected to MySQL database (`taxi_trips` database)
- Created SQL Data Source with connection string
- Defined Table Data Asset for `trips` table

### 3. Batch Requests
- **Exercise 1**: Created column value splitter on `vendor_id`
- Generated batch requests for each vendor (vendor_id: 1, 2, 4)
- Built batch request list for validation workflow

### 4. Expectation Suite & Validator
- **Exercise 2**: Created expectation suite `de-c2w3a1-expectation-suite-trips-taxi-db`
- **Exercise 3**: Instantiated validator with batch requests and expectation suite
- **Exercise 4**: Added three expectations:
  - `pickup_datetime` must not be null
  - `passenger_count` must not be null
  - `congestion_surcharge` must be between 0 and 1000

### 5. Validations List
- **Exercise 5**: Created validations list with batch request and expectation suite pairs
- Prepared validation configuration for checkpoint execution

### 6. Checkpoints & Validation Execution
- **Exercise 6**: Created checkpoint with timestamp-based naming
- Configured actions:
  - `StoreValidationResultAction`: Save results to S3
  - `UpdateDataDocsAction`: Update data documentation
- Executed validations across all batches
- Built data docs and published to S3

### 7. Data Quality Testing
- Inserted test data violating expectations (congestion_surcharge = 1001)
- Re-ran validations to detect data quality issues
- Verified failed validations in data docs
- Confirmed expectation suite correctly identifies data problems

## Key Concepts Learned

### Great Expectations Architecture
- **Data Context**: Central configuration and entry point
- **Data Sources**: Connections to data systems (SQL, files, etc.)
- **Data Assets**: Specific datasets within a source
- **Batch Requests**: Specifications for data retrieval
- **Expectation Suites**: Collections of data quality rules
- **Validators**: Components that execute expectations
- **Checkpoints**: Automated validation workflows
- **Data Docs**: Human-readable validation reports

### S3 Backend Configuration
- Configured stores to use `TupleS3StoreBackend` instead of local filesystem
- Benefits: Accessibility, scalability, durability
- Separate buckets for artifacts vs. documentation

### Data Quality Patterns
- Column-level validations (null checks, value ranges)
- Batch-based validation (split by vendor_id)
- Automated checkpoint execution
- Data documentation for stakeholders

## File Structure
```
week3/
├── C2_W3_Assignment.ipynb    # Main assignment notebook (all exercises complete)
├── gx/
│   ├── great_expectations.yml # GX configuration with S3 backends
│   └── uncommitted/
│       └── config_variables.yml.template  # MySQL connection template
├── scripts/
│   └── setup.sh              # Environment setup script
├── src/
│   ├── env.template          # Credential template
│   └── env                   # Actual credentials (gitignored)
├── images/                   # Assignment screenshots and diagrams
└── README.md                 # This file
```

## S3 Bucket Configuration

### Artifacts Bucket
- **Name**: `de-c2w3a1-930379037702-us-east-1-gx-artifacts`
- **Contents**:
  - `expectations/`: Expectation suite definitions
  - `validations/`: Validation results
  - `checkpoints/`: Checkpoint configurations

### Docs Bucket
- **Name**: `de-c2w3a1-930379037702-us-east-1-gx-docs`
- **Contents**:
  - HTML data documentation
  - Validation reports
  - Expectation suite overviews

## Running the Code

### Setup in Coursera Environment
```bash
cd /home/coder/project

# Download notebook
curl -o C2_W3_Assignment.ipynb https://raw.githubusercontent.com/anix-lynch/deeplearning-ai-data-engineering-certificate/main/module2/week3/C2_W3_Assignment.ipynb

# Download setup script
mkdir -p scripts
curl -o scripts/setup.sh https://raw.githubusercontent.com/anix-lynch/deeplearning-ai-data-engineering-certificate/main/module2/week3/scripts/setup.sh
chmod +x scripts/setup.sh

# Initialize GX
source scripts/setup.sh
great_expectations init  # Type 'Y' when prompted

# Configure YAML (download pre-configured version)
curl -o gx/great_expectations.yml https://raw.githubusercontent.com/anix-lynch/deeplearning-ai-data-engineering-certificate/main/module2/week3/gx/great_expectations.yml

# Add MySQL connection string
echo "MYSQL_CONNECTION_STRING: mysql+pymysql://admin:adminpwrd@<DBHOST>:3306/taxi_trips" >> gx/uncommitted/config_variables.yml
# Replace <DBHOST> with RDS endpoint from setup.sh output

# Verify stores
great_expectations store list
```

### Execute Notebook
```bash
# Open and run all cells in C2_W3_Assignment.ipynb
# All exercises are already completed
```

### Verify Results
```bash
# Check S3 artifacts
aws s3 ls s3://de-c2w3a1-930379037702-us-east-1-gx-artifacts/expectations/ --recursive
aws s3 ls s3://de-c2w3a1-930379037702-us-east-1-gx-artifacts/validations/ --recursive
aws s3 ls s3://de-c2w3a1-930379037702-us-east-1-gx-artifacts/checkpoints/ --recursive

# Check data docs
aws s3 ls s3://de-c2w3a1-930379037702-us-east-1-gx-docs/ --recursive | head -20

# List expectation suites
python3 -c "import great_expectations as gx; ctx = gx.get_context(); print('Expectation suites:', ctx.list_expectation_suite_names())"
```

## Exercises Completed

✅ **Exercise 1**: Column value splitter and batch requests  
✅ **Exercise 2**: Expectation suite creation  
✅ **Exercise 3**: Validator instantiation  
✅ **Exercise 4**: Three expectations added  
✅ **Exercise 5**: Validations list creation  
✅ **Exercise 6**: Checkpoint creation and execution  

## Key Outputs

1. **Expectation Suite**: `de-c2w3a1-expectation-suite-trips-taxi-db`
   - 3 expectations defined
   - Stored in S3 artifacts bucket

2. **Validations**: 6 validation results
   - 3 batches × 2 checkpoint runs
   - One run with clean data (all passed)
   - One run with bad data (1 failed expectation)

3. **Checkpoint**: `de-c2w3a1-checkpoint-trips-<TIMESTAMP>`
   - Configured with validation actions
   - Stored in S3 artifacts bucket

4. **Data Docs**: HTML documentation in S3
   - Validation results visualization
   - Expectation suite overview
   - Failed validation details

## Notes

- All exercises completed and tested
- Credentials are gitignored for security
- GX configuration uses S3 backends (not local filesystem)
- Data docs accessible via S3 static website hosting
- Notebook cells execute successfully without errors
- **Notebook contains actual execution outputs** (not just code) - ready for review/interview prep
- **Note on "Output exceeds size limit"**: Some cells show this message for large JSON outputs (like checkpoint configs). This is normal Jupyter behavior - the data is still there, just truncated for display. Click "Open the full output" if needed.

## Understanding the Implementation

### What Was Built
1. **Data Context**: Central GX configuration with S3 backends for persistence
2. **Data Source**: MySQL connection to `taxi_trips` database
3. **Data Asset**: Table asset for `trips` table
4. **Batch Requests**: Split data by `vendor_id` column (3 batches: vendor_id 1, 2, 4)
5. **Expectation Suite**: Collection of 3 data quality rules
6. **Validator**: Component that executes expectations against batches
7. **Checkpoint**: Automated workflow that runs validations and stores results

### Great Expectations Concepts (Interview Prep)

**Data Context**: The entry point for GX - manages configuration, stores, and provides API access. Think of it as the "brain" of your data quality system.

**Data Source**: Connection to your data (SQL database, files, etc.). In this case, MySQL database.

**Data Asset**: Specific dataset within a source (e.g., a table). Represents what you want to validate.

**Batch Request**: Specification for retrieving data. Can split data into batches (e.g., by vendor_id) for parallel validation.

**Expectation Suite**: Collection of data quality rules (expectations). Like unit tests for data.

**Validator**: Executes expectations against data batches. Returns pass/fail results.

**Checkpoint**: Automated workflow that:
- Takes batch requests + expectation suite
- Creates validator
- Runs validations
- Stores results
- Updates data docs

**Data Docs**: Human-readable HTML reports showing validation results, expectation suites, and data quality metrics.

### Why S3 Backends?
- **Accessibility**: Multiple team members can access from anywhere
- **Scalability**: Handles growing metadata without local storage limits
- **Durability**: AWS S3 provides 99.999999999% durability
- **Separation**: Artifacts (expectations/validations) separate from docs (HTML reports)

## Next Steps

- Week 4: Advanced pipeline orchestration with Apache Airflow
- Integration of GX validations into production data pipelines
- Automated data quality monitoring
