FROM tomcat:7

RUN mkdir /data

#collectory deployment section

RUN mkdir -p /data/generic-collectory 
RUN mkdir -p /data/generic-collectory/upload/tmp
RUN mkdir -p /data/generic-collectory/taxa/data
COPY generic-collectory-data/generic-collectory/config /data/generic-collectory/config
COPY generic-collectory-data/generic-collectory/data /data/generic-collectory/data
COPY collectory.war $CATALINA_HOME/webapps/

#biocache-properties section

RUN mkdir -p /data/biocache/layers
RUN mkdir -p /data/biocache/config
COPY biocache-properties-files/biocache-config.properties /data/biocache/config/biocache-config.properties
RUN chmod 0644 /data/biocache/config/biocache-config.properties

COPY biocache-properties-files/sds-layers.tgz /data/biocache/layers/sds-layers.tgz
RUN tar zxvf /data/biocache/layers/sds-layers.tgz -C /data/biocache/layers/

COPY biocache-properties-files/subgroups.json /data/biocache/config/subgroups.json

RUN mkdir -m 0774 -p /data/ala/layers/ready/shape  
RUN mkdir -m 0774 -p /data/biocache-load
RUN mkdir -m 0774 -p /data/biocache-media
RUN mkdir -m 0774 -p /data/biocache-upload
RUN mkdir -m 0774 -p /data/biocache-delete
RUN mkdir -m 0774 -p /data/cache
RUN mkdir -m 0774 -p /data/tmp
RUN mkdir -m 0774 -p /data/offline/exports
RUN mkdir -m 0774 -p /data/tool

#biocache-service deployment section
