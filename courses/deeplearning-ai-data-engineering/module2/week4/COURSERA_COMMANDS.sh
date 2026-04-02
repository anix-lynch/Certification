#!/bin/bash
# ═══════════════════════════════════════════════════════════════════
# C2W4 Assignment - Coursera Terminal Commands
# Copy-paste these commands into the Coursera terminal
# ═══════════════════════════════════════════════════════════════════

echo "════════════════════════════════════════════════════════════════"
echo "  C2W4 Assignment - Deployment Script"
echo "════════════════════════════════════════════════════════════════"
echo ""

# ═══════════════════════════════════════════════════════════════════
# STEP 1: Get AWS Console URL
# ═══════════════════════════════════════════════════════════════════
echo "📍 STEP 1: Getting AWS Console URL..."
echo "Run this command, then open the URL in browser:"
echo ""
echo "    cat ../.aws/aws_console_url"
echo ""
echo "Then go to CloudFormation → Outputs and note:"
echo "  - RawDataBucket (e.g., de-c2w4a1-123456-raw-data)"
echo "  - DAGsBucket (e.g., de-c2w4a1-123456-dags)"
echo "  - AirflowDNS (e.g., http://ec2-xxx.amazonaws.com:8080)"
echo ""
read -p "Press Enter after you've noted the bucket names..."

# ═══════════════════════════════════════════════════════════════════
# STEP 2: Set Bucket Names
# ═══════════════════════════════════════════════════════════════════
echo ""
echo "════════════════════════════════════════════════════════════════"
echo "📝 STEP 2: Enter your bucket names"
echo "════════════════════════════════════════════════════════════════"
echo ""
read -p "Enter RAW DATA BUCKET name: " RAW_BUCKET
read -p "Enter DAGS BUCKET name: " DAGS_BUCKET

echo ""
echo "✓ Using:"
echo "  - Raw Data: $RAW_BUCKET"
echo "  - DAGs: $DAGS_BUCKET"
echo ""

# ═══════════════════════════════════════════════════════════════════
# STEP 3: Clone Repository
# ═══════════════════════════════════════════════════════════════════
echo "════════════════════════════════════════════════════════════════"
echo "📦 STEP 3: Cloning repository..."
echo "════════════════════════════════════════════════════════════════"
cd ~
git clone https://github.com/anix-lynch/dlai-c2w4-airflow-pipeline.git
cd dlai-c2w4-airflow-pipeline
echo "✓ Repository cloned!"
echo ""

# ═══════════════════════════════════════════════════════════════════
# STEP 4: Upload Data to S3
# ═══════════════════════════════════════════════════════════════════
echo "════════════════════════════════════════════════════════════════"
echo "📤 STEP 4: Uploading data to S3..."
echo "════════════════════════════════════════════════════════════════"
cd data
aws s3 sync work_zone s3://$RAW_BUCKET/work_zone/
cd ..
echo "✓ Data uploaded!"
echo ""

# Verify
echo "Verifying data upload..."
aws s3 ls s3://$RAW_BUCKET/work_zone/ --recursive
echo ""

# ═══════════════════════════════════════════════════════════════════
# STEP 5: Upload DAGs to S3
# ═══════════════════════════════════════════════════════════════════
echo "════════════════════════════════════════════════════════════════"
echo "🚀 STEP 5: Uploading DAGs to S3..."
echo "════════════════════════════════════════════════════════════════"
cd src/dags
aws s3 sync . s3://$DAGS_BUCKET/dags/
echo "✓ DAGs uploaded!"
echo ""

# Verify
echo "Verifying DAG upload..."
aws s3 ls s3://$DAGS_BUCKET/dags/
echo ""

# ═══════════════════════════════════════════════════════════════════
# STEP 6: Instructions for Airflow UI
# ═══════════════════════════════════════════════════════════════════
echo "════════════════════════════════════════════════════════════════"
echo "🎯 STEP 6: Configure Airflow (MANUAL STEPS)"
echo "════════════════════════════════════════════════════════════════"
echo ""
echo "1. Open Airflow UI in browser (use AirflowDNS from CloudFormation)"
echo "   Login: airflow / airflow"
echo ""
echo "2. Add Variable:"
echo "   → Admin → Variables → + (Add)"
echo "   → Key: bucket_name"
echo "   → Val: $RAW_BUCKET"
echo "   → Save"
echo ""
echo "3. Wait 2 minutes for DAGs to appear"
echo ""
echo "4. Refresh browser and verify you see 3 DAGs:"
echo "   - model_trip_duration_easy_destiny"
echo "   - model_trip_duration_alitran"
echo "   - model_trip_duration_to_my_place_ai"
echo ""
echo "5. Toggle each DAG ON (switch button)"
echo ""
echo "6. Click on a DAG → Trigger DAG (▶️ button)"
echo ""
echo "7. Watch the execution in Graph view!"
echo ""

echo "════════════════════════════════════════════════════════════════"
echo "✅ DEPLOYMENT COMPLETE!"
echo "════════════════════════════════════════════════════════════════"
echo ""
echo "🎉 All code has been uploaded!"
echo ""
echo "📚 Need help? Check these files:"
echo "   - SOLUTION_GUIDE.md (detailed walkthrough)"
echo "   - QUICK_COMMANDS.md (command reference)"
echo "   - HANDOVER.md (troubleshooting)"
echo ""
echo "Good luck! 🚀"
echo ""

