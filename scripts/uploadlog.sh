#!/bin/bash
set -e

# Install AWS CLI v2
curl "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" -o "awscliv2.zip"
unzip awscliv2.zip
sudo ./aws/install
rm -rf aws awscliv2.zip

# Upload logs to S3 (change bucket name as needed)
aws s3 cp /var/log/cloud-init.log s3://my-secure-devops-bucket-2025/ec2-logs/$(hostname)-cloud-init.log
aws s3 cp /home/ubuntu/spring.log s3://my-secure-devops-bucket-2025/app/apphistory.log

