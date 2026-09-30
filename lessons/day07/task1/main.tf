resource "aws_s3_bucket" "tf_test_baivab_bucket" {
  bucket = local.bucketname

  tags = {
    Name        = local.bucketname
    Environment = var.Environment
  }
}
