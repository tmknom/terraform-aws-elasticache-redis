variable "name" {
  type        = "string"
  description = "The replication group identifier. This parameter is stored as a lowercase string."
}

variable "number_cache_clusters" {
  type        = "string"
  description = "The number of cache clusters (primary and replicas) this replication group will have."
}

variable "node_type" {
  type        = "string"
  description = "The compute and memory capacity of the nodes in the node group."
}

variable "engine_version" {
  default     = "5.0.0"
  type        = "string"
  description = "The version number of the cache engine to be used for the cache clusters in this replication group."
}

variable "port" {
  default     = 6379
  type        = "string"
  description = "The port number on which each of the cache nodes will accept connections."
}

variable "maintenance_window" {
  default     = ""
  type        = "string"
  description = "Specifies the weekly time range for when maintenance on the cache cluster is performed."
}

variable "snapshot_window" {
  default     = ""
  type        = "string"
  description = "The daily time range (in UTC) during which ElastiCache will begin taking a daily snapshot of your cache cluster."
}

variable "snapshot_retention_limit" {
  default     = "30"
  type        = "string"
  description = "The number of days for which ElastiCache will retain automatic cache cluster snapshots before deleting them."
}

variable "automatic_failover_enabled" {
  default     = true
  type        = "string"
  description = "Specifies whether a read-only replica will be automatically promoted to read/write primary if the existing primary fails."
}

variable "auto_minor_version_upgrade" {
  default     = true
  type        = "string"
  description = "Specifies whether a minor engine upgrades will be applied automatically to the underlying Cache Cluster instances during the maintenance window."
}

variable "at_rest_encryption_enabled" {
  default     = true
  type        = "string"
  description = "Whether to enable encryption at rest."
}

variable "transit_encryption_enabled" {
  default     = true
  type        = "string"
  description = "Whether to enable encryption in transit."
}

variable "apply_immediately" {
  default     = false
  type        = "string"
  description = "Specifies whether any modifications are applied immediately, or during the next maintenance window."
}

variable "description" {
  default     = "Managed by Terraform"
  type        = "string"
  description = "The description of the all resources."
}

variable "tags" {
  default     = {}
  type        = "map"
  description = "A mapping of tags to assign to all resources."
}
