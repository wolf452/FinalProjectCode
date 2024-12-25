FROM adoptopenjdk:17-jre-hotspot

WORKDIR /app

COPY build/libs/*.jar app.jar

EXPOSE 8081

CMD ["java", "-jar", "app.jar"]
