FROM tomcat:8-alpine

#biocache-hub role or the ala-hub app deployment section

RUN mkdir -m 0774 -p \
	/data/ala-hub/config \
    /data/ala-hub/cache

#COPY biocache-hub-files/config/generic-hub-config.properties /data/ala-hub/config/generic-hub-config.properties
COPY biocache-hub-files/config/*.json /data/ala-hub/config/
COPY generic-hub.war $CATALINA_HOME/webapps/

RUN apk add --update tini
ENTRYPOINT ["tini", "--"]
CMD ["catalina.sh", "run"]