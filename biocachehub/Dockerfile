FROM tomcat:7-alpine

#biocache-hub role or the generic-hub app deployment section

RUN mkdir -m 0774 -p \
	/data/generic-hub/config \
    /data/generic-hub/cache

COPY biocache-hub-files/config/generic-hub-config.properties /data/generic-hub/config/generic-hub-config.properties
COPY biocache-hub-files/config/*.json /data/generic-hub/config/
COPY generic-hub.war $CATALINA_HOME/webapps/

RUN apk add --update tini
ENTRYPOINT ["tini", "--"]
CMD ["catalina.sh", "run"]