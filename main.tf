# Terraform module which creates Redis ElastiCache resources on AWS.
#
# https://docs.aws.amazon.com/AmazonElastiCache/latest/red-ug/WhatIs.html

# https://www.terraform.io/docs/providers/aws/r/elasticache_replication_group.html
resource "aws_elasticache_replication_group" "default" {
  engine               = "redis"
  parameter_group_name = aws_elasticache_parameter_group.default.name
  subnet_group_name    = aws_elasticache_subnet_group.default.name
  security_group_ids   = [aws_security_group.default.id]

  # The replication group identifier. This parameter is stored as a lowercase string.
  #
  # - Must contain from 1 to 20 alphanumeric characters or hyphens.
  # - Must begin with a letter.
  # - Cannot contain two consecutive hyphens.
  # - Cannot end with a hyphen.
  #
  # https://docs.aws.amazon.com/AmazonElastiCache/latest/red-ug/Clusters.Create.CON.Redis.html
  replication_group_id = var.name

  # The number of clusters this replication group initially has.
  # If automatic_failover_enabled is true, the value of this parameter must be at least 2.
  # The maximum permitted value for number_cache_clusters is 6 (1 primary plus 5 replicas).
  # https://docs.aws.amazon.com/AmazonElastiCache/latest/red-ug/Scaling.RedisReplGrps.html
  number_cache_clusters = var.number_cache_clusters

  # The compute and memory capacity of the nodes in the node group (shard).
  # Generally speaking, the current generation types provide more memory and computational power at lower cost
  # when compared to their equivalent previous generation counterparts.
  # https://docs.aws.amazon.com/AmazonElastiCache/latest/red-ug/CacheNodes.SupportedTypes.html
  node_type = var.node_type

  # The version number of the cache engine to be used for the clusters in this replication group.
  # You can upgrade to a newer engine version, but you cannot downgrade to an earlier engine version.
  # https://docs.aws.amazon.com/AmazonElastiCache/latest/red-ug/supported-engine-versions.html
  engine_version = var.engine_version

  # The port number on which each member of the replication group accepts connections.
  # Redis default port is 6379.
  port = var.port

  # Every cluster and replication group has a weekly maintenance window during which any system changes are applied.
  # Specifies the weekly time range during which maintenance on the cluster is performed.
  # It is specified as a range in the format ddd:hh24:mi-ddd:hh24:mi. (Example: "sun:23:00-mon:01:30")
  # The minimum maintenance window is a 60 minute period.
  # https://docs.aws.amazon.com/AmazonElastiCache/latest/red-ug/maintenance-window.html
  maintenance_window = var.maintenance_window

  # A period during each day when ElastiCache will begin creating a backup.
  # The minimum length for the backup window is 60 minutes.
  # If you do not specify a backup window, ElastiCache will assign one automatically.
  # https://docs.aws.amazon.com/AmazonElastiCache/latest/red-ug/backups-automatic.html
  snapshot_window = var.snapshot_window

  # The number of days the backup will be retained in Amazon S3.
  # The maximum backup retention limit is 35 days.
  # If the backup retention limit is set to 0, automatic backups are disabled for the cluster.
  # https://docs.aws.amazon.com/AmazonElastiCache/latest/red-ug/backups-automatic.html
  snapshot_retention_limit = var.snapshot_retention_limit

  # You can enable Multi-AZ with Automatic Failover only on Redis (cluster mode disabled) clusters that have at least
  # one available read replica. Clusters without read replicas do not provide high availability or fault tolerance.
  # https://docs.aws.amazon.com/AmazonElastiCache/latest/red-ug/AutoFailover.html
  automatic_failover_enabled = var.automatic_failover_enabled

  # Redis at-rest encryption is an optional feature to increase data security by encrypting on-disk data during sync
  # and backup or snapshot operations. Because there is some processing needed to encrypt and decrypt the data,
  # enabling at-rest encryption can have some performance impact during these operations.
  # You should benchmark your data with and without at-rest encryption to determine the performance impact for your use cases.
  # https://docs.aws.amazon.com/AmazonElastiCache/latest/red-ug/at-rest-encryption.html
  at_rest_encryption_enabled = var.at_rest_encryption_enabled

  # ElastiCache in-transit encryption is an optional feature that allows you to increase the security of your data at
  # its most vulnerable points—when it is in transit from one location to another. Because there is some processing
  # needed to encrypt and decrypt the data at the endpoints, enabling in-transit encryption can have some performance impact.
  # You should benchmark your data with and without in-transit encryption to determine the performance impact for your use cases.
  # https://docs.aws.amazon.com/AmazonElastiCache/latest/red-ug/in-transit-encryption.html
  transit_encryption_enabled = var.transit_encryption_enabled

  # If true, this parameter causes the modifications in this request and any pending modifications to be applied,
  # asynchronously and as soon as possible, regardless of the maintenance_window setting for the replication group.
  # apply_immediately applies only to modifications in node type, engine version, and changing the number of nodes in a cluster.
  # Other modifications, such as changing the maintenance window, are applied immediately.
  # https://docs.aws.amazon.com/AmazonElastiCache/latest/red-ug/Clusters.Modify.html
  apply_immediately = var.apply_immediately

  # A user-created description for the replication group.
  replication_group_description = var.description

  # A mapping of tags to assign to the resource.
  tags = merge({ "Name" = var.name }, var.tags)
}

# https://www.terraform.io/docs/providers/aws/r/elasticache_parameter_group.html
resource "aws_elasticache_parameter_group" "default" {
  name        = var.name
  family      = var.family
  description = var.description
}

# https://www.terraform.io/docs/providers/aws/r/elasticache_subnet_group.html
resource "aws_elasticache_subnet_group" "default" {
  name        = var.name
  subnet_ids  = var.subnet_ids
  description = var.description
}

# https://www.terraform.io/docs/providers/aws/r/security_group.html
resource "aws_security_group" "default" {
  name   = local.security_group_name
  vpc_id = var.vpc_id
  tags   = merge({ "Name" = local.security_group_name }, var.tags)
}

locals {
  security_group_name = "${var.name}-elasticache-redis"
}

# https://www.terraform.io/docs/providers/aws/r/security_group_rule.html
resource "aws_security_group_rule" "ingress" {
  count             = length(var.source_cidr_blocks) > 0 ? 1 : 0
  type              = "ingress"
  from_port         = var.port
  to_port           = var.port
  protocol          = "tcp"
  cidr_blocks       = var.source_cidr_blocks
  security_group_id = aws_security_group.default.id
}

resource "aws_security_group_rule" "egress" {
  type              = "egress"
  from_port         = 0
  to_port           = 0
  protocol          = "-1"
  cidr_blocks       = ["0.0.0.0/0"]
  security_group_id = aws_security_group.default.id
}
