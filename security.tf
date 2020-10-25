variable "security_groups" {
  type        = list(string)
  description = "Additional security groups for the RDS"
  default     = []
}

variable "database_egress_cidr" {
  type    = list(string)
  default = ["0.0.0.0/0"]
}

variable "database_ingress_cidr" {
  type    = list(string)
  default = []
}

variable "database_ingress_sgs" {
  description = "A list of Security Group ID's to allow access to."
  type        = list(string)
  default     = []
}

locals {
  security_groups = sort(concat(
    list(aws_security_group.database.id),
    distinct(compact(var.security_groups))
  ))
}

resource "aws_security_group" "database" {
  name        = format("%s-sg", var.name)
  description = "Allow Database Access"
  vpc_id      = data.aws_vpc.main.id
  tags = merge(
    map(
      "Name", format("%s-sg", var.name)
    ),
    var.tags
  )
}

resource "aws_security_group_rule" "database_default_egress" {
  type              = "egress"
  from_port         = 0
  to_port           = 0
  protocol          = "-1"
  cidr_blocks       = var.database_egress_cidr
  security_group_id = aws_security_group.database.id
}

resource "aws_security_group_rule" "database_ingress_mysql_cidr" {
  count             = length(var.database_ingress_cidr) > 0 ? 1 : 0
  type              = "ingress"
  from_port         = 3306
  to_port           = 3306
  protocol          = "tcp"
  cidr_blocks       = var.database_ingress_cidr
  security_group_id = aws_security_group.database.id
}

resource "aws_security_group_rule" "database_ingress_mysql_sgs" {
  count                    = length(var.database_ingress_sgs) > 0 ? length(var.database_ingress_sgs) : 0
  type                     = "ingress"
  from_port                = 3306
  to_port                  = 3306
  protocol                 = "tcp"
  source_security_group_id = element(var.database_ingress_sgs, count.index)
  security_group_id        = aws_security_group.database.id
}
