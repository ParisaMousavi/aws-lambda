variable "filename" {
  type = string
}

variable "name" {
  type = string
}

variable "role_arn" {
  type = string
}

variable "handler" {
  type    = string
  default = "index.handler"
}

# The filebase64sha256() function is available in Terraform 0.11.12 and later
# For Terraform 0.11.11 and earlier, use the base64sha256() function and the file() function:
# source_code_hash = "${base64sha256(file("lambda_function_payload.zip"))}"
# data.archive_file.source.output_base64sha256'
variable "source_code_hash" {
  type = string
}

variable "runtime" {
  type    = string
  default = "nodejs14.x"
}

variable "environment_vars" {
  type = map(string)
}

variable "additional_tags" {
  default = {}
  type    = map(string)
}
variable "event_source_arn" {
  type    = string
  default = null
}

variable "starting_position" {
  type    = string
  default = "LATEST"
}

variable "subnet_ids" {
  type = list(string)
}

variable "security_group_ids" {
  type = list(string)
}