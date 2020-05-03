# terraform-aws-elasticache-redis

[![CircleCI](https://circleci.com/gh/tmknom/terraform-aws-elasticache-redis.svg?style=svg)](https://circleci.com/gh/tmknom/terraform-aws-elasticache-redis)
[![GitHub tag](https://img.shields.io/github/tag/tmknom/terraform-aws-elasticache-redis.svg)](https://registry.terraform.io/modules/tmknom/elasticache-redis/aws)
[![License](https://img.shields.io/github/license/tmknom/terraform-aws-elasticache-redis.svg)](https://opensource.org/licenses/Apache-2.0)

Terraform module which creates Redis ElastiCache resources on AWS.

## Description

Provision [ElastiCache_Replication_Group](https://docs.aws.amazon.com/AmazonElastiCache/latest/red-ug/Clusters.html) and
[Parameter Group](https://docs.aws.amazon.com/AmazonElastiCache/latest/red-ug/ParameterGroups.html).

This module provides recommended settings:

- Enable Multi-AZ
- Enable automatic failover
- Enable at-rest encryption
- Enable in-transit encryption
- Enable automated backups

## Usage

### Minimal

```hcl
module "elasticache_redis" {
  source                = "git::https://github.com/tmknom/terraform-aws-elasticache-redis.git?ref=tags/1.0.0"
  name                  = "example"
  number_cache_clusters = 2
  node_type             = "cache.m3.medium"

  subnet_ids          = ["${var.subnet_ids}"]
  vpc_id              = "${var.vpc_id}"
  ingress_cidr_blocks = ["${var.ingress_cidr_blocks}"]
}
```

### Complete

```hcl
module "elasticache_redis" {
  source                = "git::https://github.com/tmknom/terraform-aws-elasticache-redis.git?ref=tags/1.0.0"
  name                  = "example"
  number_cache_clusters = 2
  node_type             = "cache.m3.medium"

  engine_version             = "5.0.0"
  port                       = 56379
  maintenance_window         = "mon:10:40-mon:11:40"
  snapshot_window            = "09:10-10:10"
  snapshot_retention_limit   = 1
  automatic_failover_enabled = false
  at_rest_encryption_enabled = false
  transit_encryption_enabled = false
  apply_immediately          = true
  family                     = "redis5.0"
  description                = "This is example"

  subnet_ids          = ["${var.subnet_ids}"]
  vpc_id              = "${var.vpc_id}"
  ingress_cidr_blocks = ["${var.ingress_cidr_blocks}"]

  tags = {
    Environment = "prod"
  }
}
```

## Examples

- [Minimal](https://github.com/tmknom/terraform-aws-elasticache-redis/tree/master/examples/minimal)
- [Complete](https://github.com/tmknom/terraform-aws-elasticache-redis/tree/master/examples/complete)

## Inputs

| Name                       | Description                                                                                                               |  Type  |        Default         | Required |
| -------------------------- | ------------------------------------------------------------------------------------------------------------------------- | :----: | :--------------------: | :------: |
| ingress_cidr_blocks        | List of Ingress CIDR blocks.                                                                                              |  list  |           -            |   yes    |
| name                       | The replication group identifier. This parameter is stored as a lowercase string.                                         | string |           -            |   yes    |
| node_type                  | The compute and memory capacity of the nodes in the node group.                                                           | string |           -            |   yes    |
| number_cache_clusters      | The number of cache clusters (primary and replicas) this replication group will have.                                     | string |           -            |   yes    |
| subnet_ids                 | List of VPC Subnet IDs for the cache subnet group.                                                                        |  list  |           -            |   yes    |
| vpc_id                     | VPC Id to associate with Redis ElastiCache.                                                                               | string |           -            |   yes    |
| apply_immediately          | Specifies whether any modifications are applied immediately, or during the next maintenance window.                       | string |        `false`         |    no    |
| at_rest_encryption_enabled | Whether to enable encryption at rest.                                                                                     | string |         `true`         |    no    |
| automatic_failover_enabled | Specifies whether a read-only replica will be automatically promoted to read/write primary if the existing primary fails. | string |         `true`         |    no    |
| description                | The description of the all resources.                                                                                     | string | `Managed by Terraform` |    no    |
| engine_version             | The version number of the cache engine to be used for the cache clusters in this replication group.                       | string |        `5.0.0`         |    no    |
| family                     | The family of the ElastiCache parameter group.                                                                            | string |       `redis5.0`       |    no    |
| maintenance_window         | Specifies the weekly time range for when maintenance on the cache cluster is performed.                                   | string |        `` | no         |
| port                       | The port number on which each of the cache nodes will accept connections.                                                 | string |         `6379`         |    no    |
| snapshot_retention_limit   | The number of days for which ElastiCache will retain automatic cache cluster snapshots before deleting them.              | string |          `30`          |    no    |
| snapshot_window            | The daily time range (in UTC) during which ElastiCache will begin taking a daily snapshot of your cache cluster.          | string |        `` | no         |
| tags                       | A mapping of tags to assign to all resources.                                                                             |  map   |          `{}`          |    no    |
| transit_encryption_enabled | Whether to enable encryption in transit.                                                                                  | string |         `true`         |    no    |

## Outputs

| Name                                                   | Description                                                                |
| ------------------------------------------------------ | -------------------------------------------------------------------------- |
| elasticache_parameter_group_id                         | The ElastiCache parameter group name.                                      |
| elasticache_replication_group_id                       | The ID of the ElastiCache Replication Group.                               |
| elasticache_replication_group_member_clusters          | The identifiers of all the nodes that are part of this replication group.  |
| elasticache_replication_group_primary_endpoint_address | The address of the endpoint for the primary node in the replication group. |
| security_group_arn                                     | The ARN of the Redis ElastiCache security group.                           |
| security_group_description                             | The description of the Redis ElastiCache security group.                   |
| security_group_egress                                  | The egress rules of the Redis ElastiCache security group.                  |
| security_group_id                                      | The ID of the Redis ElastiCache security group.                            |
| security_group_ingress                                 | The ingress rules of the Redis ElastiCache security group.                 |
| security_group_name                                    | The name of the Redis ElastiCache security group.                          |
| security_group_owner_id                                | The owner ID of the Redis ElastiCache security group.                      |
| security_group_vpc_id                                  | The VPC ID of the Redis ElastiCache security group.                        |

## Development

### Development Requirements

- [Docker](https://www.docker.com/)

### Configure environment variables

```shell
export AWS_ACCESS_KEY_ID=AKIAIOSFODNN7EXAMPLE
export AWS_SECRET_ACCESS_KEY=wJalrXUtnFEMI/K7MDENG/bPxRfiCYEXAMPLEKEY
export AWS_DEFAULT_REGION=ap-northeast-1
```

### Installation

```shell
git clone git@github.com:tmknom/terraform-aws-elasticache-redis.git
cd terraform-aws-elasticache-redis
make install
```

### Makefile targets

```text
check-format                   Check format code
cibuild                        Execute CI build
clean                          Clean .terraform
docs                           Generate docs
format                         Format code
help                           Show help
install                        Install requirements
lint                           Lint code
release                        Release GitHub and Terraform Module Registry
terraform-apply-complete       Run terraform apply examples/complete
terraform-apply-minimal        Run terraform apply examples/minimal
terraform-destroy-complete     Run terraform destroy examples/complete
terraform-destroy-minimal      Run terraform destroy examples/minimal
terraform-plan-complete        Run terraform plan examples/complete
terraform-plan-minimal         Run terraform plan examples/minimal
upgrade                        Upgrade makefile
```

### Releasing new versions

Bump VERSION file, and run `make release`.

### Terraform Module Registry

- <https://registry.terraform.io/modules/tmknom/elasticache-redis/aws>

## License

Apache 2 Licensed. See LICENSE for full details.
