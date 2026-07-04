locals {
  bucketname = "suhas-${var.Environment}-${var.region}"
  instance_name = "${var.Environment}-instance"
  vpc_name = "${var.Environment}-vpc"
}