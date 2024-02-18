# Project 06

## Overview
**Git ---> Gitlab ---> sv1:Jenkins (avec Jenkinsfile) ---> sv2:Docker : projet j2e**

## RHEL install docker
sudo yum install -y yum-utils
sudo yum-config-manager --add-repo https://download.docker.com/linux/centos/docker-ce.repo
sudo yum install docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin
sudo systemctl start docker
sudo docker run hello-world
