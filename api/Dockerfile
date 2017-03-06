FROM tomcat:7-alpine

# webapi deployment section

RUN mkdir -p /data/webapi/config

COPY api.war $CATALINA_HOME/webapps/

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