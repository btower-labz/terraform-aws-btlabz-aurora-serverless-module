# TODO
variable "username" {
  description = "Master DB username"
  type        = string
  default     = "admin"
}

# TODO
variable "password" {
  description = "Master DB password"
  type        = string
  default     = ""
}

resource "random_password" "main" {
  length           = 16
  upper            = true
  min_upper        = 1
  lower            = true
  min_lower        = 1
  number           = true
  min_numeric      = 1
  special          = true
  override_special = ".-!?"
  min_special      = 1
}

resource "aws_secretsmanager_secret" "main" {
  name_prefix             = format("%s/%s-", var.config_path, var.name)
  description             = var.name
  recovery_window_in_days = 0
  tags                    = var.tags
}

locals {
  secret = {
    dbInstanceIdentifier = aws_rds_cluster.main.id
    engine               = aws_rds_cluster.main.engine
    host                 = aws_rds_cluster.main.endpoint
    port                 = aws_rds_cluster.main.port
    resourceId           = aws_rds_cluster.main.cluster_resource_id
    username             = "admin"
    password             = random_password.main.result
    database             = aws_rds_cluster.main.database_name
  }
}

resource "aws_secretsmanager_secret_version" "main" {
  secret_id     = aws_secretsmanager_secret.main.id
  secret_string = jsonencode(local.secret)
}

#aws_secretsmanager_secret_rotation "main" {
#  secret_id           = aws_secretsmanager_secret.main.id
#  rotation_rules {
#    automatically_after_days = 10
#  }
#}

output "rds_secret_arn" {
  description = "RDS secret ARN."
  value       = aws_secretsmanager_secret.main.arn
}

output "rds_secret_name" {
  description = "RDS secret name."
  value       = aws_secretsmanager_secret.main.name
}

output "username" {
  description = "Initial RDS username."
  value       = jsondecode(aws_secretsmanager_secret_version.main.secret_string)["username"]
  sensitive   = true
}

output "password" {
  description = "Initial RDS password. It must be changed."
  value       = jsondecode(aws_secretsmanager_secret_version.main.secret_string)["password"]
  sensitive   = true
}
