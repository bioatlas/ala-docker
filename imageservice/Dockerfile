FROM tomcat:7-jre8-alpine

RUN apk --update add apache2

# service deployment section
RUN mkdir -p /data \
	/data/images \
	/data/images/config \
  /data/images/elasticsearch \
  /data/images/store \
  /data/images/incoming \
  /data/images/bin/imgcnv

VOLUME /data/images/store

COPY images.war $CATALINA_HOME/webapps/

ENV \
	BUILD_DEPS="gettext" \
	RUNTIME_DEPS="libintl"

RUN \
    apk add --update $RUNTIME_DEPS && \
    apk add --virtual build_deps $BUILD_DEPS &&  \
    cp /usr/bin/envsubst /usr/local/bin/envsubst && \
    apk del build_deps

RUN apk add --no-cache ca-certificates wget
RUN wget --quiet --output-document=/etc/apk/keys/sgerrand.rsa.pub https://alpine-pkgs.sgerrand.com/sgerrand.rsa.pub
RUN wget https://github.com/sgerrand/alpine-pkg-java-openjfx/releases/download/8.151.12-r0/java-openjfx-8.151.12-r0.apk
RUN apk add --no-cache java-openjfx-8.151.12-r0.apk
RUN apk add --update tini
ENTRYPOINT ["tini", "--"]
CMD ["catalina.sh", "run"]
