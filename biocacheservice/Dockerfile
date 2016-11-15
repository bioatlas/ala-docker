FROM tomcat:7-alpine

# biocache-properties section

RUN mkdir -p /data/biocache/layers /data/biocache/config

COPY biocache-properties-files/biocache-config.properties \
	/data/biocache/config/biocache-config.properties

RUN chmod 0644 /data/biocache/config/biocache-config.properties

COPY biocache-properties-files/subgroups.json \
	/data/biocache/config/subgroups.json

RUN mkdir -m 0774 -p \
	/data/biocache-load \
	/data/biocache-media \
	/data/biocache-upload \
	/data/biocache-delete \
	/data/cache \
	/data/tmp \
	/data/offline/exports \
	/data/tool

# biocache-service deployment section

COPY biocache-service-files/applicationContext.xml \
	/data/biocache/config/applicationContext.xml
COPY biocache-service-files/facets.json\
	/data/biocache/config/facets.json
COPY biocache-service-files/log4j.xml \
	/data/biocache/config/log4j.xml

COPY biocache-service.war $CATALINA_HOME/webapps/

RUN mkdir -m 0774 -p \
    /data/biocache-load/data \
    /data/biocache-upload/data \
    /data/biocache-delete/data \
    /data/cache/data \
    /data/tmp/data \
    /data/offline/exports/data \
    /data/tool/data \
    /data/biocache-download/tmp/data

RUN chmod 777 /data/biocache-media
RUN chmod 777 /data/biocache-load

RUN apk add --update tini
ENTRYPOINT ["tini", "--"]
CMD ["catalina.sh", "run"]