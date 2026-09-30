resource "aws_instance" "example" {
  ami           = data.aws_ami.name.id
  instance_type =  "t2.micro"
  subnet_id = data.aws_subnet.name.id
  tags = var.tags
}
