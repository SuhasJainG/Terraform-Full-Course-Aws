resource "aws_s3_bucket" "tf_test_baivab_bucket" {
  count = length(var.bucketname)
  bucket = var.bucketname[count.index]

  tags = {
    Name        = local.bucketname
    Environment = var.Environment
  }
}

resource "aws_s3_bucket" "tf_test_baivab_bucket1" {
  for_each = var.bucketnameset
  bucket = each.value

  tags = {
    Name        = local.bucketname
    Environment = var.Environment
  }
}
