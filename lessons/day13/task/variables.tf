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

variable "instance_count" {
  type = number
}

variable "tags" {
  type = map(string)
  default = {
    "env" = "Dev"
    "createdby" = "tf"
  }
}

variable "sg" {
  type = list(object({
    fromport = number
    toport = number
    protocol = string
    cidr = list(string)
  }))
  default = [ {
    fromport = 80
    toport = 80
    protocol = "http"
    cidr = [ "0.0.0.0/0" ]
  },
    {
    fromport = 443
    toport = 443
    protocol = "https"
    cidr = [ "0.0.0.0/0" ]
  }]
}