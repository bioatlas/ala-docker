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

# tini

ENV TINI_VERSION v0.10.0
ADD https://github.com/krallin/tini/releases/download/${TINI_VERSION}/tini /tini
ADD https://github.com/krallin/tini/releases/download/${TINI_VERSION}/tini.asc /tini.asc
#RUN gpg --keyserver ha.pool.sks-keyservers.net --recv-keys 595E85A6B1B4779EA4DAAEC70B588DFF0527A9B7 \
# && gpg --verify /tini.asc

RUN chmod +x /tini

ENTRYPOINT ["/tini", "--"]
CMD ["catalina.sh", "run"]