variable "aws_region" {
  default = "ap-south-1"
}

variable "ami_id" {
  default = "ami-0038df39db13a87e2" # Example: Ubuntu 22.04 in ap-south-1
}

variable "instance_type" {
  default = "t2.micro"
}
