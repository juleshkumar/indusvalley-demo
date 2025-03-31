variable "kms_key_name" {
  type        = string
  description = "(optional) describe your variable"
}

variable "kms_tags" {
  type = map(string)
  
}
