FROM openjdk:8-alpine

RUN mkdir -p /data/lucene/namematching
RUN mkdir -p /data/lucene/sources

COPY backbone.zip /data/lucene/sources/
RUN mkdir -p /data/lucene/sources/backbone && \
	unzip /data/lucene/sources/backbone.zip -d /data/lucene/sources/backbone/

COPY IRMNG_DWC_HOMONYMS.zip /data/lucene/sources/
RUN mkdir -p /data/lucene/sources/IRMNG_DWC_HOMONYMS && \
	unzip /data/lucene/sources/IRMNG_DWC_HOMONYMS.zip -d /data/lucene/sources/IRMNG_DWC_HOMONYMS/

COPY nameindexer.zip /usr/lib/nameindexer/
RUN unzip -o /usr/lib/nameindexer/nameindexer.zip -d /usr/lib/nameindexer
COPY lib/log4j.xml /usr/lib/nameindexer/
COPY nameindexer.sh /usr/lib/nameindexer/nameindexer

RUN chmod 777 /usr/lib/nameindexer/nameindexer && \
	mv /usr/lib/nameindexer/ala-name-matching-3.1.jar /usr/lib/nameindexer/nameindexer.jar && \
	cat /usr/lib/nameindexer/nameindexer.jar >> /usr/lib/nameindexer/nameindexer && \
	ln -s /usr/lib/nameindexer/nameindexer /usr/bin/nameindexer

ADD http://central.maven.org/maven2/org/apache/lucene/lucene-core/5.5.1/lucene-core-5.5.1.jar /tmp/
ADD http://central.maven.org/maven2/org/apache/lucene/lucene-backward-codecs/5.5.1/lucene-backward-codecs-5.5.1.jar /tmp/

RUN nameindexer --all --dwca /data/lucene/sources/backbone --irmng /data/lucene/sources/IRMNG_DWC_HOMONYMS --common /data/lucene/sources/backbone/VernacularName.tsv

RUN java -cp /tmp/lucene-core-5.5.1.jar:/tmp/lucene-backward-codecs-5.5.1.jar org.apache.lucene.index.IndexUpgrader -delete-prior-commits /data/lucene/namematching/cb
RUN	java -cp /tmp/lucene-core-5.5.1.jar:/tmp/lucene-backward-codecs-5.5.1.jar org.apache.lucene.index.IndexUpgrader -delete-prior-commits /data/lucene/namematching/irmng
RUN java -cp /tmp/lucene-core-5.5.1.jar:/tmp/lucene-backward-codecs-5.5.1.jar org.apache.lucene.index.IndexUpgrader -delete-prior-commits /data/lucene/namematching/vernacular

RUN rm -rf /data/lucene/sources/*

VOLUME /data/lucene/namematching
