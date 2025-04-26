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

variable "ami" {
  type = string
}

variable "instance_count" {
  description = "EC2 instance count"
  type        = number
}

variable "instance_type" {
  description = "Instance type t2.micro"
  type        = string
}

variable "source_script" {
  type = string
}

variable "destination_script" {
  type = string
}

variable "ec2_user" {
  type = string
}

variable "private_key" {
  type = string
}

variable "public_key" {
  type = string
}