#!/bin/bash
set -e
export de_project="de-c1w4"
export AWS_DEFAULT_REGION="us-east-1"
export VPC_ID=$(aws rds describe-db-instances --db-instance-identifier $de_project"-rds" --output text --query "DBInstances[].DBSubnetGroup.VpcId")

# Define Terraform variables
echo "export TF_VAR_project=$de_project" >> $HOME/.bashrc
echo "export TF_VAR_region=$AWS_DEFAULT_REGION" >> $HOME/.bashrc
## Networking
echo "export TF_VAR_vpc_id=$VPC_ID" >> $HOME/.bashrc
echo "export TF_VAR_private_subnet_a_id=$(aws ec2 describe-subnets --filters "Name=tag:aws:cloudformation:logical-id,Values=PrivateSubnetA" "Name=vpc-id,Values=$VPC_ID" --output text --query "Subnets[].SubnetId")" >> $HOME/.bashrc
## Glue ETL
echo "export TF_VAR_db_sg_id=$(aws rds describe-db-instances --db-instance-identifier $de_project-rds --output text --query "DBInstances[].VpcSecurityGroups[].VpcSecurityGroupId")" >> $HOME/.bashrc
echo "export TF_VAR_source_host=$(aws rds describe-db-instances --db-instance-identifier $de_project-rds --output text --query "DBInstances[].Endpoint.Address")" >> $HOME/.bashrc
echo "export TF_VAR_source_port=3306" >> $HOME/.bashrc
echo "export TF_VAR_source_database="classicmodels"" >> $HOME/.bashrc
echo "export TF_VAR_source_username="admin"" >> $HOME/.bashrc
echo "export TF_VAR_source_password="adminpwrd"" >> $HOME/.bashrc
## Vector DB 
echo "export TF_VAR_public_subnet_a_id=$(aws ec2 describe-subnets --filters "Name=tag:aws:cloudformation:logical-id,Values=PublicSubnetA" "Name=vpc-id,Values=$VPC_ID" --output text --query "Subnets[].SubnetId")" >> $HOME/.bashrc
echo "export TF_VAR_public_subnet_b_id=$(aws ec2 describe-subnets --filters "Name=tag:aws:cloudformation:logical-id,Values=PublicSubnetB" "Name=vpc-id,Values=$VPC_ID" --output text --query "Subnets[].SubnetId")" >> $HOME/.bashrc
# Streaming inference
echo "export TF_VAR_kinesis_stream_arn=$(aws kinesis describe-stream --stream-name $de_project-kinesis-data-stream --output text --query "StreamDescription.StreamARN")" >> $HOME/.bashrc
echo "export TF_VAR_inference_api_url=$(aws lambda get-function-url-config --function-name $de_project-model-inference --output text --query "FunctionUrl")" >> $HOME/.bashrc
#S3 Buckets
echo "export TF_VAR_data_lake_bucket=$de_project-$(aws sts get-caller-identity --query 'Account' --output text)-$AWS_DEFAULT_REGION-datalake"  >> $HOME/.bashrc
echo "export TF_VAR_scripts_bucket=$de_project-$(aws sts get-caller-identity --query 'Account' --output text)-$AWS_DEFAULT_REGION-scripts"  >> $HOME/.bashrc
echo "export TF_VAR_recommendations_bucket=$de_project-$(aws sts get-caller-identity --query 'Account' --output text)-$AWS_DEFAULT_REGION-recommendations"  >> $HOME/.bashrc
echo "Terraform variables have been set"

source $HOME/.bashrc

#Copy glue job script
aws s3 cp ./terraform/assets/glue_job/de-c1w4-etl-job.py s3://$TF_VAR_scripts_bucket/de-c1w4-etl-job.py
echo "Glue script has been set in the bucket"

# Replace the filename in the backend.tf file
script_dir=$(dirname "$(readlink -f "${BASH_SOURCE[0]}")")
sed -i "s/<terraform_state_file>/$TF_VAR_project-$(aws sts get-caller-identity --query 'Account' --output text)-us-east-1-terraform-state/g" "$script_dir/../terraform/backend.tf"

echo "Setup completed successfully. All environment variables and Terraform backend configurations have been set."