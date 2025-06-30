# === EC2 Outputs ===

output "ec2_public_ip" {
  description = "The public IP of the EC2 instance"
  value       = aws_instance.writeonly_ec2appdeploy.public_ip
}

output "ec2_private_ip" {
  description = "The private IP of the EC2 instance"
  value       = aws_instance.writeonly_ec2appdeploy.private_ip
}

output "ec2_instance_id" {
  description = "The ID of the EC2 instance"
  value       = aws_instance.writeonly_ec2appdeploy.id
}


# === IAM Role & Instance Profile Outputs ===

output "iam_role_name" {
  description = "The name of the IAM role for write-only S3 access"
  value       = aws_iam_role.s3_writeonly_role.name
}

output "iam_instance_profile_name" {
  description = "The name of the EC2 instance profile"
  value       = aws_iam_instance_profile.writeonly_instance_profile.name
}


# === S3 Bucket Output ===

output "bucket_name" {
  description = "The name of the private S3 bucket"
  value       = aws_s3_bucket.private_bucket.id
}


# === Security Group Output ===

output "security_group_id" {
  description = "The ID of the EC2 security group"
  value       = aws_security_group.ec2_sg.id
}

