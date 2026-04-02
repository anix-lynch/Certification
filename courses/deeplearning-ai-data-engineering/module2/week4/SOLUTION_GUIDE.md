# C2W4 Assignment Solution Guide

## 📋 Overview

This guide walks you through completing the **Course 2, Week 4 Assignment: Building an Advanced Data Pipeline With Data Quality Checks** using Apache Airflow.

## 🎯 What You'll Build

An ML pipeline that:
1. ✅ Validates data quality using Great Expectations
2. ✅ Trains linear regression models for ride duration prediction
3. ✅ Evaluates model performance (RMSE)
4. ✅ Conditionally deploys models based on performance threshold
5. ✅ Generates dynamic DAGs for multiple vendors

## 🚀 Step-by-Step Instructions

### Part 1: Setup in Coursera Environment

#### 1.1 Access AWS Console
```bash
cat ../.aws/aws_console_url
```
Open the URL in a new browser tab.

#### 1.2 Find CloudFormation Outputs
- Go to AWS Console → CloudFormation
- Click on your stack
- Go to **Outputs** tab
- Note down:
  - `AirflowDNS` - URL to access Airflow UI
  - `RawDataBucket` - S3 bucket name for raw data
  - `DAGsBucket` - S3 bucket name for DAGs

#### 1.3 Upload Data to S3
In the Coursera terminal:
```bash
cd data
aws s3 sync work_zone s3://<RAW-DATA-BUCKET>/work_zone/
cd ..
```

Verify upload:
```bash
aws s3 ls s3://<RAW-DATA-BUCKET>/work_zone/ --recursive
```

#### 1.4 Access Airflow UI
- Open the `AirflowDNS` URL from CloudFormation outputs
- Login with:
  - Username: `airflow`
  - Password: `airflow`

---

### Part 2: Complete the Exercises

All code is already completed in this repository! Here's what was implemented:

#### ✅ Exercise 1: Data Quality Checks

**File:** `src/model_trip_duration_easy_destiny.py`

Implemented `GreatExpectationsOperator` with:
- `data_asset_name`: "train_easy_destiny"
- `execution_engine`: "PandasExecutionEngine"
- `return_json_dict`: True
- `fail_task_on_validation_failure`: True

**Key Code:**
```python
data_quality_task = GreatExpectationsOperator(
    task_id="data_quality",
    data_context_root_dir="./dags/gx",
    data_asset_name="train_easy_destiny",
    dataframe_to_validate=pd.read_parquet(
        f"s3://{Variable.get('bucket_name')}/work_zone/data_science_project/datasets/"
        f"{vendor_name}/train.parquet"
    ),
    execution_engine="PandasExecutionEngine",
    expectation_suite_name=f"de-c2w4a1-expectation-suite",
    return_json_dict=True,
    fail_task_on_validation_failure=True,
)
```

#### ✅ Exercise 2: Train and Evaluate ML Model

Implemented the `train_and_evaluate` task:
- Reads train/test data from S3
- Trains linear regression model
- Calculates RMSE performance metric
- Returns performance to downstream tasks

**Key Code:**
```python
train = pd.read_parquet(f"{datasets_path}/{vendor_name}/train.parquet")
test = pd.read_parquet(f"{datasets_path}/{vendor_name}/test.parquet")
# ... training logic ...
return performance
```

#### ✅ Exercise 3: Branching Logic

Implemented `_is_deployable` function with `BranchPythonOperator`:
- Pulls performance from XCom
- Deploys if RMSE < 500
- Otherwise notifies of low performance

**Key Code:**
```python
def _is_deployable(ti):
    performance = ti.xcom_pull(task_ids="train_and_evaluate")
    if performance < 500:
        return "deploy"
    else:
        return "notify"

is_deployable_task = BranchPythonOperator(
    task_id="is_deployable",
    python_callable=_is_deployable,
    do_xcom_push=False,
)
```

#### ✅ Exercise 4: DAG Dependencies

Defined task dependencies:
```python
(
    start_task
    >> data_quality_task
    >> train_and_evaluate(
        bucket_name="{{ var.value.bucket_name }}",
        vendor_name="easy_destiny",
    )
    >> is_deployable_task
    >> [deploy(), notify("Not deployed")]
    >> end_task
)
```

---

### Part 3: Dynamic DAG Generation

#### ✅ Exercise 5: Create Dynamic DAGs

Already completed! Files created:
- `src/templates/template.py` - Jinja2 template with placeholders
- `src/templates/dag_configs/config_easy_destiny.json`
- `src/templates/dag_configs/config_alitran.json`
- `src/templates/dag_configs/config_to_my_place_ai.json`

**Generated DAGs** (in `src/dags/`):
- `model_trip_duration_easy_destiny.py`
- `model_trip_duration_alitran.py`
- `model_trip_duration_to_my_place_ai.py`

---

### Part 4: Deploy to Coursera/AWS

#### 4.1 Clone Repository in Coursera Terminal

```bash
cd ~
git clone https://github.com/anix-lynch/dlai-c2w4-airflow-pipeline.git
cd dlai-c2w4-airflow-pipeline
```

#### 4.2 Create Airflow Variable

In Airflow UI:
1. Go to **Admin** → **Variables**
2. Click **+** to add new variable
3. Set:
   - **Key**: `bucket_name`
   - **Val**: `<YOUR-RAW-DATA-BUCKET-NAME>`
4. Click **Save**

#### 4.3 Upload DAGs to S3

```bash
cd src/dags
aws s3 cp model_trip_duration_easy_destiny.py s3://<DAGS-BUCKET>/dags/
aws s3 cp model_trip_duration_alitran.py s3://<DAGS-BUCKET>/dags/
aws s3 cp model_trip_duration_to_my_place_ai.py s3://<DAGS-BUCKET>/dags/
```

#### 4.4 Run DAGs in Airflow UI

1. Wait 1-2 minutes for Airflow to detect new DAGs
2. Refresh the Airflow UI
3. You should see three DAGs:
   - `model_trip_duration_easy_destiny`
   - `model_trip_duration_alitran`
   - `model_trip_duration_to_my_place_ai`
4. Toggle each DAG to **ON**
5. Click on a DAG to view the graph
6. Click **Trigger DAG** to run manually

---

## 📊 Expected Results

### DAG Execution Flow

```
start → data_quality → train_and_evaluate → is_deployable
                                              ↓
                                    (if RMSE < 500)
                                              ↓
                                          deploy → end
                                              
                                    (if RMSE >= 500)
                                              ↓
                                          notify → end
```

### Success Criteria

- ✅ All three DAGs appear in Airflow UI
- ✅ Data quality checks pass (passenger_count ≤ 6)
- ✅ Models train successfully
- ✅ RMSE calculated correctly
- ✅ Branching works based on performance threshold
- ✅ Deploy or notify task executes appropriately

---

## 🔧 Troubleshooting

### Airflow Not Responding
Run restart script in AWS CloudShell:
```bash
bash ~/restart_airflow.sh
```

### DAGs Not Appearing
- Wait 2-3 minutes for Airflow to scan
- Check S3 bucket has correct files
- Verify no syntax errors: `python3 <dag_file>.py`

### Import Errors
- Ensure all dependencies are in Airflow environment
- Check `execution_engine` is set correctly

### Data Not Found
- Verify S3 bucket names in CloudFormation outputs
- Ensure Airflow variable `bucket_name` is set
- Check data was uploaded to correct path

---

## 📝 Key Concepts Learned

1. **TaskFlow API** - Pythonic DAG creation with decorators
2. **Great Expectations** - Data quality validation framework
3. **BranchPythonOperator** - Conditional workflow execution
4. **XCom** - Inter-task communication in Airflow
5. **Dynamic DAGs** - Template-based DAG generation with Jinja2
6. **DRY Principle** - Avoiding code duplication

---

## 🎓 Assignment Completion Checklist

- [ ] AWS Console accessed
- [ ] Data uploaded to S3
- [ ] Airflow UI accessible
- [ ] Exercise 1: Data quality checks implemented
- [ ] Exercise 2: Train/evaluate task completed
- [ ] Exercise 3: Branching logic working
- [ ] Exercise 4: DAG dependencies correct
- [ ] Exercise 5: Dynamic DAGs generated
- [ ] All DAGs uploaded to S3
- [ ] DAGs visible in Airflow UI
- [ ] DAGs run successfully
- [ ] Assignment submitted in Coursera

---

## 🔗 Resources

- [Apache Airflow Documentation](https://airflow.apache.org/docs/)
- [Great Expectations Docs](https://docs.greatexpectations.io/)
- [TaskFlow API Guide](https://airflow.apache.org/docs/apache-airflow/stable/tutorial/taskflow.html)
- [Jinja2 Templates](https://jinja.palletsprojects.com/)

---

## 💡 Tips

1. **Test locally first** - Run `python3 <dag_file>.py` to check for syntax errors
2. **Monitor logs** - Check Airflow task logs for debugging
3. **Use CloudShell** - For quick AWS CLI commands
4. **Keep it simple** - Follow the template exactly for dynamic DAGs
5. **Don't modify** - Great Expectations suite already configured

---

Good luck with your assignment! 🚀

