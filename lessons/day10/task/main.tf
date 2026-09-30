resource "aws_instance" "example" {
  count = var.instance_count
  ami           = "resolve:ssm:/aws/service/ami-amazon-linux-latest/al2023-ami-kernel-default-x86_64"
  instance_type = var.Environment == "Dev" ? "t2.micro" : "t3.micro"

  tags = var.tags
}

resource "aws_security_group" "name" {
  name = "sg"

dynamic "ingress" {
  for_each = var.sg
  content {
    from_port = ingress.value.fromport
    to_port = ingress.value.toport
    protocol = ingress.value.protocol
    cidr_blocks = ingress.value.cidr
  }
}
}