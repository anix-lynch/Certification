module "extract_job" {
  source = "./modules/extract_job"

  project             = var.project
  region              = var.region
  public_subnet_a_id  = var.public_subnet_a_id
  db_sg_id            = var.db_sg_id
  host                = var.source_host
  port                = var.source_port
  database            = var.source_database
  username            = var.source_username
  password            = var.source_password
  data_lake_bucket    = var.data_lake_bucket
  scripts_bucket      = var.scripts_bucket
}

module "transform_job" {
  source = "./modules/transform_job"

  project = var.project
  region  = var.region
  glue_role_arn       = module.extract_job.glue_role_arn
  scripts_bucket      = var.scripts_bucket
  catalog_database    = var.catalog_database
  data_lake_bucket    = var.data_lake_bucket
  users_table         = var.users_table
  sessions_table      = var.sessions_table
  songs_table         = var.songs_table

  depends_on = [module.extract_job]
}

module "serving" {
  source = "./modules/serving"

  providers = {
    redshift = redshift.default
  }

  project            = var.project
  region             = var.region
  redshift_role_name = var.redshift_role_name
  catalog_database  = var.catalog_database
  redshift_host     = var.redshift_host
  redshift_user     = var.redshift_user
  redshift_password = var.redshift_password
  redshift_database = var.redshift_database
  redshift_port     = var.redshift_port
}
