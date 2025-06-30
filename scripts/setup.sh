#!/bin/bash
set -e
#---Only for ubuntu machine 
# Install dependencies
sudo apt update -y
sudo apt install -y openjdk-21-jdk git unzip curl

# Set environment variables
echo 'export JAVA_HOME=/usr/lib/jvm/java-21-openjdk-amd64' | sudo tee -a /etc/profile
echo 'export PATH=$JAVA_HOME/bin:$PATH' | sudo tee -a /etc/profile
source /etc/profile

# Java check
java -version > /home/ubuntu/java_check.txt 2>&1

# Clone the application repo
git clone https://github.com/techeazy-consulting/techeazy-devops /home/ubuntu/techeazy-devops
sudo chown -R ubuntu:ubuntu /home/ubuntu/techeazy-devops

# Make Maven wrapper executable
chmod +x /home/ubuntu/techeazy-devops/mvnw

