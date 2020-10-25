output "rds_cluster_arn" {
  description = "Amazon Resource Name (ARN) of cluster"
  value       = aws_rds_cluster.main.arn
}

output "rds_cluster_id" {
  description = "The RDS Cluster Identifier"
  value       = aws_rds_cluster.main.id
}

output "rds_hosted_zone_id" {
  description = "The Route53 Hosted Zone ID of the endpoint"
  value       = aws_rds_cluster.main.hosted_zone_id
}

output "rds_endpoint" {
  description = "The DNS address of the RDS instance"
  value       = aws_rds_cluster.main.endpoint
}

output "rds_reader_endpoint" {
  description = "A read-only endpoint for the Aurora cluster, automatically load-balanced across replicas"
  value       = aws_rds_cluster.main.reader_endpoint
}

output "rds_port" {
  description = "The database port"
  value       = aws_rds_cluster.main.port
}

output "rds_database_name" {
  description = "The database port"
  value       = aws_rds_cluster.main.database_name
}
