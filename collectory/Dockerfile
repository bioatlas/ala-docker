FROM tomcat:7-jre8-alpine

# collectory deployment section

RUN mkdir -p /data \
	/data/ala-collectory \
	/data/ala-collectory/upload/tmp \
	/data/ala-collectory/taxa/data

COPY ala-collectory-data/ala-collectory/config/* \
	/data/ala-collectory/config/

COPY ala-collectory-data/ala-collectory/data \
	/data/ala-collectory/data

COPY collectory.war $CATALINA_HOME/webapps/
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
