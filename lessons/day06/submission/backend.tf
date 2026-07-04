terraform {
  backend "s3" {
   bucket       = "terraform-state-1783015934"
    key          = "dev/terraform.tfstate"
   region       = "us-east-1"
    use_lockfile = true
    encrypt      = true
  }
}