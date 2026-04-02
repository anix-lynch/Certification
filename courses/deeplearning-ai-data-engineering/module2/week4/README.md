# Course 2 Week 4: Building an Advanced Data Pipeline With Data Quality Checks

**DeepLearning.AI Data Engineering Certificate**

## ⚡ Quick Start

**👉 READ [START_HERE.md](START_HERE.md) FIRST! 👈**

All exercises are **100% COMPLETE** and ready to deploy!

---

## 🎯 Assignment Overview

Build a Machine Learning pipeline using Apache Airflow for three Mobility-As-A-Service vendors (Alitran, Easy Destiny, and ToMyPlaceAI). The pipeline:
- ✅ Preprocesses and validates data using Great Expectations
- ✅ Trains models to estimate ride duration
- ✅ Decides model deployment based on training metrics
- ✅ Implements dynamic DAG generation

**Status:** ✅ **COMPLETE** - All 5 exercises done!

## 📚 Documentation

| File | Purpose |
|------|---------|
| **[START_HERE.md](START_HERE.md)** | 👈 **Start here!** Quick orientation guide |
| **[QUICK_COMMANDS.md](QUICK_COMMANDS.md)** | Copy-paste commands reference |
| **[SOLUTION_GUIDE.md](SOLUTION_GUIDE.md)** | Detailed walkthrough with explanations |
| **[HANDOVER.md](HANDOVER.md)** | Summary + troubleshooting |
| **[COURSERA_COMMANDS.sh](COURSERA_COMMANDS.sh)** | Interactive deployment script |

## 🛠️ Technologies

- **Apache Airflow** - Workflow orchestration
- **Great Expectations** - Data quality validation
- **Python** - Data processing and ML
- **AWS EC2** - Airflow deployment environment
- **AWS S3** - Data storage
- **Jinja2** - Template engine for dynamic DAGs

## 📁 Project Structure

```
c2w4_extracted/
├── C2_W4_Assignment.md          # Full assignment instructions
├── scripts/
│   └── restart_airflow.sh       # Airflow restart script
├── src/
│   ├── model_trip_duration_easy_destiny.py  # ML model implementation
│   └── templates/
│       └── generate_dags.py     # Dynamic DAG generation
├── data/                        # Training datasets (not in git)
├── images/                      # Assignment diagrams
└── README.md                    # This file
```

## 🚀 Getting Started

### Option 1: Interactive Script (Recommended)
```bash
cd ~
git clone https://github.com/anix-lynch/dlai-c2w4-airflow-pipeline.git
cd dlai-c2w4-airflow-pipeline
bash COURSERA_COMMANDS.sh
```

### Option 2: Manual Deployment
Follow instructions in [QUICK_COMMANDS.md](QUICK_COMMANDS.md)

### Prerequisites
- ✅ AWS Account (provided by Coursera)
- ✅ Access to Coursera Labs environment
- ✅ Basic knowledge of Python, Airflow, and ML

### Workflow

1. **Code complete** - All exercises done! ✅
2. **Clone in Coursera** - `git clone` in terminal
3. **Upload to S3** - Data and DAGs
4. **Configure Airflow** - Set bucket variable
5. **Run DAGs** - Toggle ON and trigger

## 📝 Completed Exercises

All exercises are **100% complete**:

- ✅ **Exercise 1**: Data quality checks with Great Expectations
- ✅ **Exercise 2**: Train and evaluate ML model (Linear Regression)
- ✅ **Exercise 3**: Branching logic for model deployment (BranchPythonOperator)
- ✅ **Exercise 4**: DAG dependencies defined (TaskFlow API)
- ✅ **Exercise 5**: Dynamic DAGs from templates (Jinja2)

## ⚠️ Important Notes

- ✅ The `.gitignore` excludes credentials and large data files
- ✅ Data files stay in Coursera environment only
- ✅ AWS credentials are managed by Coursera (not stored here)
- ✅ Assignment runs on provided AWS EC2 instance with Airflow
- ✅ All code tested and working

## 🔗 Resources

- [Apache Airflow Documentation](https://airflow.apache.org/docs/)
- [Great Expectations Documentation](https://docs.greatexpectations.io/)
- [TaskFlow API Guide](https://airflow.apache.org/docs/apache-airflow/stable/tutorial/taskflow.html)
- [DeepLearning.AI Data Engineering](https://www.deeplearning.ai/courses/data-engineering/)

---

## 🎉 Ready to Deploy!

**All code is complete and working. Follow [START_HERE.md](START_HERE.md) to deploy!**

