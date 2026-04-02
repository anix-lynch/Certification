#!/bin/bash
set -e
export de_project="de-c1w2"
export AWS_DEFAULT_REGION="us-east-1"
export VPC_ID=$(aws rds describe-db-instances --db-instance-identifier $de_project-rds --output text --query "DBInstances[].DBSubnetGroup.VpcId")

# Define Terraform variables
echo "export TF_VAR_project=$de_project" >> $HOME/.bashrc
echo "export TF_VAR_region=$AWS_DEFAULT_REGION" >> $HOME/.bashrc
echo "export TF_VAR_vpc_id=$VPC_ID" >> $HOME/.bashrc
echo "export TF_VAR_public_subnet_a_id=$(aws ec2 describe-subnets --filters "Name=tag:aws:cloudformation:logical-id,Values=PublicSubnetA" "Name=vpc-id,Values=$VPC_ID" --output text --query "Subnets[].SubnetId")" >> $HOME/.bashrc
echo "export TF_VAR_db_sg_id=$(aws rds describe-db-instances --db-instance-identifier de-c1w2-rds --output text --query "DBInstances[].VpcSecurityGroups[].VpcSecurityGroupId")" >> $HOME/.bashrc
echo "export TF_VAR_host=$(aws rds describe-db-instances --db-instance-identifier de-c1w2-rds --output text --query "DBInstances[].Endpoint.Address")" >> $HOME/.bashrc
echo "export TF_VAR_port=3306" >> $HOME/.bashrc
echo "export TF_VAR_database="classicmodels"" >> $HOME/.bashrc
echo "export TF_VAR_username="admin"" >> $HOME/.bashrc
# Course-provided lab credential (not a real password)
echo "export TF_VAR_password="adminpwrd"" >> $HOME/.bashrc
echo "export TF_VAR_data_lake_bucket=$de_project-$(aws sts get-caller-identity --query 'Account' --output text)-$AWS_DEFAULT_REGION-datalake"  >> $HOME/.bashrc
echo "export TF_VAR_scripts_bucket=$de_project-$(aws sts get-caller-identity --query 'Account' --output text)-$AWS_DEFAULT_REGION-scripts"  >> $HOME/.bashrc

source $HOME/.bashrc

#Copy glue job script
aws s3 cp ./terraform/assets/glue_job.py s3://$TF_VAR_scripts_bucket/glue_job.py
echo "Glue script has been set in the bucket"

# Replace the bucket name in the backend.tf file
script_dir=$(dirname "$(readlink -f "${BASH_SOURCE[0]}")")
sed -i "s/<terraform_state_file>/$TF_VAR_project-$(aws sts get-caller-identity --query 'Account' --output text)-us-east-1-terraform-state/g" "$script_dir/../terraform/backend.tf"


echo "Defined Terraform variables"