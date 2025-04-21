variable "vpc_cidr" {
  description = "CIDR block for the VPC"
  type        = string
}

variable "public_subnet_1_cidr" {
  description = "CIDR block for the first public subnet"
  type        = string
}

variable "public_subnet_2_cidr" {
  description = "CIDR block for the second public subnet"
  type        = string
}

variable "private_subnet_1_cidr" {
  description = "CIDR block for the first private subnet"
  type        = string
}

variable "private_subnet_2_cidr" {
  description = "CIDR block for the second private subnet"
  type        = string
}

variable "vpc_tags" {
  description = "Tags for the VPC"
  type        = map(string)
}

variable "igw_tags" {
  description = "Tags for the IGW"
  type        = map(string)
}

variable "environment" {
  type        = string
  description = "environment for vpc"
}

variable "security_group" {
  type        = string
  description = "vpc security group"
}

variable "cluster-name" {
  description = "The name of the cluster"
  type        = string
}