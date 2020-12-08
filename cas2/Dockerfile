FROM tomcat:7-jre8-alpine

RUN mkdir -p /data/cas/config

COPY log4j.xml /data/cas/config/log4j.xml
COPY cas.war $CATALINA_HOME/webapps/cas.war
COPY server.xml $CATALINA_HOME/conf/server.xml

ENV \
	BUILD_DEPS="gettext" \
	RUNTIME_DEPS="libintl"

RUN \
    apk add --update $RUNTIME_DEPS && \
    apk add --virtual build_deps $BUILD_DEPS &&  \
    cp /usr/bin/envsubst /usr/local/bin/envsubst && \
    apk del build_deps

RUN apk add --update tini
ENTRYPOINT ["tini", "--"]
CMD ["catalina.sh", "run"]
