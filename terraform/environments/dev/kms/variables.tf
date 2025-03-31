variable "kms_key_name" {
  type        = string
  description = "(optional) describe your variable"
}

variable "region" {
  type = string
}

variable "kms_tags" {
  type = map(string)
  
}


