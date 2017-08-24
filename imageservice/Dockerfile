FROM tomcat:7-alpine

RUN apk --update add apache2

# service deployment section
RUN mkdir -p /data \
	/data/images \
	/data/images/config \
    /data/images/elasticsearch \
    /data/images/store \
    /data/images/incoming \
    /data/images/bin/imgcnv

#VOLUME /data/images/store

#COPY images-config.properties /data/images/config/
COPY images.war $CATALINA_HOME/webapps/

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