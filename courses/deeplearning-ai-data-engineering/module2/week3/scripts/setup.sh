#!/bin/bash
# Setup script for C2_W3 Assignment
# This script outputs the MySQL connection string for Great Expectations
# In Coursera, this will be provided by the environment

set -e

export de_project="de-c2w3a1"
export AWS_DEFAULT_REGION="us-east-1"

# Get RDS endpoint
DB_HOST=$(aws rds describe-db-instances --db-instance-identifier ${de_project}-rds --output text --query "DBInstances[].Endpoint.Address" 2>/dev/null || echo "localhost")
DB_PORT=3306
DB_USER="admin"
# Course-provided lab credential
DB_PASSWORD="adminpwrd"
DB_NAME="taxi_trips"

# Output the connection string in the format expected by the notebook
echo "MYSQL_CONNECTION_STRING: mysql+pymysql://${DB_USER}:${DB_PASSWORD}@${DB_HOST}:${DB_PORT}/${DB_NAME}"
