#!/bin/bash
set -e
export de_project="de-c4w4a1"
export de_project_underscore=$(echo "$de_project" | sed 's/-/_/g')
export AWS_DEFAULT_REGION="us-east-1"
export VPC_ID=$(aws rds describe-db-instances --db-instance-identifier $de_project-rds --output text --query "DBInstances[].DBSubnetGroup.VpcId")

# Define Terraform variables
echo "export TF_VAR_project=$de_project" >> $HOME/.bashrc
echo "export TF_VAR_region=$AWS_DEFAULT_REGION" >> $HOME/.bashrc
echo "export TF_VAR_vpc_id=$VPC_ID" >> $HOME/.bashrc
echo "export TF_VAR_public_subnet_a_id=$(aws ec2 describe-subnets --filters "Name=tag:aws:cloudformation:logical-id,Values=PublicSubnetA" "Name=vpc-id,Values=$VPC_ID" --output text --query "Subnets[].SubnetId")" >> $HOME/.bashrc
echo "export TF_VAR_db_sg_id=$(aws rds describe-db-instances --db-instance-identifier $de_project-rds --output text --query "DBInstances[].VpcSecurityGroups[].VpcSecurityGroupId")" >> $HOME/.bashrc
echo "export TF_VAR_source_host=$(aws rds describe-db-instances --db-instance-identifier $de_project-rds --output text --query "DBInstances[].Endpoint.Address")" >> $HOME/.bashrc
echo "export TF_VAR_source_port=5432" >> $HOME/.bashrc
echo "export TF_VAR_source_database="postgres"" >> $HOME/.bashrc
echo "export TF_VAR_source_username="postgresuser"" >> $HOME/.bashrc
echo "export TF_VAR_source_password="adminpwrd"" >> $HOME/.bashrc
echo "export TF_VAR_data_lake_bucket=$(aws s3api list-buckets --query 'Buckets[?starts_with(Name, `'"$de_project"'`) && ends_with(Name, `data-lake`)].Name' --output text)" >> $HOME/.bashrc
echo "export TF_VAR_catalog_database="${de_project_underscore}_silver_db"" >> $HOME/.bashrc
echo "export TF_VAR_users_table="users"" >> $HOME/.bashrc
echo "export TF_VAR_sessions_table="sessions"" >> $HOME/.bashrc
echo "export TF_VAR_songs_table="songs"" >> $HOME/.bashrc
echo "export TF_VAR_redshift_role_name="$de_project-load-role"" >> $HOME/.bashrc
echo "export TF_VAR_redshift_host=$(aws redshift describe-clusters --cluster-identifier $de_project-redshift-cluster --query "Clusters[0].Endpoint.Address" --output text)" >> $HOME/.bashrc
echo "export TF_VAR_redshift_user="defaultuser"" >> $HOME/.bashrc
echo "export TF_VAR_redshift_password="Defaultuserpwrd1234+"" >> $HOME/.bashrc
echo "export TF_VAR_redshift_database="dev"" >> $HOME/.bashrc
echo "export TF_VAR_redshift_port=5439" >> $HOME/.bashrc
echo "export TF_VAR_scripts_bucket=$de_project-$(aws sts get-caller-identity --query 'Account' --output text)-$AWS_DEFAULT_REGION-scripts"  >> $HOME/.bashrc

source $HOME/.bashrc

# Replace the file name in the backend.tf file
script_dir=$(dirname "$(readlink -f "${BASH_SOURCE[0]}")")
sed -i "s/<terraform_state_file>/$TF_VAR_project-$(aws sts get-caller-identity --query 'Account' --output text)-us-east-1-terraform-state/g" "$script_dir/../terraform/backend.tf"

# Final success message
echo "Setup completed successfully. All environment variables and Terraform backend configurations have been set."