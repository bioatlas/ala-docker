FROM tomcat:8-jre8-alpine

# webapi deployment section

RUN mkdir -p /data/webapi/config

RUN rm -r ${CATALINA_HOME}/webapps/ROOT \
    && rm -r ${CATALINA_HOME}/webapps/docs \
    && rm -r ${CATALINA_HOME}/webapps/examples \
    && rm -r ${CATALINA_HOME}/webapps/host-manager \
    && rm -r ${CATALINA_HOME}/webapps/manager

COPY api.war $CATALINA_HOME/webapps/ROOT.war

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
