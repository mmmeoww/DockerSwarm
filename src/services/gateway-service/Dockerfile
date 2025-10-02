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

ENTRYPOINT ["./wait-for-it.sh", "session:8081", "-t", "30", "--", \
            "./wait-for-it.sh", "hotel:8082", "-t", "30", "--", \
            "./wait-for-it.sh", "booking:8083", "-t", "30", "--", \
            "./wait-for-it.sh", "payment:8084", "-t", "30", "--", \
            "./wait-for-it.sh", "loyalty:8085", "-t", "30", "--", \
            "./wait-for-it.sh", "report:8086", "-t", "30", "--", \
            "java", "-jar", "app.jar"]
