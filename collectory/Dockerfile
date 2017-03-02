FROM tomcat:7-alpine

# collectory deployment section

RUN mkdir -p /data \
	/data/generic-collectory \
	/data/generic-collectory/upload/tmp \
	/data/generic-collectory/taxa/data

COPY generic-collectory-data/generic-collectory/config/connection-profiles.json \
	/data/generic-collectory/config/

COPY generic-collectory-data/generic-collectory/data\
	/data/generic-collectory/data

COPY collectory.war $CATALINA_HOME/webapps/

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