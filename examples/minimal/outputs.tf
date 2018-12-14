output "elasticache_replication_group_id" {
  value = "${module.elasticache_redis.elasticache_replication_group_id}"
}

output "elasticache_replication_group_primary_endpoint_address" {
  value = "${module.elasticache_redis.elasticache_replication_group_primary_endpoint_address}"
}

output "elasticache_replication_group_member_clusters" {
  value = "${module.elasticache_redis.elasticache_replication_group_member_clusters}"
}

output "elasticache_parameter_group_id" {
  value = "${module.elasticache_redis.elasticache_parameter_group_id}"
}

output "security_group_id" {
  value = "${module.elasticache_redis.security_group_id}"
}

output "security_group_arn" {
  value = "${module.elasticache_redis.security_group_arn}"
}

output "security_group_vpc_id" {
  value = "${module.elasticache_redis.security_group_vpc_id}"
}

output "security_group_owner_id" {
  value = "${module.elasticache_redis.security_group_owner_id}"
}

output "security_group_name" {
  value = "${module.elasticache_redis.security_group_name}"
}

output "security_group_description" {
  value = "${module.elasticache_redis.security_group_description}"
}

output "security_group_ingress" {
  value = "${module.elasticache_redis.security_group_ingress}"
}

output "security_group_egress" {
  value = "${module.elasticache_redis.security_group_egress}"
}
