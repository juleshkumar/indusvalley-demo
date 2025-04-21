variable "rds_db_instance_identifier" {
  type        = string
  description = "Please mention the Database Instance Identifier"
}

variable "rds_database_name" {
  type        = string
  description = "rds Database Name"
}

variable "database_user" {
  type        = string
  description = "rds Database Username"
}

variable "major_version" {
  type        = string
  description = "rds Database Parameter Group Major Version"
}

variable "engine_version" {
  type        = string
  description = "rds Database Engine Version"
}

variable "rds_db_security_group" {
  type        = string
  description = "rds Database Security Group"
}

variable "rds_db_instance_type" {
  type        = string
  description = "rds Database Instance Type"
}

variable "rds_db_allocated_storage" {
  type        = string
  description = "rds Database Storage Size"
}

#variable "rds__db_cidr_range" {
#  type        = string
#  description = "rds CIDR Range"
#  default     = ""
#}

variable "rds_port" {
  type        = string
  description = "rds CIDR Range"
}
variable "rds_tags" {
  type = map(string)
  default = {
    Environment = "dev"
  }
}

variable "rds_vpc_cidr" {
  type        = string
}

variable "rds_subnets" {
  type        = list(string)
}

variable "rds_vpc_id" {
  type        = string
}

variable "rds_kms_arn" {
  type        = string
}