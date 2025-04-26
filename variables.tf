variable "region" {
  type = string
}

variable "access_key" {
  type = string
}

variable "secret_key" {
  type = string
}

variable "env_prefix" {
  type = string
}

variable "key_name" {
  type = string
}

variable "public_key" {
  type = string
}

variable "private_key" {
  type = string
}

variable "ec2_ami" {
  type = string
}

variable "ec2_user" {
  type = string
}

variable "ec2_instance_count" {
  description = "EC2 instance count"
  type        = number
}

variable "ec2_instance_type" {
  type = string
}

variable "ec2_source_script_path" {
  type = string
}

variable "ec2_source_script_name" {
  type = string
}

variable "ec2_destination_script_path" {
  type = string
}

variable "ec2_destination_script_name" {
  type = string
}

variable "ec2_name" {
  type = string
}

variable "db_version" {
  type = number
}

variable "ec2_ssh_syntax" {
  type    = list(string)
  default = ["ssh -i .ssh/aws_key.pem ec2-user@"]
}

variable "s3_ec2_bucket_name" {
  type = string
}

variable "is_s3_bucket_needed" {
  type = bool
}