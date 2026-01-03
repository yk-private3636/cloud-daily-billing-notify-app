terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 6.0"
    }
    google = {
      source  = "hashicorp/google"
      version = "~> 7.0"
    }
  }

  backend "s3" {
    bucket       = "cloud-daily-billing-notify-app-tfstate"
    key          = "prod/terraform.state"
    region       = "ap-northeast-1"
    use_lockfile = true
  }
}