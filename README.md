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
sh "sudo scp -i $SSH_KEY Dockerfile ${sshUser}@${remoteServer}:/tmp"
# Copy webapp.war to rhel instance
sh 'sudo scp -i $SSH_KEY webapp/target/webapp.war ${sshUser}@${remoteServer}:/tmp'
# Build Docker image
sh 'sudo ssh ${sshUser}@${remoteServer}:/tmp \"sudo docker image build -t tomcatp06-img .\"'
#  Run container
sh 'sudo ssh ${sshUser}@${remoteServer}:/tmp \"sudo docker container run --name tomcatp06-container --rm -p 8080:8080 -d tomcatp06-img\"'
