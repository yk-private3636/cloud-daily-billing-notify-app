variable "env" {
  type = string

  validation {
    condition     = contains(["dev", "staging", "prod"], var.env)
    error_message = "env must be one of: dev, staging, prod."
  }
}

variable "project_name" {
  type    = string
  default = "cloud-daily-billing-notify-app"

  validation {
    condition     = var.project_name == "cloud-daily-billing-notify-app"
    error_message = "The project_name variable must be set to 'cloud-daily-billing-notify-app'. Overriding this value is not allowed."
  }
}

variable "aws_region" {
  type    = list(string)
  default = ["ap-northeast-1", "ap-northeast-3"]
}

variable "aws_az" {
  type    = list(string)
  default = ["ap-northeast-1a", "ap-northeast-1c", "ap-northeast-1d"]
}

variable "account_id" {
  type      = string
  sensitive = true
}

variable "executor_role_arn" {
  type      = string
  sensitive = true
}

variable "executor_role_principal_name" {
  type      = string
  sensitive = true
}