FROM amazoncorretto:21
WORKDIR /app
COPY target/employee-app-4.0.0.jar app.jar
CMD ["java", "-jar", "app.jar"]