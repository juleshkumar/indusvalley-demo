#AWS Account Numbe
variable "mssql_public_key_file" {
  type        = string
  description = "File path to the public key file"
}

variable "mssql_ami" {
  type        = string
  description = "The ID of the Amazon Machine Image (AMI) used to launch the instance"
}

variable "mssql_ec2_instance_type" {
  type        = string
  description = "The type of EC2 instance to launch"
}

variable "mssql_js_user" {
  type        = string
  description = "jumpser username"
}

variable "ec2_mssql_tags" {
  type = map(string)
}

variable "mssql_ec2_key_name" {
  type        = string
  description = "jumpserver name"
}

variable "region" {
  type = string
}

variable "backend_bucket" {
  type = string
}

 variable "backend_path" {
  description = "The name of the cluster"
  type        = string
}
