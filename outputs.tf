
output "practice_ec2_public_ips" {
  value = ["${aws_instance.practice_ec2.*.public_ip}"]
}

output "s3_bucket_name" {
  value = aws_s3_bucket.ec2_bucket[*].bucket
}
