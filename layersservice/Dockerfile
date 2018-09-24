FROM tomcat:7-jre8-alpine

RUN mkdir -p /data/layers-store/config \
  /data/layers-service/config \
  /data/layers-service/batch_requests \
  /data/ala/data/layers/raw \
  /data/ala/data/layers/ready/shape \
  /data/ala/data/layers/ready/shape_diva \
  /data/ala/data/layers/ready/diva \
  /data/ala/data/layers/analysis/tmp

COPY layers-service.war $CATALINA_HOME/webapps/
VOLUME /data

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
