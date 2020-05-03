output "elasticache_replication_group_id" {
  value       = aws_elasticache_replication_group.default.id
  description = "The ID of the ElastiCache Replication Group."
}

output "elasticache_replication_group_primary_endpoint_address" {
  value       = aws_elasticache_replication_group.default.primary_endpoint_address
  description = "The address of the endpoint for the primary node in the replication group."
}

output "elasticache_replication_group_member_clusters" {
  value       = aws_elasticache_replication_group.default.member_clusters
  description = "The identifiers of all the nodes that are part of this replication group."
}

output "elasticache_parameter_group_id" {
  value       = aws_elasticache_parameter_group.default.id
  description = "The ElastiCache parameter group name."
}

output "security_group_id" {
  value       = aws_security_group.default.id
  description = "The ID of the Redis ElastiCache security group."
}

output "security_group_arn" {
  value       = aws_security_group.default.arn
  description = "The ARN of the Redis ElastiCache security group."
}

output "security_group_vpc_id" {
  value       = aws_security_group.default.vpc_id
  description = "The VPC ID of the Redis ElastiCache security group."
}

output "security_group_owner_id" {
  value       = aws_security_group.default.owner_id
  description = "The owner ID of the Redis ElastiCache security group."
}

output "security_group_name" {
  value       = aws_security_group.default.name
  description = "The name of the Redis ElastiCache security group."
}

output "security_group_description" {
  value       = aws_security_group.default.description
  description = "The description of the Redis ElastiCache security group."
}

output "security_group_ingress" {
  value       = aws_security_group.default.ingress
  description = "The ingress rules of the Redis ElastiCache security group."
}

output "security_group_egress" {
  value       = aws_security_group.default.egress
  description = "The egress rules of the Redis ElastiCache security group."
}
