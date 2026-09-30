resource "aws_vpc" "main" {
  cidr_block = var.cidr[0]
}

resource "aws_subnet" "name" {
  vpc_id = aws_vpc.main.id
  cidr_block = var.cidr[1]
}

resource "aws_subnet" "name1" {
  vpc_id = aws_vpc.main.id
  cidr_block = var.cidr[2]
}
