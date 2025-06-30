provider "aws" {

region = var.region
}

resource "aws_iam_role" "s3_readonly_role" {

name = "S3ReadOnlyRole"
assume_role_policy = jsonencode({

 Version = "2012-10-17"
 Statement = [
 {
 
 Effect = "Allow"
 Principal = {
 Service = "ec2.amazonaws.com"
 
 }
 
  Action = "sts:AssumeRole"
 
 }
 
 ]


})

}

resource "aws_iam_role_policy_attachment" "s3_readonly_policy_attach" {
  role       = aws_iam_role.s3_readonly_role.name
  policy_arn = "arn:aws:iam::aws:policy/AmazonS3ReadOnlyAccess"
}


resource "aws_iam_role"  "s3_writeonly_role"{
name = "WriteonlyRole"

assume_role_policy = jsonencode({

 Version = "2012-10-17"
 Statement = [
 {
 
 Effect = "Allow"
 Principal = {
 Service = "ec2.amazonaws.com"
 
 }
 
  Action = "sts:AssumeRole"
 
 }
 
 ]


})

}


resource "aws_iam_policy" "s3_writeonly_policy1" {
  name        = "S3WriteOnlyPolicy1"
  description = "Can create bucket and upload files but cannot read/list"

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect   = "Allow"
        Action   = [
          "s3:PutObject",
          "s3:CreateBucket"
        ]
        Resource = "*"
      },
      {
        Effect   = "Deny"
        Action   = [
          "s3:GetObject",
          "s3:ListBucket"
        ]
        Resource = "*"
      }
    ]
  })
}

resource "aws_iam_role_policy_attachment" "s3_writeonly_policy_attach" {
  role       = aws_iam_role.s3_writeonly_role.name
  policy_arn = aws_iam_policy.s3_writeonly_policy1.arn
}


resource "aws_iam_instance_profile" "writeonly_instance_profile" {
  name = "WriteOnlyEC2Profile"
  role = aws_iam_role.s3_writeonly_role.name
}




resource "aws_security_group" "ec2_sg" {
  name        = "allow_ssh_http"
  description = "Allow SSH and HTTP inbound traffic and all outbound traffic"

  ingress {
    description = "Allow SSH"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    description = "Allow HTTP"
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    description = "Allow all outbound"
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "ec2_sg"
  }
}

resource "aws_instance" "writeonly_ec2appdeploy" {
  ami                    = var.ami_id
  instance_type          = var.instance_type
  vpc_security_group_ids = [aws_security_group.ec2_sg.id]
  key_name               = var.key_name
  iam_instance_profile   = aws_iam_instance_profile.writeonly_instance_profile.name

  tags = {
    Name = "MyEC2Instanceubuntu"
  }

  lifecycle {
    create_before_destroy = true
  }
}




# Create the bucket
resource "aws_s3_bucket" "private_bucket" {
  bucket = var.bucket_name

  tags = {
    Name = var.bucket_name
  }
}
resource "aws_s3_bucket_public_access_block" "block_public_access" {
  bucket = aws_s3_bucket.private_bucket.id

  block_public_acls       = true
  block_public_policy     = true
  ignore_public_acls      = true
  restrict_public_buckets = true
}




