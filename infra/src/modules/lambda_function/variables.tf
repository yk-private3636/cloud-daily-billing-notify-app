variable "function_name" {
    type = string
}

variable "role_arn" {
    type = string
}

variable "image_uri" {
    type = string
}

variable "memory_size" {
    type    = number
    default = 128
}

variable "architectures" {
    type    = list(string)
    default = ["x86_64"]
}

variable "timeout" {
    type    = number
}

variable "environments" {
    type = list(map(string))
}