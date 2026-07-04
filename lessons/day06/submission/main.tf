resource "aws_s3_bucket" "tf_test_baivab_bucket" {
  bucket = local.bucketname

  tags = {
    Name        = local.bucketname
    Environment = var.Environment
  }
}

resource "aws_instance" "name" {
  ami = var.ami
  region = var.region
  instance_type = "t2.micro"

  tags = {
    Name = local.instance_name
  }
}