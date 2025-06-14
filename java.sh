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
    ;;

  *)
    echo "Unknown OS" >> /tmp/error_os.txt
    ;;
esac

