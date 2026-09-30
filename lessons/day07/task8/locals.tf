locals {
  name_prefix = "${var.Environment}"
  bucketname = "suhas-${local.name_prefix}-${var.region}"
  instancename = "suhas-${local.name_prefix}-${var.region}"
}
