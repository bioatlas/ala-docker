FROM tomcat:7

#biocache-hub role or the generic-hub app deployment section

RUN mkdir -m 0774 -p \
	/data/generic-hub/config \
    /data/generic-hub/cache

COPY biocache-hub-files/config/generic-hub-config.properties /data/generic-hub/config/generic-hub-config.properties
COPY biocache-hub-files/config/*.json /data/generic-hub/config/
COPY generic-hub.war $CATALINA_HOME/webapps/

# tini

ENV TINI_VERSION v0.10.0
ADD https://github.com/krallin/tini/releases/download/${TINI_VERSION}/tini /tini
ADD https://github.com/krallin/tini/releases/download/${TINI_VERSION}/tini.asc /tini.asc
#RUN gpg --keyserver ha.pool.sks-keyservers.net --recv-keys 595E85A6B1B4779EA4DAAEC70B588DFF0527A9B7 \
# && gpg --verify /tini.asc

RUN chmod +x /tini

ENTRYPOINT ["/tini", "--"]
CMD ["catalina.sh", "run"]