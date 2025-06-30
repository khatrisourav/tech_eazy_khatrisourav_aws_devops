#!/bin/bash
set -e

cd /home/ubuntu/techeazy-devops

# Run the Spring Boot app on port 80
sudo nohup ./mvnw spring-boot:run -Dspring-boot.run.arguments=--server.port=80 > /home/ubuntu/spring.log 2>&1 &

