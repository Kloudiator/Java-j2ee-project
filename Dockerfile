FROM tomcat:latest

COPY /tmp/webapp.war /usr/local/tomcat/webapps/
EXPOSE 8080

CMD ["catalina.sh", "run"]