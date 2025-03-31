module "elasticache" {
  source               = "../../../modules/elasticache"
  redis-cluster        = var.redis-cluster
  redis-engine         = var.redis-engine
  redis-engine-version = var.redis-engine-version
  redis-node-type      = var.redis-node-type
  #  num-cache-nodes        = var.num-cache-nodes
  parameter-group-family  = var.parameter-group-family
  replication-id          = var.replication-id
  num-node-groups         = var.num-node-groups
  replicas-per-node-group = var.replicas-per-node-group
  rest_encryption         = var.rest_encryption
  elasticache_tags = var.elasticache_tags
  redis_password          = var.redis_password
  redis-user-id           = var.redis-user-id
  redis-user-name         = var.redis-user-name
  redis_port              = var.redis_port
  transit_encryption_enabled = var.transit_encryption_enabled
  backend_bucket     = var.backend_bucket
  region             = var.region
  backend_path       = var.backend_path
  redis-user-group   = var.redis-user-group
  environment                      = var.environment
}
