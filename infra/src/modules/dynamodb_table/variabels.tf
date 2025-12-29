variable "table_name" {
    type = string
}

variable "billing_mode" {
    type = string
    default = "PAY_PER_REQUEST"
    validation {
      condition = contains(["PAY_PER_REQUEST", "PROVISIONED"], var.billing_mode)
        error_message = "billing_mode must be either PAY_PER_REQUEST or PROVISIONED"
    }
}

variable "hash_key" {
    type = string
}

variable "range_key" {
    type = string
    default = null
}

variable "read_capacity" {
    type = number
    default = 0
}

variable "write_capacity" {
    type = number
    default = 0
}

variable "point_in_time_recovery" {
    type = object({
        enabled = bool
        recovery_period_in_days = number
    })
    default = {
        enabled = false
        recovery_period_in_days = 1
    }
}

variable "attributes" {
    type = list(object({
        name = string
        type = string
    }))
    default = []
}

