resource "aws_security_group" "default" {
  name        = "${var.replication_instance_id}-sg"
  description = "Security Group for DMS ${var.replication_instance_id}"
  vpc_id      = var.vpc_id

  tags = {
    "Name"       = "${var.replication_instance_id}-sg"
    "Managed by" = "Terraform"
  }
}

resource "aws_security_group_rule" "egress" {
  type              = "egress"
  description       = "Allow all egress traffic"
  from_port         = 0
  to_port           = 0
  protocol          = "-1"
  cidr_blocks       = ["0.0.0.0/0"]
  security_group_id = aws_security_group.default.id
}

resource "aws_security_group_rule" "ingress_security_groups" {
  count                    = length(var.allowed_security_groups)
  type                     = "ingress"
  description              = "Allow inbound traffic from existing Security Groups"
  from_port                = 0
  to_port                  = 0
  protocol                 = "tcp"
  source_security_group_id = var.allowed_security_groups[count.index]
  security_group_id        = aws_security_group.default.id
}

resource "aws_security_group_rule" "ingress_cidr_blocks" {
  type              = "ingress"
  description       = "Allow inbound traffic from CIDR blocks"
  from_port         = 0
  to_port           = 0
  protocol          = "tcp"
  cidr_blocks       = var.allowed_cidr_blocks
  security_group_id = aws_security_group.default.id
}
