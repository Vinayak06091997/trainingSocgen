# Build stage: compile Java source code with the JDK image
FROM eclipse-temurin:17-jdk-alpine AS build

WORKDIR /app

# Copy source files into the build context
COPY src ./src

# Compile the Java web server into the out directory
RUN mkdir -p out && javac src/main/java/com/example/web/WebServer.java -d out

# Runtime stage: use the smaller JRE image for the final container
FROM eclipse-temurin:17-jre-alpine
WORKDIR /app

# Copy the compiled classes from the build stage
COPY --from=build /app/out ./out

# Expose the port the server listens on
EXPOSE 8080

# Run the web server from the compiled classes
CMD ["java", "-cp", "out", "com.example.web.WebServer"]