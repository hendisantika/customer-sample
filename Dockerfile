FROM amazoncorretto:25

WORKDIR /app

COPY target/*.jar app.jar

EXPOSE 9003

ENTRYPOINT ["java", "-jar", "app.jar"]
