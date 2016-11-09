FROM tomcat:7-alpine

# collectory deployment section

RUN mkdir -p /data \
	/data/generic-collectory \
	/data/generic-collectory/upload/tmp \
	/data/generic-collectory/taxa/data

COPY generic-collectory-data/generic-collectory/config \
	/data/generic-collectory/config

COPY generic-collectory-data/generic-collectory/data\
	/data/generic-collectory/data

COPY collectory.war $CATALINA_HOME/webapps/

RUN apk add --update tini
ENTRYPOINT ["tini", "--"]
CMD ["catalina.sh", "run"]