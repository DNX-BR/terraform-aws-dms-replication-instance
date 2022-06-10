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
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 0.13.0 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | n/a |

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
| <a name="input_allocated_storage"></a> [allocated\_storage](#input\_allocated\_storage) | The amount of storage (in gigabytes) to be initially allocated for the replication instance | `number` | `50` | no |
| <a name="input_allowed_cidr_blocks"></a> [allowed\_cidr\_blocks](#input\_allowed\_cidr\_blocks) | List of CIDR blocks to be allowed to connect to the replication Instance | `list(string)` | `[]` | no |
| <a name="input_allowed_security_groups"></a> [allowed\_security\_groups](#input\_allowed\_security\_groups) | List of existing Security Groups IDs to be allowed to connect to the replication Instance | `list(string)` | `[]` | no |
| <a name="input_availability_zone"></a> [availability\_zone](#input\_availability\_zone) | The EC2 Availability Zone that the replication instance will be created in | `string` | n/a | yes |
| <a name="input_engine_version"></a> [engine\_version](#input\_engine\_version) | The engine version number of the replication instance | `string` | n/a | yes |
| <a name="input_multi_az"></a> [multi\_az](#input\_multi\_az) | Wether deploys a primary replication instance in one Availability Zone (AZ) and a standby in another AZ | `bool` | `false` | no |
| <a name="input_preferred_maintenance_window"></a> [preferred\_maintenance\_window](#input\_preferred\_maintenance\_window) | The weekly time range during which system maintenance can occur, in Universal Coordinated Time (UTC) | `string` | n/a | yes |
| <a name="input_replication_instance_class"></a> [replication\_instance\_class](#input\_replication\_instance\_class) | The compute and memory capacity of the replication instance as specified by the replication instance class | `string` | `"dms.t3.micro"` | no |
| <a name="input_replication_instance_id"></a> [replication\_instance\_id](#input\_replication\_instance\_id) | The replication instance identifier | `string` | n/a | yes |
| <a name="input_replication_subnet_group_id"></a> [replication\_subnet\_group\_id](#input\_replication\_subnet\_group\_id) | The name for the replication subnet group. This value is stored as a lowercase string | `string` | n/a | yes |
| <a name="input_subnet_ids"></a> [subnet\_ids](#input\_subnet\_ids) | A list of the EC2 subnet IDs for the subnet group | `list(string)` | n/a | yes |
| <a name="input_vpc_id"></a> [vpc\_id](#input\_vpc\_id) | VPC ID to create the cluster in (e.g. `vpc-a22222ee`) | `string` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_arn"></a> [arn](#output\_arn) | Amazon Resource Name (ARN) of the DMS Replication Instance |
| <a name="output_private_ips"></a> [private\_ips](#output\_private\_ips) | List of the private IP addresses of the DMS Replication Instance |
| <a name="output_public_ips"></a> [public\_ips](#output\_public\_ips) | List of the public IP addresses of the replication instance |


<!--- END_TF_DOCS --->

## Authors

Module managed by [DNX Solutions](https://github.com/DNXLabs).

## License

Apache 2 Licensed. See [LICENSE](https://github.com/DNXLabs/terraform-aws-template/blob/master/LICENSE) for full details.