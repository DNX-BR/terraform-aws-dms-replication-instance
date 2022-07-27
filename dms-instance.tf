# Create a new DMS replication instance
resource "aws_dms_replication_instance" "default" {
  allocated_storage            = var.allocated_storage
  apply_immediately            = var.apply_immediately
  allow_major_version_upgrade  = var.allow_major_version_upgrade
  auto_minor_version_upgrade   = var.auto_minor_version_upgrade
  availability_zone            = var.availability_zone
  engine_version               = var.engine_version
  multi_az                     = var.multi_az
  preferred_maintenance_window = var.preferred_maintenance_window
  publicly_accessible          = var.publicly_accessible
  replication_instance_class   = var.replication_instance_class
  replication_instance_id      = var.replication_instance_id 
  replication_subnet_group_id  = var.replication_subnet_group_id
  vpc_security_group_ids       = [join("", aws_security_group.default.*.id)]

  tags = {
    "Name"       = var.replication_instance_id
    "Managed by" = "Terraform"
  }
}

# Create a subnet group using existing VPC subnets
resource "aws_dms_replication_subnet_group" "dms" {
  replication_subnet_group_description = "DMS replication subnet group"
  replication_subnet_group_id          = var.replication_subnet_group_id
  subnet_ids                           = var.subnet_ids

  tags = {
    "Name"       = var.replication_subnet_group_id
    "Managed by" = "Terraform"
  }
}
