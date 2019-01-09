FROM tomcat:7-jre8-alpine

# biocache-properties section

RUN mkdir -p /data/biocache/layers /data/biocache/config

COPY biocache-properties-files/subgroups.json \
	/data/biocache/config/subgroups.json

RUN mkdir -m 0774 -p \
	/data/ala/layers/ready/shape \
	/data/biocache-load \
	/data/biocache-media \
	/data/biocache-upload \
	/data/biocache-delete \
	/data/cache \
	/data/tmp \
	/data/offline/exports \
	/data/tool \
	/data/biocache-download \
	/data/biocache-download/tmp

# biocache-service deployment section

COPY biocache-service-files/applicationContext.xml \
	/data/biocache/config/applicationContext.xml
COPY biocache-service-files/facets.json\
	/data/biocache/config/facets.json
COPY biocache-service-files/log4j.xml \
	/data/biocache/config/log4j.xml
COPY biocache-service-files/*.html \
		/data/biocache/config/

COPY biocache-service.war $CATALINA_HOME/webapps/
COPY server.xml $CATALINA_HOME/conf/server.xml

RUN chmod 755 /data/biocache-download
RUN chmod 777 /data/biocache-media
RUN chmod 777 /data/biocache-load

#logger-client config section
RUN mkdir -m 0774 -p \
	/data/logger-client/config

RUN apk add --update tini
ENTRYPOINT ["tini", "--"]
CMD ["catalina.sh", "run"]
