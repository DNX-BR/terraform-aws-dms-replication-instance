output "arn" {
  value       = try(aws_dms_replication_instance.default.replication_instance_arn, "")
  description = "Amazon Resource Name (ARN) of the DMS Replication Instance"
}

output "private_ips" {
  value       = try(aws_dms_replication_instance.default.replication_instance_private_ips, "")
  description = "List of the private IP addresses of the DMS Replication Instance"
}

output "public_ips" {
  value       = try(aws_dms_replication_instance.default.replication_instance_public_ips, "")
  description = "List of the public IP addresses of the replication instance"
}
