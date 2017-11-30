FROM openjdk:8-jre-alpine
MAINTAINER Tho Nguyen <thonguyen@fortna.com>
VOLUME /tmp
VOLUME /logs
VOLUME /configs
RUN sh -c 'pwd'
RUN sh -c 'ls -la'
ADD libs /libs
ADD sampleproject-0.0.1-SNAPSHOT.jar app.jar
RUN sh -c 'touch /app.jar'
ENV JAVA_OPTS="-Dserver.port=6400"
ENTRYPOINT [ "java","-jar","app.jar" ]
