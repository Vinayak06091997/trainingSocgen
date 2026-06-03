# Build stage for the Java backend
FROM maven:3.9.8-eclipse-temurin-17 AS build
WORKDIR /app
COPY pom.xml .
COPY src ./src
RUN mvn -B package -DskipTests

# Runtime stage with a portable JRE image for Docker Desktop platforms
FROM eclipse-temurin:17-jre
WORKDIR /app
COPY --from=build /app/target/java-backend-1.0-SNAPSHOT.jar /app/app.jar
EXPOSE 8081
CMD ["java", "-jar", "/app/app.jar"]
