
FROM maven:3.8.3-openjdk-17 as build

WORKDIR /app

COPY . .

RUN mvn clean package -DskipTests

FROM openjdk:17.0.1-jdk-slim

WORKDIR /app

COPY --from=build /app/target/Librarymgmt-0.0.1-SNAPSHOT.jar app.jar

EXPOSE 8080

ENTRYPOINT ["-jar", "app.jar"]
