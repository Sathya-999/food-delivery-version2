# Use Maven to build the application
FROM maven:3.9-eclipse-temurin-11 AS build
WORKDIR /app

# Copy pom.xml first for dependency caching
COPY pom.xml .
RUN mvn dependency:go-offline -B

# Copy source code and build
COPY src ./src
RUN mvn clean package -DskipTests

# Use Tomcat 9 as the runtime
FROM tomcat:9.0-jdk11-temurin

# Remove default webapps
RUN rm -rf /usr/local/tomcat/webapps/*

# Copy the WAR file to Tomcat webapps as ROOT
COPY --from=build /app/target/food-delivery-app.war /usr/local/tomcat/webapps/ROOT.war

# Set environment variables (will be overridden by Railway)
ENV JAVA_OPTS="-Xmx512m"

# Expose port (Railway will use PORT env var)
EXPOSE 8080

# Start Tomcat
CMD ["catalina.sh", "run"]
