FROM openjdk:8-alpine

RUN mkdir -p /data/lucene/sources

COPY dyntaxa.dwca.zip /data/lucene/sources/
RUN mkdir -p /data/lucene/sources/dyntaxa && \
	unzip /data/lucene/sources/dyntaxa.dwca.zip -d /data/lucene/sources/dyntaxa/

COPY nameindexer.zip /usr/lib/nameindexer/
RUN unzip -o /usr/lib/nameindexer/nameindexer.zip -d /usr/lib/nameindexer
COPY lib/log4j.xml /usr/lib/nameindexer/
COPY nameindexer.sh /usr/lib/nameindexer/nameindexer

RUN chmod 777 /usr/lib/nameindexer/nameindexer && \
	mv /usr/lib/nameindexer/ala-name-matching-*.jar /usr/lib/nameindexer/nameindexer.jar && \
	cat /usr/lib/nameindexer/nameindexer.jar >> /usr/lib/nameindexer/nameindexer && \
	ln -s /usr/lib/nameindexer/nameindexer /usr/bin/nameindexer

RUN nameindexer --all --dwca /data/lucene/sources/dyntaxa --common /data/lucene/sources/dyntaxa/VernacularName.tsv

ADD http://central.maven.org/maven2/org/apache/lucene/lucene-core/6.6.5/lucene-core-6.6.5.jar /tmp/
ADD http://central.maven.org/maven2/org/apache/lucene/lucene-backward-codecs/6.6.5/lucene-backward-codecs-6.6.5.jar /tmp/

RUN java -cp /tmp/lucene-core-6.6.5.jar:/tmp/lucene-backward-codecs-6.6.5.jar org.apache.lucene.index.IndexUpgrader -delete-prior-commits /data/lucene/namematching/cb
RUN java -cp /tmp/lucene-core-6.6.5.jar:/tmp/lucene-backward-codecs-6.6.5.jar org.apache.lucene.index.IndexUpgrader -delete-prior-commits /data/lucene/namematching/vernacular

RUN rm -rf /data/lucene/sources/*

VOLUME /data/lucene/namematching
