data "aws_secretsmanager_secret" "rediss" {
  name = "rediss/credentials"
}
data "aws_secretsmanager_secret_version" "rediss" {
  secret_id = data.aws_secretsmanager_secret.rediss.id
}

locals {
  redis_secret = jsondecode(data.aws_secretsmanager_secret_version.rediss.secret_string)
}
resource "aws_elasticache_parameter_group" "redis_parameter_group" {
  name        = "${var.redis-cluster}-parameter-group"
  family      = var.parameter-group-family
  description = "Custom parameter group for ElastiCache Redis"

}

resource "aws_security_group" "elasticache_security_group" {
  name        = "${var.redis-cluster}-sg"
  description = "Security group for ElastiCache Redis cluster"
  vpc_id      = var.redis_vpc_id

  # Ingress rule allowing access from specific subnets or security groups
  ingress {
    from_port   = var.redis_port
    to_port     = var.redis_port
    protocol    = "tcp"
    cidr_blocks = [var.redis_vpc_cidr_block]
  }

  # Egress rule allowing outbound traffic
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "aws_elasticache_subnet_group" "eccr" {
  name       = "${var.redis-cluster}-subnet-group"
  subnet_ids = var.redis_subnets
}

resource "aws_elasticache_user" "redis_user" {
  user_id   = var.redis-user-id
  user_name = var.redis-user-name
  engine    = var.redis-engine
  passwords = [local.redis_secret.password]  
  access_string = "on ~* +@all"  # Adjust access string as needed

  tags = {
    Name = "var.redis-user-id"
    Environment = var.environment
  }
}

resource "aws_elasticache_user_group" "redis_user_group" {
  user_group_id = var.redis-user-group
  engine        = var.redis-engine
  user_ids      = [aws_elasticache_user.redis_user.user_id]

  tags = {
    Name = "var.redis-user-group"
    Environment = var.environment
  }
}


resource "aws_elasticache_replication_group" "erg" {
  replication_group_id = var.replication-id
  description          = "Elasticache replication group"
  engine               = var.redis-engine
  engine_version       = var.redis-engine-version
  node_type            = var.redis-node-type
  #  num_cache_clusters            = var.num-cache-nodes
  num_node_groups            = var.num-node-groups # Ensure this is set correctly for cluster mode
  replicas_per_node_group    = var.replicas-per-node-group
  subnet_group_name          = aws_elasticache_subnet_group.eccr.name
  parameter_group_name       = aws_elasticache_parameter_group.redis_parameter_group.name
  security_group_ids         = [aws_security_group.elasticache_security_group.id]
  port                       = var.redis_port
  at_rest_encryption_enabled = var.redis_rest_encryption
  kms_key_id                 = var.redis_kms_arn
  transit_encryption_enabled = var.redis_transit_encryption
  automatic_failover_enabled = false
  user_group_ids = [aws_elasticache_user_group.redis_user_group.user_group_id]
  tags = var.elasticache_tags
}

resource "aws_elasticache_cluster" "redis" {
  cluster_id           = var.redis-cluster
  replication_group_id = aws_elasticache_replication_group.erg.id
}
