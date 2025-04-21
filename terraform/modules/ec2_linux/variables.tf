variable "ami" {
  type        = string
  description = "The ID of the Amazon Machine Image (AMI) used to launch the instance"
}

variable "ec2_instance_type" {
  type        = string
  description = "The type of EC2 instance to launch"
}

variable "ec2_key_name" {
  type        = string
  description = "jumpserver name"
}

variable "linux_tags" {
  type = map(string)
}

variable "linux_subnet" {
  type        = string
}

variable "linux_vpc_id" {
  type        = string
}
