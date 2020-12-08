FROM tomcat:7-jre8-alpine

RUN mkdir -p /data/userdetails/config

COPY userdetails.war $CATALINA_HOME/webapps/userdetails.war

ENV \
	BUILD_DEPS="gettext" \
	RUNTIME_DEPS="libintl"

RUN \
    apk add --update $RUNTIME_DEPS && \
    apk add --virtual build_deps $BUILD_DEPS &&  \
    cp /usr/bin/envsubst /usr/local/bin/envsubst && \
    apk del build_deps

RUN apk add --update fontconfig ttf-dejavu

RUN apk add --update tini
ENTRYPOINT ["tini", "--"]
CMD ["catalina.sh", "run"]
