FROM adoptopenjdk:11-jre-hotspot

WORKDIR /app

COPY build/libs/*.jar app.jar
COPY  . .

EXPOSE 8081

CMD ["java", "-jar", "app.jar"]
