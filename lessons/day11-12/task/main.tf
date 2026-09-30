resource "aws_s3_bucket" "storage" {
  bucket = local.formatted_bucket_name

  tags = local.formatted_tags
 }