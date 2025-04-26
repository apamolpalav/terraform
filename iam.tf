# Create an IAM role for EC2
resource "aws_iam_role" "ec2_role" {
  count = var.is_s3_bucket_needed ? 1 : 0
  name  = "${var.env_prefix}-ec2-role"
  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = "sts:AssumeRole"
        Effect = "Allow"
        Principal = {
          Service = "ec2.amazonaws.com"
        }
      }
    ]
  })
}

# Create an IAM policy to allow S3 access
resource "aws_iam_policy" "s3_access_policy" {
  count       = var.is_s3_bucket_needed ? 1 : 0
  name        = "${var.env_prefix}-s3-access-policy"
  description = "A policy to allow access to S3 bucket"

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect = "Allow"
        Action = "s3:*"
        Resource = "*"
      }
    ]
  })
}

# Attach the policy to the role
resource "aws_iam_role_policy_attachment" "attach_policy" {
  count      = var.is_s3_bucket_needed ? 1 : 0
  role       = aws_iam_role.ec2_role[0].name
  policy_arn = aws_iam_policy.s3_access_policy[0].arn
}


resource "aws_iam_instance_profile" "ec2_instance_profile" {
  name = "ec2_s3_access_profile"  # Name for the instance profile
  role = aws_iam_role.ec2_role[0].name
}