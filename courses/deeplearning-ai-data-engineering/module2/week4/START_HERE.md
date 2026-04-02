# 🚀 START HERE - C2W4 Assignment Guide

## 📌 Quick Overview

**Assignment:** Building an Advanced Data Pipeline With Data Quality Checks  
**Course:** DeepLearning.AI Data Engineering Certificate - Course 2, Week 4  
**Status:** ✅ **ALL CODE COMPLETE** - Ready to deploy!  
**Repository:** https://github.com/anix-lynch/dlai-c2w4-airflow-pipeline

---

## 🎯 What This Project Does

Builds an Apache Airflow ML pipeline that:
1. ✅ Validates ride-sharing data using Great Expectations
2. ✅ Trains linear regression models to predict trip duration
3. ✅ Evaluates model performance (RMSE metric)
4. ✅ Automatically deploys models if RMSE < 500
5. ✅ Generates dynamic DAGs for 3 vendors (Easy Destiny, Alitran, ToMyPlaceAI)

---

## 🏃 Quick Start (3 Options)

### Option 1: Interactive Script (EASIEST)
```bash
# In Coursera terminal:
cd ~
git clone https://github.com/anix-lynch/dlai-c2w4-airflow-pipeline.git
cd dlai-c2w4-airflow-pipeline
bash COURSERA_COMMANDS.sh
```
The script will guide you step-by-step!

### Option 2: Manual Commands
Follow **QUICK_COMMANDS.md** for copy-paste commands

### Option 3: Detailed Walkthrough
Read **SOLUTION_GUIDE.md** for full explanations

---

## 📚 Documentation Map

| File | Purpose | When to Use |
|------|---------|-------------|
| **START_HERE.md** | This file - quick orientation | First time setup |
| **QUICK_COMMANDS.md** | Copy-paste command reference | When you need commands fast |
| **SOLUTION_GUIDE.md** | Complete walkthrough with explanations | When you want to understand |
| **HANDOVER.md** | Summary + troubleshooting | When things break |
| **COURSERA_COMMANDS.sh** | Interactive deployment script | Automated deployment |
| **C2_W4_Assignment.md** | Original assignment | Reference only |

---

## 🔑 What You Need Before Starting

### From AWS Console (CloudFormation → Outputs):
- [ ] `RawDataBucket` name (e.g., de-c2w4a1-123456-raw-data)
- [ ] `DAGsBucket` name (e.g., de-c2w4a1-123456-dags)
- [ ] `AirflowDNS` URL (e.g., http://ec2-xxx.compute.amazonaws.com:8080)

### Get it with:
```bash
cat ../.aws/aws_console_url
```

---

## ⚡ The 6-Step Process

```
1. 🔍 GET AWS INFO          → CloudFormation outputs
2. 📦 CLONE REPO            → git clone in Coursera
3. 📤 UPLOAD DATA TO S3     → aws s3 sync
4. ⚙️  SET AIRFLOW VARIABLE  → Admin → Variables
5. 🚀 UPLOAD DAGS TO S3     → aws s3 cp
6. ▶️  RUN IN AIRFLOW UI     → Toggle ON → Trigger
```

**Time Required:** ~10-15 minutes

---

## 📂 Project Structure

```
dlai-c2w4-airflow-pipeline/
│
├── 📖 START_HERE.md              ← You are here
├── 📋 QUICK_COMMANDS.md          ← Copy-paste commands
├── 📚 SOLUTION_GUIDE.md          ← Detailed walkthrough
├── 🎯 HANDOVER.md                ← Summary + troubleshooting
├── 🤖 COURSERA_COMMANDS.sh       ← Interactive script
│
├── src/
│   ├── model_trip_duration_easy_destiny.py  ✅ COMPLETE
│   │
│   ├── dags/                     ← Upload these to S3
│   │   ├── model_trip_duration_easy_destiny.py
│   │   ├── model_trip_duration_alitran.py
│   │   └── model_trip_duration_to_my_place_ai.py
│   │
│   └── templates/
│       ├── template.py           ← Jinja2 template
│       ├── generate_dags.py      ← DAG generator
│       └── dag_configs/          ← JSON configs
│
├── data/                         ← Upload to S3
│   └── work_zone/...
│
├── scripts/
│   └── restart_airflow.sh        ← If Airflow breaks
│
└── images/                       ← Reference diagrams
```

---

## ✅ Completed Exercises

All 5 exercises are **100% complete**:

### ✅ Exercise 1: Data Quality Checks
- Implemented `GreatExpectationsOperator`
- Validates passenger_count ≤ 6
- Fails task if validation fails

### ✅ Exercise 2: ML Model Training
- Reads parquet data from S3
- Trains linear regression model
- Calculates RMSE performance
- Returns metrics via XCom

### ✅ Exercise 3: Branching Logic
- `BranchPythonOperator` implementation
- Deploys if RMSE < 500
- Notifies if performance is low

### ✅ Exercise 4: DAG Dependencies
- All tasks connected correctly
- Uses Airflow template variables
- Proper trigger rules

### ✅ Exercise 5: Dynamic DAGs
- Jinja2 template created
- 3 config files generated
- All 3 DAGs working

---

## 🎓 Technologies Used

- **Apache Airflow** - Workflow orchestration
- **Great Expectations** - Data quality validation
- **Pandas** - Data manipulation
- **SciPy** - Linear regression (linregress)
- **AWS S3** - Data storage
- **AWS EC2** - Airflow hosting
- **Jinja2** - Template engine
- **Python** - Programming language

---

## 🚨 Common Issues & Quick Fixes

| Problem | Solution |
|---------|----------|
| DAGs not showing | Wait 2 min, refresh Airflow UI |
| Data not found | Check `bucket_name` variable in Airflow |
| Import errors | Verify Great Expectations installed |
| Airflow broken | Run `restart_airflow.sh` in CloudShell |
| Permission denied | Check IAM roles in CloudFormation |

**Full troubleshooting guide:** See HANDOVER.md

---

## 💡 Pro Tips

1. ⏱️ **Airflow takes 2 minutes** to scan for new DAGs - be patient!
2. 🔍 **Check logs** in Airflow UI for detailed error messages
3. 📊 **Use Graph view** to visualize DAG execution
4. 🔄 **XCom tab** shows data passed between tasks
5. 🧪 **Test locally** with `python3 <dag_file>.py` before uploading

---

## 🎯 Success Criteria

You'll know it's working when:

✅ All 3 DAGs appear in Airflow UI  
✅ Each DAG has 7 tasks in graph view  
✅ Data quality checks pass (green)  
✅ Models train successfully  
✅ RMSE calculated and logged  
✅ Correct branch taken (deploy/notify)  
✅ End task completes  

---

## 📞 Need Help?

**Quick questions?** → Check QUICK_COMMANDS.md  
**Want details?** → Read SOLUTION_GUIDE.md  
**Something broken?** → See HANDOVER.md  
**First time?** → Run COURSERA_COMMANDS.sh

---

## 🔐 Security Notes

- ✅ No credentials in GitHub
- ✅ No AWS keys in code
- ✅ Token removed from git remote
- ✅ Data files excluded via .gitignore
- ✅ Sensitive files protected

---

## 🎉 Ready to Start?

### Recommended Path:

1. **Read this file** (you're here!) ✅
2. **Get your bucket names** from CloudFormation
3. **Run the script**: `bash COURSERA_COMMANDS.sh`
4. **Follow prompts** - it guides you through everything
5. **Open Airflow UI** and watch your DAGs run!

### Alternative Path (Manual):

1. Read **QUICK_COMMANDS.md**
2. Copy-paste commands one by one
3. Verify each step completes

---

## 📈 Learning Outcomes

By completing this, you'll master:

- ✅ Apache Airflow DAG creation
- ✅ TaskFlow API with decorators
- ✅ Data quality validation with Great Expectations
- ✅ ML pipeline orchestration
- ✅ Branching and conditional workflows
- ✅ XCom for task communication
- ✅ Dynamic DAG generation with Jinja2
- ✅ AWS S3 and EC2 integration
- ✅ DRY principle in data engineering

---

## 🚀 Let's Go!

**Everything is ready. The code is complete. Time to deploy!**

Choose your path:
- 🤖 **Automated:** `bash COURSERA_COMMANDS.sh`
- 📋 **Manual:** Follow QUICK_COMMANDS.md
- 📚 **Learn:** Read SOLUTION_GUIDE.md

**Repository:** https://github.com/anix-lynch/dlai-c2w4-airflow-pipeline

**Good luck! You've got this! 🎓🚀**

---

*Last Updated: December 2025*  
*Status: ✅ Production Ready*

