# ===============================
# Stage 1: Build with Maven
# ===============================
FROM maven:3.9.9-eclipse-temurin-17 AS build
WORKDIR /app

# Copy the pom.xml and download dependencies first (for caching)
COPY pom.xml .
RUN mvn dependency:go-offline -B

# Copy the entire project and build WAR
COPY . .
RUN mvn clean package -DskipTests

# ===============================
# Stage 2: Run with Tomcat 9
# ===============================
FROM tomcat:9.0-jdk17-temurin
WORKDIR /usr/local/tomcat

# Clean default ROOT app and deploy our WAR
RUN rm -rf webapps/ROOT
COPY --from=build /app/target/bazaaru.war webapps/ROOT.war

EXPOSE 8080
CMD ["catalina.sh", "run"]
