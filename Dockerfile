# Use Tomcat 9 with JDK 17
FROM tomcat:9-jdk17

# Remove default ROOT app
RUN rm -rf /usr/local/tomcat/webapps/ROOT

# Copy your project WAR to Tomcat
COPY target/*.war /usr/local/tomcat/webapps/ROOT.war

# Expose port
EXPOSE 8080

# Start Tomcat
CMD ["catalina.sh", "run"]
