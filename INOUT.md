# Terraform inputs and outputs.

## Requirements

| Name | Version |
|------|---------|
| terraform | >= 0.12.0 |

## Providers

| Name | Version |
|------|---------|
| aws | n/a |
| random | n/a |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| apply\_immediately | Determines whether or not any DB modifications are applied immediately, or during the maintenance window | `bool` | `false` | no |
| auto\_minor\_version\_upgrade | Determines whether minor engine upgrades will be performed automatically in the maintenance window | `bool` | `true` | no |
| backup\_retention\_period | How long to keep backups for (in days) | `number` | `7` | no |
| config\_path | Configuration path for SSM and Secrets | `string` | `"/dev"` | no |
| copy\_tags\_to\_snapshot | Copy all Cluster tags to snapshots. | `bool` | `true` | no |
| database\_egress\_cidr | n/a | `list(string)` | <pre>[<br>  "0.0.0.0/0"<br>]</pre> | no |
| database\_ingress\_cidr | n/a | `list(string)` | `[]` | no |
| database\_ingress\_sgs | A list of Security Group ID's to allow access to. | `list(string)` | `[]` | no |
| database\_name | Name for an automatically created database on cluster creation | `string` | n/a | yes |
| db\_subnet\_group\_name | The existing subnet group name to use | `string` | n/a | yes |
| deletion\_protection | If the DB instance should have deletion protection enabled | `bool` | `false` | no |
| enable\_http\_endpoint | Enable HTTP endpoint (data API). | `bool` | `true` | no |
| final\_snapshot\_identifier\_prefix | The prefix name to use when creating a final snapshot on cluster destroy, appends a random 8 digits to name to ensure it's unique too. | `string` | `"final"` | no |
| name | Name given resources | `string` | n/a | yes |
| password | Master DB password | `string` | `""` | no |
| preferred\_backup\_window | When to perform DB backups | `string` | `"02:00-03:00"` | no |
| preferred\_maintenance\_window | When to perform DB maintenance | `string` | `"sun:05:00-sun:06:00"` | no |
| security\_groups | Additional security groups for the RDS | `list(string)` | `[]` | no |
| skip\_final\_snapshot | Should a final snapshot be created on cluster destroy | `bool` | `false` | no |
| snapshot\_identifier | DB snapshot to create this database from | `string` | `null` | no |
| tags | A map of tags to add to all resources. | `map(string)` | `{}` | no |
| username | Master DB username | `string` | `"admin"` | no |

## Outputs

| Name | Description |
|------|-------------|
| password | Initial RDS password. It must be changed. |
| rds\_cluster\_arn | Amazon Resource Name (ARN) of cluster |
| rds\_cluster\_id | The RDS Cluster Identifier |
| rds\_database\_name | The database port |
| rds\_endpoint | The DNS address of the RDS instance |
| rds\_hosted\_zone\_id | The Route53 Hosted Zone ID of the endpoint |
| rds\_port | The database port |
| rds\_reader\_endpoint | A read-only endpoint for the Aurora cluster, automatically load-balanced across replicas |
| rds\_secret\_arn | RDS secret ARN. |
| rds\_secret\_name | RDS secret name. |
| username | Initial RDS username. |

