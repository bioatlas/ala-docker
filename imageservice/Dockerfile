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

VOLUME /data/images/store

COPY images-config.properties /data/images/config/
COPY images.war $CATALINA_HOME/webapps/

RUN apk add --update tini
ENTRYPOINT ["tini", "--"]
CMD ["catalina.sh", "run"]