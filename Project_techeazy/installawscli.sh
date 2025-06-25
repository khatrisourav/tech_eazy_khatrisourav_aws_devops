#!/bin/bash
set -e

os_name=$(grep "^ID=" /etc/os-release | cut -d= -f2 | tr -d '"')

case "$os_name" in 
  ubuntu|debian)
    apt update -y
    apt install -y openjdk-21-jdk git

    echo 'export JAVA_HOME=/usr/lib/jvm/java-21-openjdk-amd64' >> /etc/profile
    echo 'export PATH=$JAVA_HOME/bin:$PATH' >> /etc/profile
    source /etc/profile

    java -version > /home/ubuntu/java_check.txt 2>&1

    git clone https://github.com/techeazy-consulting/techeazy-devops /home/ubuntu/techeazy-devops
    chown -R ubuntu:ubuntu /home/ubuntu/techeazy-devops

    cd /home/ubuntu/techeazy-devops
    chmod +x mvnw

   sudo  nohup ./mvnw spring-boot:run -Dspring-boot.run.arguments=--server.port=80 > /home/ubuntu/spring.log 2>&1 &
 #  sudo shutdown -h +6
    ;;
    
     amzn|amazon)
    yum update -y
    yum install -y java-21-amazon-corretto-devel git

    echo 'export JAVA_HOME=/usr/lib/jvm/java-21-amazon-corretto' >> /etc/profile
    echo 'export PATH=$JAVA_HOME/bin:$PATH' >> /etc/profile
    source /etc/profile

    java -version > /home/ec2-user/java_check.txt 2>&1

    git clone https://github.com/techeazy-consulting/techeazy-devops /home/ec2-user/techeazy-devops
    chown -R ec2-user:ec2-user /home/ec2-user/techeazy-devops

    cd /home/ec2-user/techeazy-devops
    chmod +x mvnw

    sudo nohup ./mvnw spring-boot:run -Dspring-boot.run.arguments=--server.port=80 > /home/ec2-user/spring.log 2>&1 &
    # sudo shutdown -h +6
    ;;

  rhel|centos|fedora)
    dnf install -y java-21-openjdk-devel git || yum install -y java-21-openjdk-devel git

    echo 'export JAVA_HOME=/usr/lib/jvm/java-21-openjdk' >> /etc/profile
    echo 'export PATH=$JAVA_HOME/bin:$PATH' >> /etc/profile
    source /etc/profile

    java -version > /home/ec2-user/java_check.txt 2>&1

    git clone https://github.com/techeazy-consulting/techeazy-devops /home/ec2-user/techeazy-devops
    chown -R ec2-user:ec2-user /home/ec2-user/techeazy-devops

    cd /home/ec2-user/techeazy-devops
    chmod +x mvnw

 sudo    nohup ./mvnw spring-boot:run -Dspring-boot.run.arguments=--server.port=80 > /home/ec2-user/spring.log 2>&1 &
  sudo shutdown -h +6
    ;;
    

  *)
    echo "Unknown OS" >> /tmp/error_os.txt
    ;;
esac


 
















# === AWS CLI v2 Installer with OS Detection using switch ===

# Function to download and install AWS CLI
install_aws_cli() {
  echo "➡ Downloading AWS CLI v2..."
  curl "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" -o "awscliv2.zip"

  echo "➡ Unzipping AWS CLI..."
  unzip awscliv2.zip

  echo "➡ Installing AWS CLI..."
  sudo ./aws/install

  echo "➡ Cleaning up..."
  rm -rf aws awscliv2.zip

  if command -v aws >/dev/null 2>&1; then
    echo "✅ AWS CLI installed successfully:"
    aws --version
  else
    echo "❌ AWS CLI installation failed."
    exit 1
  fi
}

# Detect OS
if [ -f /etc/os-release ]; then
  . /etc/os-release
  OS_ID=$ID
else
  echo "❌ Unable to detect OS."
  exit 1
fi

# Act based on OS
case "$OS_ID" in
  ubuntu|debian)
    echo "🟦 Detected Ubuntu/Debian"
    sudo apt update -y && sudo apt install -y unzip curl
    install_aws_cli
    ;;

  amzn|amazon)
    echo "🟩 Detected Amazon Linux"
    sudo yum update -y && sudo yum install -y unzip curl
    install_aws_cli
    ;;

  rhel|centos|fedora)
    echo "🟥 Detected RHEL/CentOS/Fedora"
    sudo yum update -y && sudo yum install -y unzip curl
    install_aws_cli
    ;;

  *)
    echo "❌ Unsupported OS: $OS_ID"
    exit 2
    ;;
esac

sudo aws s3 cp /var/log/cloud-init.log s3://my-secure-devops-bucket-2025/ec2-logs/$(hostname)-cloud-init.log

currentdir=$(pwd)
sudo aws s3 cp  $currentdir/spring.log s3://my-secure-devops-bucket-2025/app/apphistory.log







