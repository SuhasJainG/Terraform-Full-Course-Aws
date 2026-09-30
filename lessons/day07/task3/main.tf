resource "aws_default_subnet" "default_az1" {
  availability_zone = var.az

  tags = {
    Name = "Default subnet"
  }
}

resource "aws_instance" "name" {
  count = var.instance_count
  instance_type = var.type
  subnet_id = aws_default_subnet.default_az1.id
  ami           = "resolve:ssm:/aws/service/ami-amazon-linux-latest/al2023-ami-kernel-default-x86_64"
  monitoring = var.monitoring
  associate_public_ip_address = var.associate_public_ip_address
  tags = {
    name = local.instancename
  }
}

