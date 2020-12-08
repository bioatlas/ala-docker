FROM openjdk:8-alpine

#RUN mkdir -p /data/lucene/namematching
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
	mv /usr/lib/nameindexer/ala-name-matching-*.jar /usr/lib/nameindexer/nameindexer.jar && \
	cat /usr/lib/nameindexer/nameindexer.jar >> /usr/lib/nameindexer/nameindexer && \
	ln -s /usr/lib/nameindexer/nameindexer /usr/bin/nameindexer

RUN nameindexer --all --dwca /data/lucene/sources/backbone --irmng /data/lucene/sources/IRMNG_DWC_HOMONYMS --common /data/lucene/sources/backbone/VernacularName.tsv

RUN rm -rf /data/lucene/sources/*

VOLUME /data/lucene/namematching
