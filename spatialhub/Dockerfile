FROM tomcat:8-jre8-alpine

RUN rm -r ${CATALINA_HOME}/webapps/ROOT \
    && rm -r ${CATALINA_HOME}/webapps/docs \
    && rm -r ${CATALINA_HOME}/webapps/examples \
    && rm -r ${CATALINA_HOME}/webapps/host-manager \
    && rm -r ${CATALINA_HOME}/webapps/manager

RUN mkdir -p /data/spatial-hub/config \
  /data/spatial-hub/i18n \
  /data/ala/runtime/files

COPY log4j.properties /data/spatial-hub/config/log4j.properties
COPY spatial-hub.war $CATALINA_HOME/webapps/ROOT.war
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

VOLUME /data/ala/runtime/files

ENTRYPOINT ["tini", "--"]
CMD ["catalina.sh", "run"]
