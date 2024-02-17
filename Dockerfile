FROM maven:3.9.4-eclipse-temurin-17 as build

COPY src src
COPY pom.xml pom.xml
RUN mvn clean package


FROM bellsoft/liberica-openjdk-debian:17

RUN adduser --system spring-boot && \
addgroup --system spring-boot && \
adduser spring-boot spring-boot

USER spring-boot

WORKDIR /app

COPY --from=build target/greetins-maven-docker-1.0-SNAPSHOT.jar ./application.jar

ENTRYPOINT ["java", "-jar", "./application.jar"]

