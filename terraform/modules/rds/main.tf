data "terraform_remote_state" "vpc_state" {
  backend = "s3"

  config = {
    bucket     = var.backend_bucket
    key        = "${var.backend_path}/backend/vpc"
    region     = var.region
  }
}

resource "aws_db_subnet_group" "rds_subnet_group" {
  name        = "${var.rds_db_instance_identifier}-subnet-group"
  description = "RDS subnet group"
  subnet_ids  = data.terraform_remote_state.vpc_state.outputs.private_subnet_ids
}

resource "aws_security_group" "rds_security" {
  name        = var.rds_db_security_group
  description = "RDS PostgreSQL server"
  vpc_id      = data.terraform_remote_state.vpc_state.outputs.vpc_id

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
  tags = {
    Name = "${var.rds_db_security_group}"
  }
}

resource "aws_security_group_rule" "rds_ingress_rules" {
  type              = "ingress"
  from_port         = var.rds_port
  to_port           = var.rds_port
  protocol          = "tcp"
  cidr_blocks       = [data.terraform_remote_state.vpc_state.outputs.vpc_cidr_block]
  security_group_id = aws_security_group.rds_security.id
}



resource "aws_db_parameter_group" "rds_database" {
  name        = "${var.rds_db_instance_identifier}-param-group"
  description = "rds parameter group for postgreSQL"
  family      = "postgres${var.major_version}"
  parameter {
    apply_method = "pending-reboot"
    name         = "max_connections"
    value        = "3000"
  }
}

resource "aws_db_instance" "rds_database_instance" {
  identifier                = var.rds_db_instance_identifier
  allocated_storage         = var.rds_db_allocated_storage
  engine                    = "postgres"
  engine_version            = var.engine_version
  instance_class            = var.rds_db_instance_type
  db_name                   = var.rds_database_name
  username                  = var.database_user
  password                  = var.database_password
  db_subnet_group_name      = aws_db_subnet_group.rds_subnet_group.name
  storage_encrypted         = true
  vpc_security_group_ids    = [aws_security_group.rds_security.id]
  storage_type              = "gp3"
  skip_final_snapshot       = true
  final_snapshot_identifier = "Ignore"
  parameter_group_name      = aws_db_parameter_group.rds_database.name
  apply_immediately         = true
  port                      = var.rds_port

  tags = var.rds_tags
}
