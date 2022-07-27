# terraform-aws-dms

[![Lint Status](https://github.com/DNXLabs/terraform-aws-rds/workflows/Lint/badge.svg)](https://github.com/DNXLabs/terraform-aws-rds/actions)
[![LICENSE](https://img.shields.io/github/license/DNXLabs/terraform-aws-rds)](https://github.com/DNXLabs/terraform-aws-rds/blob/master/LICENSE)

## Usage

```hcl
module "dms_replication_instance" {
  for_each                     = { for replication in local.workspace.dms_replication.replications : replication.database_name => replication if local.enabled && replication.instance.new_instance }
  source                       = "git::https://github.com/DNX-BR/terraform-aws-dms-replication-instance?ref=0.0.2"

  replication_instance_id      = "dms-sync-${each.value.instance.instance_id}-instance"
  replication_subnet_group_id  = "dms-sync-${each.value.instance.instance_id}-subnet-group"
  allocated_storage            = try(each.value.instance.allocated_storage, 50)
  availability_zone            = try(each.value.instance.availability_zone, null)
  engine_version               = try(each.value.instance.engine_version, "3.4.6")
  multi_az                     = try(each.value.instance.multi_az, false)
  preferred_maintenance_window = try(each.value.instance.maintenance_window, "sun:05:00-sun:08:00")
  replication_instance_class   = try(each.value.instance.instance_class, "dms.t3.medium")
  allowed_security_groups      = try(each.value.instance.allowed_security_groups, [])
  allowed_cidr_blocks          = try(each.value.instance.allowed_cidr_blocks, [])

  vpc_id                       = data.aws_vpc.selected.id
  subnet_ids                   = data.aws_subnets.private.ids
}
```

<!--- BEGIN_TF_DOCS --->

## Requirements

| Name | Version |
|------|---------|
| terraform | >= 0.13.0 |

## Providers

| Name | Version |
|------|---------|
| aws | n/a |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [aws_dms_replication_instance.default](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/dms_replication_instance) | resource |
| [aws_dms_replication_subnet_group.dms](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/dms_replication_subnet_group) | resource |
| [aws_security_group.default](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/security_group) | resource |
| [aws_security_group_rule.egress](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/security_group_rule) | resource |
| [aws_security_group_rule.ingress_cidr_blocks](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/security_group_rule) | resource |
| [aws_security_group_rule.ingress_security_groups](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/security_group_rule) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| allocated_storage | The amount of storage (in gigabytes) to be initially allocated for the replication instance. | `number` | `50` | no |
| allow_major_version_upgrade | Indicates that major version upgrades are allowed. | `bool` | `false` | no |
| allowed_cidr_blocks | List of CIDR blocks to be allowed to connect to the replication instance. | `list(string)` | `[]` | no |
| allowed_security_groups | List of existing Security Groups IDs to be allowed to connect to the replication instance. | `list(string)` | `[]` | no |
| apply_immediately | Indicates whether the changes should be applied immediately or during the next maintenance window. Only used when updating an existing resource. | `bool` | `false` | no |
| auto_minor_version_upgrade | Indicates that minor engine upgrades will be applied automatically to the replication instance during the maintenance window. | `bool` | `false` | no |
| availability_zone | The EC2 Availability Zone that the replication instance will be created in. | `string` | n/a | yes |
| engine_version | The engine version number of the replication instance. | `string` | n/a | yes |
| multi_az | Wether deploys a primary replication instance in one Availability Zone (AZ) and a standby in another AZ. | `bool` | `false` | no |
| preferred_maintenance_window | The weekly time range during which system maintenance can occur, in Universal Coordinated Time (UTC). | `string` | n/a | yes |
| publicly_accessible | Specifies the accessibility options for the replication instance. A value of true represents an instance with a public IP address. A value of false represents an instance with a private IP address. | `bool` | `false` | no |
| replication_instance_class | The compute and memory capacity of the replication instance as specified by the replication instance class. | `string` | `"dms.t3.micro"` | no |
| replication_instance_id | The replication instance identifier. | `string` | n/a | yes |
| replication_subnet_group_id | The name for the replication subnet group. This value is stored as a lowercase string. | `string` | n/a | yes |
| subnet_ids | A list of the EC2 subnet IDs for the subnet group. | `list(string)` | n/a | yes |
| vpc_id | VPC ID to create the cluster in (e.g. `vpc-a22222ee`). | `string` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| arn | Amazon Resource Name (ARN) of the DMS Replication Instance. |
| private_ips | List of the private IP addresses of the DMS Replication Instance. |
| public_ips | List of the public IP addresses of the DMS Replication Instance. |

<!--- END_TF_DOCS --->

## Authors

Module managed by [DNX Solutions](https://github.com/DNXLabs).

## License

Apache 2 Licensed. See [LICENSE](https://github.com/DNXLabs/terraform-aws-template/blob/master/LICENSE) for full details.