FROM tomcat:8-alpine

RUN mkdir -p /data/specieslist-webapp/config

COPY specieslist-webapp.war $CATALINA_HOME/webapps/specieslists.war

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
