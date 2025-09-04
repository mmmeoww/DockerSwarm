# build
FROM openjdk:8-jdk-alpine AS build

WORKDIR /app

COPY .mvn ./.mvn
COPY mvnw .
COPY pom.xml .
RUN ./mvnw dependency:go-offline

COPY src ./src
RUN ./mvnw package -DskipTests

#run
FROM openjdk:8-jdk-alpine

WORKDIR /app

COPY --from=build /app/target/*.jar app.jar
COPY wait-for-it.sh .
RUN apk add --no-cache bash && \
    chmod +x wait-for-it.sh
EXPOSE 8087

ENTRYPOINT ["./wait-for-it.sh", "postgres:5432", "-t", "60", "--", "java", "-jar", "app.jar"]