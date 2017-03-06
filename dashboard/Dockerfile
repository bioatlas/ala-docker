FROM tomcat:7-alpine

# dashboard deployment section

RUN mkdir -p /data \
	/data/dashboard \
	/data/dashboard/config

#COPY data.json /data/dashboard/

COPY dashboard.war $CATALINA_HOME/webapps/

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