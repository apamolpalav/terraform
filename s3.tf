# Create an S3 bucket
resource "aws_s3_bucket" "ec2_bucket" {
  count         = var.is_s3_bucket_needed ? 1 : 0
  bucket        = "${var.env_prefix}-${var.s3_ec2_bucket_name}" # Change to a unique bucket name
  acl           = "private"
  force_destroy = true
}
