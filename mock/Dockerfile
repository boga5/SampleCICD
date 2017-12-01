FROM openjdk:8-jre-alpine
MAINTAINER Tho Nguyen <thonguyen@fortna.com>
ENV PORT=

RUN apk add --no-cache curl
RUN apk add --update bash && rm -rf /var/cache/apk/*

VOLUME /logs
VOLUME /mock_mapping

RUN curl "http://central.maven.org/maven2/com/github/tomakehurst/wiremock-standalone/2.10.1/wiremock-standalone-2.10.1.jar" --output wiremock-standalone.jar
# ADD wiremock-standalone-2.10.1.jar wiremock-standalone.jar
RUN sh -c 'touch /wiremock-standalone.jar'

ENV JAVA_OPTS=""
ENTRYPOINT [ "java","-jar","/wiremock-standalone.jar","--port=6300", "--root-dir=/mock_mapping", "--global-response-templating" ]
