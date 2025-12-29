variable "repository_name" {
  type        = string  
}

variable "image_tag_mutability" {
  type        = string
  default     = "MUTABLE"
  validation {
    condition = contains(["MUTABLE", "IMMUTABLE"], var.image_tag_mutability)
    error_message = "image_tag_mutability must be either 'MUTABLE' or 'IMMUTABLE'."
  }
}

variable "encryption_type" {
  type        = string
  default     = "AES256"
  validation {
    condition = contains(["AES256", "KMS"], var.encryption_type)
    error_message = "encryption_type must be either 'AES256' or 'KMS'."
  }
}

variable "scan_on_push" {
  type        = bool
  default     = true
}