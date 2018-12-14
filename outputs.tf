output "elasticache_replication_group_id" {
  value       = "${aws_elasticache_replication_group.default.id}"
  description = "The ID of the ElastiCache Replication Group."
}

output "elasticache_replication_group_primary_endpoint_address" {
  value       = "${aws_elasticache_replication_group.default.primary_endpoint_address}"
  description = "The address of the endpoint for the primary node in the replication group."
}

output "elasticache_replication_group_member_clusters" {
  value       = "${aws_elasticache_replication_group.default.member_clusters}"
  description = "The identifiers of all the nodes that are part of this replication group."
}

output "elasticache_parameter_group_id" {
  value       = "${aws_elasticache_parameter_group.default.id}"
  description = "The ElastiCache parameter group name."
}
