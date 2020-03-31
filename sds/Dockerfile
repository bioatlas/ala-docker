FROM tomcat:8-jre8-alpine

RUN rm -r ${CATALINA_HOME}/webapps/ROOT \
    && rm -r ${CATALINA_HOME}/webapps/docs \
    && rm -r ${CATALINA_HOME}/webapps/examples \
    && rm -r ${CATALINA_HOME}/webapps/host-manager \
    && rm -r ${CATALINA_HOME}/webapps/manager

RUN mkdir -p /data/sds/config \
  /data/sds/data \
  /data/lucene/namematching

COPY sds-webapp.war $CATALINA_HOME/webapps/ROOT.war

COPY sds-files/sensitivity-categories.xml /data/sds/sensitivity-categories.xml
COPY sds-files/sensitivity-zones.xml /data/sds/sensitivity-zones.xml
COPY sds-files/sensitive-species.xml /data/sds/sensitive-species.xml

ENV \
    BUILD_DEPS="gettext" \
    RUNTIME_DEPS="libintl"

RUN \
    apk add --update $RUNTIME_DEPS && \
    apk add --virtual build_deps $BUILD_DEPS &&  \
    apk del build_deps


RUN apk add --update tini
ENTRYPOINT ["tini", "--"]
CMD ["catalina.sh", "run"]
