# Java Application Deployment on EC2 using Terraform

## Description
This Terraform setup launches an EC2 instance with a security group that allows SSH (port 22) and HTTP (port 80). The instance is provisioned using `user_data` via `java.sh`, which installs Java, compiles and runs a Java app, and serves the output via Apache. It automatically shuts down after 5 minutes.

## Files
- **main.tf**: AWS resources like EC2 and security group.
- **variables.tf**: AMI ID, instance type, and key name as inputs. you can use for change this 
- **java.sh**: Shell script to install Java and deploy app.


## Usage
2. Run:
```bash
terraform init
terraform apply
