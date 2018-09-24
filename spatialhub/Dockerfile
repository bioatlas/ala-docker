FROM tomcat:7-jre8-alpine

RUN mkdir -p /data/spatial-hub/config \
  /data/ala/runtime/files
COPY log4j.properties /data/spatial-hub/config/log4j.properties
COPY spatial-hub.war $CATALINA_HOME/webapps/spatial-hub.war

ENV \
	BUILD_DEPS="gettext" \
	RUNTIME_DEPS="libintl"

RUN \
    apk add --update $RUNTIME_DEPS && \
    apk add --virtual build_deps $BUILD_DEPS &&  \
    cp /usr/bin/envsubst /usr/local/bin/envsubst && \
    apk del build_deps

RUN apk add --update tini

VOLUME /data/ala/runtime/files

ENTRYPOINT ["tini", "--"]
CMD ["catalina.sh", "run"]
