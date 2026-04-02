# Module 2: Source Systems, Data Ingestion, and Pipelines

**Course**: Data Engineering Professional Certificate (Course 2)  
**Status**: In Progress (50%)  
**Started**: November 2025

---

## 📚 Weeks Overview

### ✅ Week 4: Building an Advanced Data Pipeline With Data Quality Checks

**Status**: ✅ **COMPLETED** (December 2025)  
**Assignment**: Apache Airflow ML Pipeline with Great Expectations

#### What Was Built:
- 🔄 **ML Pipeline Orchestration** with Apache Airflow
- ✅ **Data Quality Validation** using Great Expectations
- 🤖 **Linear Regression Model** for ride duration prediction
- 🔀 **Conditional Branching** for model deployment
- 📊 **Dynamic DAG Generation** using Jinja2 templates
- 🚀 **Multi-Vendor Support** (Easy Destiny, Alitran, ToMyPlaceAI)

#### Technologies Used:
- **Apache Airflow** - Workflow orchestration & TaskFlow API
- **Great Expectations** - Data quality framework
- **Pandas** - Data processing
- **SciPy** - Linear regression (linregress)
- **AWS S3** - Data storage
- **AWS EC2** - Airflow hosting
- **Jinja2** - Template engine for dynamic DAGs
- **Python** - Pipeline implementation

#### Key Concepts:
- TaskFlow API with decorators
- Great Expectations data quality checks
- BranchPythonOperator for conditional execution
- XCom for inter-task communication
- Dynamic DAG generation from templates
- DRY principle in data engineering

#### Results:
✅ All 5 exercises completed  
✅ 3 dynamic DAGs generated and deployed  
✅ Data quality checks passing  
✅ ML models trained and evaluated  
✅ Conditional deployment logic working  
✅ Assignment passed successfully  

📂 **[View Week 4 Details →](week4/)**

---

### 🚧 Week 1: Troubleshooting Database Connectivity on AWS

**Status**: 🚧 **In Progress**  
**Assignment**: AWS Networking and RDS Connectivity Troubleshooting

#### What To Complete:
- Fix EC2 to RDS connectivity issues
- Troubleshoot VPC and Security Group configurations
- Resolve IAM permission issues
- Connect to PostgreSQL database
- Execute SQL queries

#### Technologies:
- AWS EC2
- AWS RDS (PostgreSQL)
- VPC & Security Groups
- AWS Systems Manager
- SQL

📂 **[View Week 1 Details →](week1/)**

---

## 🎯 Learning Outcomes

By completing this module, you will master:

### Data Pipeline Orchestration
- ✅ Apache Airflow DAG creation
- ✅ TaskFlow API with decorators
- ✅ Workflow dependency management
- ✅ Error handling and retries

### Data Quality Engineering
- ✅ Great Expectations framework
- ✅ Data validation rules
- ✅ Quality check automation
- ✅ Fail-fast strategies

### ML Pipeline Development
- ✅ Model training orchestration
- ✅ Performance evaluation
- ✅ Conditional deployment
- ✅ XCom for metrics passing

### Advanced Patterns
- ✅ Dynamic DAG generation
- ✅ Template-based development
- ✅ Multi-environment support
- ✅ DRY principle application

### AWS Cloud Services
- 🚧 EC2 instance management
- 🚧 RDS database connectivity
- 🚧 VPC and networking
- 🚧 Security group configuration

---

## 📂 Module Structure

```
module2/
├── week1/                      # 🚧 Database Connectivity Troubleshooting
│   ├── terraform/             # Infrastructure as Code
│   ├── scripts/               # Setup scripts
│   ├── sql/                   # SQL scripts
│   ├── data/                  # Sample data
│   ├── images/                # Assignment diagrams
│   ├── C1_W4_Assignment.md    # Assignment instructions
│   ├── SOLUTION_GUIDE.md      # Step-by-step solution
│   └── QUICK_COMMANDS.md      # Command reference
│
├── week4/                      # ✅ Advanced Airflow ML Pipeline
│   ├── src/
│   │   ├── model_trip_duration_easy_destiny.py  # Main DAG (completed)
│   │   ├── dags/              # Generated dynamic DAGs
│   │   │   ├── model_trip_duration_easy_destiny.py
│   │   │   ├── model_trip_duration_alitran.py
│   │   │   └── model_trip_duration_to_my_place_ai.py
│   │   └── templates/
│   │       ├── template.py    # Jinja2 template
│   │       ├── generate_dags.py
│   │       └── dag_configs/   # JSON configurations
│   ├── scripts/
│   │   └── restart_airflow.sh
│   ├── images/                # Assignment diagrams
│   ├── Dag_pics/              # Execution screenshots
│   ├── C2_W4_Assignment.md    # Assignment instructions
│   ├── START_HERE.md          # Quick start guide
│   ├── SOLUTION_GUIDE.md      # Detailed walkthrough
│   ├── QUICK_COMMANDS.md      # Command reference
│   ├── HANDOVER.md            # Project summary
│   ├── COURSERA_COMMANDS.sh   # Interactive deployment
│   └── README.md              # Week 4 overview
│
└── README.md                   # This file
```

---

## 🏆 Achievements

### Week 4 Accomplishments:
- ✅ Implemented production-grade Airflow pipeline
- ✅ Integrated Great Expectations for data quality
- ✅ Built conditional deployment logic
- ✅ Created reusable DAG templates
- ✅ Deployed to AWS EC2 with S3 integration
- ✅ Successfully ran 3 vendor-specific pipelines

---

## 📈 Progress Tracker

| Week | Topic                            | Status      | Completion |
|------|----------------------------------|-------------|------------|
| 1    | Database Connectivity            | 🚧 Started  | 0%         |
| 2    | Data Ingestion Patterns          | ⏳ Pending  | 0%         |
| 3    | Batch Processing                 | ⏳ Pending  | 0%         |
| 4    | Advanced Airflow Pipelines       | ✅ Complete | 100%       |

**Overall Module Progress: 25% (1/4 weeks)**

---

## 🚀 Quick Start

### For Week 4 (Completed):
```bash
cd module2/week4
cat START_HERE.md
```

### For Week 1 (In Progress):
```bash
cd module2/week1
cat SOLUTION_GUIDE.md
```

---

## 📝 Notes

- Week 4 uses GitHub as a bridge between local development and Coursera environment
- All DAGs tested and verified in production Airflow instance
- Great Expectations suite pre-configured for passenger_count validation
- Dynamic DAG generation supports unlimited vendors with minimal code changes

---

## 🔗 Related Resources

- [Apache Airflow Documentation](https://airflow.apache.org/docs/)
- [Great Expectations Docs](https://docs.greatexpectations.io/)
- [TaskFlow API Guide](https://airflow.apache.org/docs/apache-airflow/stable/tutorial/taskflow.html)
- [Jinja2 Templates](https://jinja.palletsprojects.com/)

---

**Last Updated**: December 13, 2025
