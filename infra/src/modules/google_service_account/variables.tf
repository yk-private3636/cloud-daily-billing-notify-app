variable "account_id" {
    type = string
}

variable "display_name" {
    type = string
}

variable "description" {
    type    = string
    default = ""
}

variable "disabled" {
    type    = bool
    default = false
}