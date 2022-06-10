variable "replication_instance_id" {
  description = "The replication instance identifier"
  type        = string
}

variable "preferred_maintenance_window" {
  description = "The weekly time range during which system maintenance can occur, in Universal Coordinated Time (UTC)"
  type        = string
}

variable "availability_zone" {
  description = "The EC2 Availability Zone that the replication instance will be created in"
  type        = string
}

variable "replication_subnet_group_id" {
  description = "The name for the replication subnet group. This value is stored as a lowercase string"
  type        = string
}

variable "vpc_id" {
  description = "VPC ID to create the cluster in (e.g. `vpc-a22222ee`)"
  type        = string
}

variable "subnet_ids" {
  description = "A list of the EC2 subnet IDs for the subnet group"
  type        = list(string)
}

variable "allowed_security_groups" {
  description = "List of existing Security Groups IDs to be allowed to connect to the replication Instance"
  type        = list(string)
  default     = []
}

variable "allowed_cidr_blocks" {
  description = "List of CIDR blocks to be allowed to connect to the replication Instance"
  type        = list(string)
  default     = []
}

variable "allocated_storage" {
  description = "The amount of storage (in gigabytes) to be initially allocated for the replication instance"
  type        = number
  default     = 50
}

variable "engine_version" {
  description = "The engine version number of the replication instance"
  type        = string
}

variable "replication_instance_class" {
  description = "The compute and memory capacity of the replication instance as specified by the replication instance class"
  type        = string
  default     = "dms.t3.micro"
}

variable "multi_az" {
  description = "Wether deploys a primary replication instance in one Availability Zone (AZ) and a standby in another AZ"
  type        = bool
  default     = false
}
