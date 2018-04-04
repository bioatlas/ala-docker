FROM tomcat:8-alpine

#biocache-hub role or the ala-hub app deployment section

RUN mkdir -m 0774 -p \
	/data/ala-hub/config \
  /data/ala-hub/cache \
	/data/ala-hub/download \
	/data/ala-hub/geolite_db

COPY biocache-hub-files/config/*.json /data/ala-hub/config/
COPY ala-hub.war $CATALINA_HOME/webapps/

RUN apk add --update tini
ENTRYPOINT ["tini", "--"]
CMD ["catalina.sh", "run"]
