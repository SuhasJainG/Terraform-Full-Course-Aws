variable "environment" {
  type        = string
  description = "Environment name"
  default     = "dev"

  validation {
    condition     = contains(["dev", "staging", "prod"], var.environment)
    error_message = "Environment must be one of: dev, staging, prod"
  }
}

variable "region" {
  default = "us-east-1"
}

variable "projectname" {
  default = "Project ALPHA Resource"
}

variable "default_tags" {
  type = map(string)
  default = {
    company    = "TechCorp"
    managed_by = "terraform"
  }
}

variable "environment_tags" {
  type = map(string)
  default = {
    environment = "production"
    cost_center = "cc-123"
  }
}

variable "bucket_name" {
  type        = string
  description = "S3 bucket name (must be globally unique)"
  default     = "ProjectAlphaStorageBucket with CAPS and spaces!!!"
}

variable "allowed_ports" {
  type        = string
  description = "Comma-separated list of allowed ports"
  default     = "80,443,8080,3306"
}

variable "instance_sizes" {
  type = map(string)
  default = {
    dev     = "t2.micro"
    staging = "t3.small"
    prod    = "t3.large"
  }
}

variable "instance_type" {
  default = "t2.micro"

  validation {
    condition = length(var.instance_type)>4 && length(var.instance_type) <20
    error_message = "Instance type must be between 2 and 20 characters"
  }
  validation {
    condition = can(regex("^t[2-3]\\.",var.instance_type))
    error_message = "invalid name- should be t2 or t3"
  }
}

variable "backup" {
  default = "daily_backup"
  sensitive = true

  validation {
    condition = endswith(var.backup, "_backup")
    error_message = "backup name missing"
  }
}

variable "user_locations" {
  type        = list(string)
  description = "User-specified AWS regions"
  default     = ["us-east-1", "us-west-2", "us-east-1"] # Contains duplicate
}

variable "default_locations" {
  type        = list(string)
  description = "Default AWS regions"
  default     = ["us-west-1"]
}

variable "monthly_costs" {
  type        = list(number)
  description = "Monthly infrastructure costs (can include negative values for credits)"
  default     = [-50, 100, 75, 200]
}