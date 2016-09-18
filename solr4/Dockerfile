FROM java:openjdk-8-jre

# Override the solr download location with e.g.:
#   docker build -t mine --build-arg SOLR_DOWNLOAD_SERVER=http://www-eu.apache.org/dist/lucene/solr .
ARG SOLR_DOWNLOAD_SERVER

RUN apt-get update && \
  apt-get -y install lsof && \
  rm -rf /var/lib/apt/lists/*

ENV SOLR_USER solr
ENV SOLR_UID 8983

RUN groupadd -r -g $SOLR_UID $SOLR_USER && \
  useradd -r -u $SOLR_UID -g $SOLR_USER $SOLR_USER

ENV SOLR_VERSION 4.10.4
ENV SOLR_URL ${SOLR_DOWNLOAD_SERVER:-https://archive.apache.org/dist/lucene/solr}/$SOLR_VERSION/solr-$SOLR_VERSION.tgz

RUN mkdir -p /opt/solr && \
  wget -nv $SOLR_URL -O /opt/solr.tgz && \
  tar -C /opt/solr --extract --file /opt/solr.tgz --strip-components=1 && \
  rm /opt/solr.tgz* && \
  rm -Rf /opt/solr/docs/ && \
  mkdir -p /opt/solr/server/solr/lib /opt/solr/server/solr/mycores && \
  chown -R $SOLR_USER:$SOLR_USER /opt/solr && \
  mkdir /docker-entrypoint-initdb.d /opt/docker-solr/

ENV TINI_VERSION v0.10.0
ADD https://github.com/krallin/tini/releases/download/${TINI_VERSION}/tini /tini
ADD https://github.com/krallin/tini/releases/download/${TINI_VERSION}/tini.asc /tini.asc
RUN gpg --keyserver ha.pool.sks-keyservers.net --recv-keys 595E85A6B1B4779EA4DAAEC70B588DFF0527A9B7 \
 && gpg --verify /tini.asc
RUN chmod +x /tini

# ALA configs

COPY scripts /opt/docker-solr/scripts
RUN rm -rf /opt/solr/example/solr
COPY solr /opt/solr/example/solr

RUN chown -R $SOLR_USER:$SOLR_USER /opt/docker-solr
RUN chown -R $SOLR_USER:$SOLR_USER /opt/solr

ENV PATH=/opt/solr/bin:/opt/docker-solr/scripts:$PATH

EXPOSE 8983
WORKDIR /opt/solr
USER $SOLR_USER

ENTRYPOINT ["/tini", "--", "docker-entrypoint.sh"]
CMD ["solr"]
