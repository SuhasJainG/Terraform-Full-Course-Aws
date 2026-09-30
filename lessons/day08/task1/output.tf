output "bucket_ids1" {
  value = {
    for k, v in aws_s3_bucket.tf_test_baivab_bucket1 : k => v.id
  }
}

output "bucket_ids" {
  value = [for bucket in aws_s3_bucket.tf_test_baivab_bucket : bucket.id]
}