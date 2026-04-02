output "glue_role_arn" {
  value = aws_iam_role.glue_role.arn
}

output "glue_rds_extract_job" {
  value = aws_glue_job.rds_ingestion_etl_job.name
}

output "glue_api_users_extract_job" {
  value = aws_glue_job.api_users_ingestion_etl_job.name
}

output "glue_sessions_users_extract_job" {
  value = aws_glue_job.api_sessions_ingestion_etl_job.name
}

