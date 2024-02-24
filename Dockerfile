FROM tomcat:latest

COPY /home/ec2-user/webapp.war /usr/local/tomcat/webapps/
EXPOSE 8080

CMD ["catalina.sh", "run"]