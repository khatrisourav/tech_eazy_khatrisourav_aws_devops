variable "bucket_name" {
  description = "Name of the private S3 bucket"
  type        = string

  validation {
    condition     = length(var.bucket_name) > 0
    error_message = "bucket_name must not be empty"
  }
}

variable "region" {
  description = "AWS region to deploy resources"
  type        = string
  default     = "ap-south-1"
}

variable "instance_type" {
  description = "EC2 instance type"
  type        = string
  default     = "t2.micro"
}

variable "key_name" {
  description = "Key pair name for EC2 login"
  type        = string
}

variable ami_id {
description ="Instance id "
}
variable "stage" {
  description = "The environment stage (e.g. dev, prod)"
  type        = string
}


