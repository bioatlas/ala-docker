FROM tomcat:7-jre8-alpine

RUN rm -r ${CATALINA_HOME}/webapps/ROOT \
    && rm -r ${CATALINA_HOME}/webapps/docs \
    && rm -r ${CATALINA_HOME}/webapps/examples \
    && rm -r ${CATALINA_HOME}/webapps/host-manager \
    && rm -r ${CATALINA_HOME}/webapps/manager

RUN mkdir -m 0774 -p \
	/data/ala-hub/config \
	/data/ala-hub/cache \
	/data/ala-hub/download \
	/data/ala-hub/geolite_db

COPY biocache-hub-files/config/*.json /data/ala-hub/config/

RUN mkdir -p $CATALINA_HOME/webapps-ala
COPY ala-hub.war $CATALINA_HOME/webapps-ala/
COPY context.xml /usr/local/tomcat/conf/Catalina/localhost/ROOT.xml
COPY context.xml /tmp/context.xml
COPY server.xml $CATALINA_HOME/conf/server.xml

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

RUN apk add --update tini
ENTRYPOINT ["tini", "--"]
CMD ["catalina.sh", "run"]
