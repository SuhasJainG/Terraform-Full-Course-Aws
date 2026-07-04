output "instance_name" {
  value = aws_instance.name.id
}

output "bucket_arn" {
  value = aws_s3_bucket.tf_test_baivab_bucket.arn
}