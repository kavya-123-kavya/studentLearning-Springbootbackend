# Step 1: Build the application using Maven
FROM maven:3.9.4-eclipse-temurin-17 AS builder

WORKDIR /app
COPY . .
RUN mvn clean package -DskipTests

# Step 2: Run the app using a smaller JDK image
FROM openjdk:17-jdk-slim
WORKDIR /app

# Copy only the jar from the builder stage
COPY --from=builder /app/target/*.jar app.jar

CMD ["java", "-jar", "app.jar"]
