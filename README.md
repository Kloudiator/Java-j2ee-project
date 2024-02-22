# Project 06

## Overview
**Git ---> Gitlab ---> sv1:Jenkins (avec Jenkinsfile) ---> sv2:Docker : projet j2e**

## RHEL install docker
sudo yum install -y yum-utils
sudo yum-config-manager --add-repo https://download.docker.com/linux/centos/docker-ce.repo
sudo yum install docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin
sudo systemctl start docker
sudo docker run hello-world



# Utilisez l'image de base Tomcat
FROM tomcat:latest

# Copiez le fichier .war dans le répertoire webapps de Tomcat
COPY mon_application.war /usr/local/tomcat/webapps/


docker build -t nom_image:tag .


docker run -d -p 8080:8080 nom_image:tag


http://localhost:8080/mon_application