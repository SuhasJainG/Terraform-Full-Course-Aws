data "aws_vpc" "name" {
  filter {
    name = "tag:Name"
    values = [ "Default" ]
  }
}

data "aws_subnet" "name" {
  filter {
    name = "tag:Name"
    values = [ "Default" ]
  }
  vpc_id = data.aws_vpc.name.id
}

data "aws_ami" "name" {
  most_recent = true
  name_regex = "Amazon Linux 2023*"
  owners = ["amazon"]
  filter {
    name   = "architecture"
    values = ["x86_64"]
  }
}