variable "Environment" {
  type = string
  default = "dev"
}

variable "region" {
  type = string
}

variable "bucketname" {
  type = list(string)
  default = [ "suhas-devops-bucket-050726","suhas-devops-bucket-060726" ]
}

variable "bucketnameset" {
  type = set(string)
  default = [ "suhas-devops-bucket-0507261","suhas-devops-bucket-0607262" ]
}