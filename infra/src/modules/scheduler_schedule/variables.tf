variable "name" {
    type = string
}

variable "group_name" {
    type = string
}

variable "state" {
    type = string
    default = "ENABLED"
    validation {
      condition = contains(["ENABLED", "DISABLED"], var.state)
      error_message = "state must be either 'ENABLED' or 'DISABLED'."
    }
}

variable "schedule_expression" {
    type = string
}

variable "schedule_expression_timezone" {
    type    = string
    default = "UTC"
}

variable "target" {
    type = object({
        arn      = string
        role_arn = string
        retry    = object({
            maximum_event_age_in_seconds = number
            maximum_retry_attempts       = number
        })
    })
}