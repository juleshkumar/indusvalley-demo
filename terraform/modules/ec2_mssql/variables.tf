variable "mssql_ami" {
  type        = string
  description = "The ID of the Amazon Machine Image (AMI) used to launch the instance"
}

variable "mssql_ec2_instance_type" {
  type        = string
  description = "The type of EC2 instance to launch"
}

variable "ec2_mssql_tags" {
  type = map(string)
}

variable "mssql_ec2_key_name" {
  type        = string
  description = "jumpserver name"
}

variable "mssql_subnet" {
  type = string
}

variable "mssql_vpc_id" {
  type        = string
}
