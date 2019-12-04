FROM openjdk:8-alpine

# biocache-properties section

RUN mkdir -p /data/biocache/layers /data/biocache/config

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
	/data/tool \
	/data/lucene

#biocache-cli deployment

RUN mkdir -p /usr/lib/biocache
COPY biocache-cli-files/log4j.xml /usr/lib/biocache/log4j.xml
COPY biocache-cli-files/vocab /data/biocache/vocab
COPY biocache.zip /usr/lib/biocache/biocache.zip
RUN unzip /usr/lib/biocache/biocache.zip -d /usr/lib/biocache/
RUN ln -s /usr/lib/biocache/biocache-store-2.4.5/bin/biocache /usr/bin/biocache
COPY biocache-cli-files/environmentSetupFile.sh /usr/lib/biocache/biocache-store-2.4.5/bin/environmentSetupFile.sh
RUN chmod 755 /usr/lib/biocache/biocache-store-2.4.5/bin/environmentSetupFile.sh

RUN mkdir -m 777 -p \
    /data/biocache-reindex/solr-template \
    /data/biocache-reindex/solr-create \
    /data/biocache-reindex/solr

COPY biocache-cli-files/solr-template /data/biocache-reindex/solr-template
VOLUME /data
