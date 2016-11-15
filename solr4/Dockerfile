FROM java:openjdk-8-jre-alpine

# Override the solr download location with e.g.:
#   docker build -t mine --build-arg SOLR_DOWNLOAD_SERVER=http://www-eu.apache.org/dist/lucene/solr .
ARG SOLR_DOWNLOAD_SERVER

RUN apk add --no-cache \
        lsof \
        gnupg \
        procps \
        tar \
        bash
RUN apk add --no-cache ca-certificates wget && \
        update-ca-certificates

ENV SOLR_USER solr
ENV SOLR_UID 8983

RUN addgroup -S -g $SOLR_UID $SOLR_USER && \
  adduser -S -u $SOLR_UID -g $SOLR_USER $SOLR_USER

ENV SOLR_VERSION 4.10.4
ENV SOLR_URL ${SOLR_DOWNLOAD_SERVER:-https://archive.apache.org/dist/lucene/solr}/$SOLR_VERSION/solr-$SOLR_VERSION.tgz
ENV JTS_URL http://central.maven.org/maven2/com/vividsolutions/jts/1.12/jts-1.12.jar

RUN mkdir -p /opt/solr && \
  wget -q $SOLR_URL -O /opt/solr.tgz && \
  tar -C /opt/solr --extract --file /opt/solr.tgz --strip-components=1 && \
  rm /opt/solr.tgz* && \
  rm -Rf /opt/solr/docs/ && \
  mkdir -p /opt/solr/server/solr/lib /opt/solr/server/solr/mycores && \
  chown -R $SOLR_USER:$SOLR_USER /opt/solr && \
  mkdir /docker-entrypoint-initdb.d /opt/docker-solr/

# ALA configs

COPY scripts /opt/docker-solr/scripts
RUN rm -rf /opt/solr/example/solr
COPY solr /opt/solr/example/solr

RUN wget -q ${JTS_URL} -O /opt/solr/example/lib/ext/jts-1.12.jar 

RUN chown -R $SOLR_USER:$SOLR_USER /opt/docker-solr
RUN chown -R $SOLR_USER:$SOLR_USER /opt/solr

#tini
RUN apk add --update tini

ENV PATH /opt/solr/bin:/opt/docker-solr/scripts:$PATH

EXPOSE 8983
WORKDIR /opt/solr
USER $SOLR_USER

ENTRYPOINT ["tini", "--", "docker-entrypoint.sh"]
CMD ["solr"]