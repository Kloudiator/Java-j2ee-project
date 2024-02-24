# Project 06

## Overview
**Git ---> Gitlab ---> sv1:Jenkins (avec Jenkinsfile) ---> sv2:Docker : projet j2e**

## RHEL install docker
sudo yum install -y yum-utils
sudo yum-config-manager --add-repo https://download.docker.com/linux/centos/docker-ce.repo
sudo yum install docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin
sudo systemctl start docker
sudo docker run hello-world

## Dockerfile
# Use the official Tomcat image as the base image
FROM tomcat:latest
# Copy the WAR file into the webapps directory of Tomcat
COPY path/to/your/application.war /usr/local/tomcat/webapps/
# Expose the default Tomcat port
EXPOSE 8080
# Start Tomcat when the container starts
CMD ["catalina.sh", "run"]

## Add stage
# Copy Dockerfile to rhel instance
sh 'sudo scp Dockerfile ec2-user@172.31.6.109:/home/ec2-user'
# Copy webapp.war to rhel instance
sh 'sudo scp webapp/target/webapp.war ec2-user@172.31.6.109:/home/ec2-user'
# Build Docker image
sh 'sudo ssh ec2-user@172.31.6.109 \"sudo docker image build -t tomcatp06-img .\"'
#  Run container
sh 'sudo ssh ec2-user@172.31.6.109 \"sudo docker container run --name tomcatp06-container --rm -p 8080:8080 -d tomcatp06-img\"'
