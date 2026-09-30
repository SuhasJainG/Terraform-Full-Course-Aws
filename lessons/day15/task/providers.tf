terraform {
  required_providers {
    aws = {
      source = "hashicorp/aws"
      version = "~> 6.0"
    }
  }
}


provider "aws" {
  alias  = "primary-region"
  region = var.primary-region
}

provider "aws" {
  alias = "secondary-region"
  region = var.secondary-region
}