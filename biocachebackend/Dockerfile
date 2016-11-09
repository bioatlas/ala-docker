FROM openjdk:7-alpine

# biocache-properties section

RUN mkdir -p /data/biocache/layers /data/biocache/config

COPY biocache-properties-files/biocache-config.properties \
	/data/biocache/config/biocache-config.properties

RUN chmod 0644 /data/biocache/config/biocache-config.properties

COPY biocache-properties-files/sds-layers.tgz \
	/data/biocache/layers/sds-layers.tgz

RUN tar zxvf /data/biocache/layers/sds-layers.tgz -C /data/biocache/layers/ && \
	rm -f /data/biocache/layers/sds-layers.tgz

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
	/data/tool

#biocache-cli deployment

RUN mkdir -p /usr/lib/biocache && \
	rm -Rf /usr/lib/biocache/lib /usr/lib/biocache/*.jar

COPY biocache-cli-files/log4j.xml /usr/lib/biocache/log4j.xml
COPY biocache-cli-files/subgroups.json /data/biocache/config/subgroups.json
COPY biocache.zip /usr/lib/biocache/biocache.zip
RUN unzip /usr/lib/biocache/biocache.zip -d /usr/lib/biocache/
COPY biocache-cli-files/biocache.sh /usr/lib/biocache/biocache 

RUN chmod 777 /usr/lib/biocache/biocache && \
	mv /usr/lib/biocache/biocache-store-*.jar /usr/lib/biocache/biocache.jar && \
	cat /usr/lib/biocache/biocache.jar >> /usr/lib/biocache/biocache && \
	ln -s /usr/lib/biocache/biocache /usr/bin/biocache

RUN mkdir -m 777 -p \
    /data/biocache-reindex/solr-template \
    /data/biocache-reindex/solr-create \
    /data/biocache-reindex/solr

COPY biocache-cli-files/solr-template /data/biocache-reindex/solr-template