variable "Environment" {
  type = string
  default = "dev"
}

variable "region" {
  type = string
  default = "us-east-4"

  validation {
    condition = contains(["us-east-1", "us-west-2", "eu-west-1"], var.region)
    error_message = "invalid region"
  }
}

variable "instance_count" {
  type = number
  default = 1
}

variable "type" {
  type = string
  default = "t2.micro"
}

variable "az" {
  type = string
  default = "us-east-1a"
}

variable "monitoring" {
  type = bool
  default = false
}

variable "associate_public_ip_address" {
  type = bool
  default = true
}

variable "allowed_vm_types" {
  type = string
  default = "t2.micro"

  validation {
    condition = contains(["t2.micro", "t2.small", "t3.micro", "t3.small"], var.allowed_vm_types)
    error_message = "Invalid vm type"
  }
}

