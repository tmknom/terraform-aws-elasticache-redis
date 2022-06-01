module "elasticache_redis" {
  source             = "../../"
  name               = "example"
  num_cache_clusters = 2
  node_type          = "cache.m3.medium"

  subnet_ids         = module.vpc.public_subnet_ids
  vpc_id             = module.vpc.vpc_id
  source_cidr_blocks = [module.vpc.vpc_cidr_block]
}

module "vpc" {
  source                    = "git::https://github.com/tmknom/terraform-aws-vpc.git?ref=tags/2.0.1"
  cidr_block                = local.cidr_block
  name                      = "vpc-elasticache-redis"
  public_subnet_cidr_blocks = [cidrsubnet(local.cidr_block, 8, 0), cidrsubnet(local.cidr_block, 8, 1)]
  public_availability_zones = data.aws_availability_zones.available.names
}

locals {
  cidr_block = "10.255.0.0/16"
}

data "aws_availability_zones" "available" {}
