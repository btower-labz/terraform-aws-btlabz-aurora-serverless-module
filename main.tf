resource "aws_rds_cluster" "main" {
  cluster_identifier = var.name
  #engine                              = var.engine
  engine_mode = "serverless"
  #engine_version                      = var.engine_version
  #kms_key_id                          = var.kms_key_id
  database_name   = var.database_name
  master_username = var.username
  master_password = random_password.main.result

  #final_snapshot_identifier = "${var.final_snapshot_identifier_prefix}-${var.name}-${random_id.snapshot_identifier.hex}"
  #skip_final_snapshot       = var.skip_final_snapshot
  skip_final_snapshot = true

  deletion_protection          = var.deletion_protection
  backup_retention_period      = var.backup_retention_period
  preferred_backup_window      = var.preferred_backup_window
  preferred_maintenance_window = var.preferred_maintenance_window
  #port                                = local.port

  db_subnet_group_name   = var.db_subnet_group_name
  vpc_security_group_ids = local.security_groups

  snapshot_identifier = var.snapshot_identifier
  #storage_encrypted                   = var.storage_encrypted

  apply_immediately = var.apply_immediately
  #db_cluster_parameter_group_name     = var.db_cluster_parameter_group_name
  #iam_database_authentication_enabled = var.iam_database_authentication_enabled
  #backtrack_window                    = local.backtrack_window
  copy_tags_to_snapshot = var.copy_tags_to_snapshot
  #iam_roles                           = var.iam_roles

  # Enable Data API
  enable_http_endpoint = var.enable_http_endpoint

  #enabled_cloudwatch_logs_exports = var.enabled_cloudwatch_logs_exports
  tags = var.tags
}
