FROM tomcat:7

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

# biocache-properties section

RUN mkdir -p /data/biocache/layers /data/biocache/config

COPY biocache-properties-files/biocache-config.properties \
	/data/biocache/config/biocache-config.properties

RUN chmod 0644 /data/biocache/config/biocache-config.properties

COPY biocache-properties-files/sds-layers.tgz \
	/data/biocache/layers/sds-layers.tgz

RUN tar zxvf /data/biocache/layers/sds-layers.tgz -C /data/biocache/layers/

COPY biocache-properties-files/subgroups.json \
	/data/biocache/config/subgroups.json

RUN mkdir -m 0774 -p /data/ala/layers/ready/shape \
	/data/biocache-load \
	/data/biocache-media \
	/data/biocache-upload \
	/data/biocache-delete \
	/data/cache \
	/data/tmp \
	/data/offline/exports \
	/data/tool

# biocache-service deployment section

# tini

ENV TINI_VERSION v0.10.0
ADD https://github.com/krallin/tini/releases/download/${TINI_VERSION}/tini /tini
ADD https://github.com/krallin/tini/releases/download/${TINI_VERSION}/tini.asc /tini.asc
RUN gpg --keyserver ha.pool.sks-keyservers.net --recv-keys 595E85A6B1B4779EA4DAAEC70B588DFF0527A9B7 \
 && gpg --verify /tini.asc

RUN chmod +x /tini

ENTRYPOINT ["/tini", "--"]
CMD ["catalina.sh", "run"]

