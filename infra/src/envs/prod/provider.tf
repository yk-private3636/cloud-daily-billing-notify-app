provider "aws" {
  region = var.aws_region[0]
  assume_role {
    role_arn = var.executor_role_arn
  }
  default_tags {
    tags = {
      Environment = var.env
      name        = var.project_name
    }
  }
}

provider "google" {
  project                     = var.project_name
  region                      = "asia-northeast1"
  zone                        = "asia-northeast1-a"
  impersonate_service_account = var.google_service_account_email
  default_labels = {
    environment = var.env
    name        = var.project_name
  }
}