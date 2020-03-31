FROM tomcat:7-jre8-alpine

RUN apk --update add apache2

RUN rm -r ${CATALINA_HOME}/webapps/ROOT \
    && rm -r ${CATALINA_HOME}/webapps/docs \
    && rm -r ${CATALINA_HOME}/webapps/examples \
    && rm -r ${CATALINA_HOME}/webapps/host-manager \
    && rm -r ${CATALINA_HOME}/webapps/manager

# service deployment section
RUN mkdir -p /data \
  /data/image-service/config \
  /data/image-service/store \
  /data/image-service/incoming \
  /data/image-service/bin/imgcnv

RUN chmod +rw /data/image-service/store

RUN mkdir -p $CATALINA_HOME/webapps-ala
COPY images.war $CATALINA_HOME/webapps-ala/
COPY context.xml /usr/local/tomcat/conf/Catalina/localhost/ROOT.xml
COPY context.xml /tmp/context.xml

ENV \
    BUILD_DEPS="gettext" \
    RUNTIME_DEPS="libintl" \
    TOMCAT_CONTEXT_NAME="ROOT" \
    TOMCAT_CONTEXT_PATH=""

RUN \
    apk add --update $RUNTIME_DEPS && \
    apk add --virtual build_deps $BUILD_DEPS &&  \
    cp /usr/bin/envsubst /usr/local/bin/envsubst && \
    apk del build_deps

RUN apk add --no-cache ca-certificates wget
RUN wget --quiet --output-document=/etc/apk/keys/sgerrand.rsa.pub https://alpine-pkgs.sgerrand.com/sgerrand.rsa.pub
RUN wget https://github.com/sgerrand/alpine-pkg-java-openjfx/releases/download/8.151.12-r0/java-openjfx-8.151.12-r0.apk
RUN apk add --no-cache java-openjfx-8.151.12-r0.apk
RUN apk add --update tini
ENTRYPOINT ["tini", "--"]
CMD ["catalina.sh", "run"]
