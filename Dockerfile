# Use the official Maven image to build the application
FROM maven:3.8.4-openjdk-17 AS builder

# Set the working directory
WORKDIR /app

# Copy only the pom.xml file to cache dependencies
COPY pom.xml .

# Download dependencies
RUN mvn dependency:go-offline -B

# Copy the rest of the application source code
COPY src ./src

# Build the application
RUN mvn package

# Use AdoptOpenJDK as the base image
FROM adoptopenjdk:17-jre-hotspot

# Set the working directory
WORKDIR /app

# Copy the JAR file from the builder stage
COPY --from=builder /app/target/*.jar app.jar

# Expose the port that your Spring Boot application listens on
EXPOSE 8080

# Specify the command to run your application
CMD ["java", "-jar", "app.jar"]
