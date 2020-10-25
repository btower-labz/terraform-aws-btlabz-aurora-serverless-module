variable "db_subnet_group_name" {
  description = "The existing subnet group name to use"
  type        = string
  #validation {
  #  condition     = length(var.db_subnet_group_name) > 0
  #  error_message = "The db_subnet_group_name should contain the name."
  #}
}

data "aws_db_subnet_group" "database" {
  name = var.db_subnet_group_name
}

locals {
  subnets = sort(distinct(compact(data.aws_db_subnet_group.database.subnet_ids)))
}

data "aws_subnet" "main" {
  count = length(local.subnets)
  id    = element(local.subnets, count.index)
}

# Get vpc by database subnet group
data "aws_vpc" "main" {
  id = data.aws_subnet.main[0].vpc_id
}
