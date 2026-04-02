variable "project" {
  type        = string
  description = "Project name"
}

variable "region" {
  type        = string
  description = "AWS Region"
}

variable "public_subnet_a_id" {
  type        = string
  description = "Public subnet A ID"
}

variable "db_sg_id" {
  type        = string
  description = "Security group ID for RDS"
}

variable "host" {
  type        = string
  description = "RDS host"
}

variable "port" {
  type        = number
  description = "RDS port"
  default     = 3306
}

variable "database" {
  type        = string
  description = "RDS database name"
}

variable "username" {
  type        = string
  description = "RDS username"
}

variable "password" {
  type        = string
  description = "RDS password"
  sensitive   = true
}

variable "data_lake_bucket" {
  type        = string
  description = "S3 Bucket for Data lake"
}

variable "scripts_bucket" {
  type        = string
  description = "S3 Bucket for Glue scripts"
}

variable "scripts_key" {
  type        = string
  default     = "de-c1w4-etl-job.py"
  description = "S3 Key for Glue script"
}
