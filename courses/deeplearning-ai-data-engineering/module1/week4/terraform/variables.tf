variable "project" {
  type        = string
  description = "Project name"
}

variable "region" {
  type        = string
  description = "AWS Region"
}

variable "vpc_id" {
  type        = string
  description = "VPC ID"
}

variable "db_sg_id" {
  type        = string
  description = "Security group ID for RDS"
}

variable "source_host" {
  type        = string
  description = "RDS host"
}

variable "source_port" {
  type        = number
  description = "RDS port"
  default     = 3306
}

variable "source_database" {
  type        = string
  description = "RDS database name"
  default     = "classicmodels"
}

variable "source_username" {
  type        = string
  description = "RDS username"

}

variable "source_password" {
  type        = string
  description = "RDS password"
  sensitive   = true
  default     = "" #LEARNERS MUST FILL THIS 

}

variable "public_subnet_a_id" {
  type        = string
  description = "Public subnet A ID"
}

variable "public_subnet_b_id" {
  type        = string
  description = "Public subnet B ID"
}

variable "kinesis_stream_arn" {
  type        = string
  description = "Source Kinesis data stream arn"
  default     = "" #LEARNERS MUST FILL THIS
}

variable "inference_api_url" {
  type        = string
  description = "URL of the API to use for inference"
  default     = "" #LEARNERS MUST FILL THIS

}

variable "data_lake_bucket" {
  type        = string
  description = "S3 Bucket for Data lake"
}

variable "scripts_bucket" {
  type        = string
  description = "S3 Bucket for Glue scripts"
}

variable "recommendations_bucket" {
  type        = string
  description = "S3 Bucket for Recommendations results"
}
