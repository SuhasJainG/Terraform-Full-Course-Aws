variable "Environment" {
  type = string
  default = "dev"
}

variable "region" {
  type = string
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

variable "cidr" {
  type = list(string)
  default = ["10.0.0.0/16", "10.0.1.0/24", "10.0.2.0/24"]
}