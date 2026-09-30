resource "random_id" "name" {
  byte_length = 4
}

locals {
  bucket-prefix        = "${var.project_name}-${var.environment}"
  upload-bucket        = "${local.bucket-prefix}-upload-${random_id.name.hex}"
  processed-bucket     = "${local.bucket-prefix}-processed-${random_id.name.hex}"
  lambda-function-name = "${var.project_name}-${var.environment}-processor"
}