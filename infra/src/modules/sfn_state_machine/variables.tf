variable "name" {
    type = string
}

variable "type" {
    type = string
    validation {
      condition = contains(["STANDARD", "EXPRESS"], var.type)
      error_message = "Type must be either STANDARD or EXPRESS."
    }
}

variable "role_arn" {
    type = string
}

variable "definition_json" {
    type = string
}