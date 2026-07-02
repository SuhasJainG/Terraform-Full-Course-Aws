terraform {
  required_providers {
    aws = {
      source = "hashicorp/aws"
      version = "~> 6.0"
    }
  }
}

terraform {
  backend "s3" {
   bucket       = "terraform-state-1783015934"
    key          = "dev/terraform.tfstate"
   region       = "us-east-1"
    use_lockfile = true
    encrypt      = true
  }
}

provider "aws" {
  # Configuration options
    region = "us-east-1"
}

# Create a S3 bucket
resource "aws_s3_bucket" "tf_test_baivab_bucket" {
  bucket = "my-tf-test-baiv-bucket-101"

  tags = {
    Name        = "My bucket"
    Environment = "Dev"
  }
}