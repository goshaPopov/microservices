FROM java:8-jre
MAINTAINER Georgy Popov <gorge39@gmail.com>

ADD  ./target/auth.jar /app/
CMD ["java", "-Xmx200m", "-jar", "/app/auth.jar"]

EXPOSE 5000