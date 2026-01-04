variable "role_id" {
    type = string
}

variable "title" {
    type = string
}

variable "description" {
    type = string
    default = ""
}

variable "permissions" {
    type = list(string)
}

variable "stage" {
    type    = string
    default = "GA"
}