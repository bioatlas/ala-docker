FROM openjdk:7-alpine

# download and move the pre-generated index

RUN mkdir -p /data/lucene/namematching
COPY namematching.tgz /data/lucene/
RUN apk --update add tar
RUN tar xvf /data/lucene/namematching.tgz -C /data/lucene/namematching --strip-components 1
RUN rm /data/lucene/namematching.tgz

#generate the index from scratch

RUN mkdir -p /data/lucene/sources 
COPY dwca-col.zip /data/lucene/sources/
COPY dwca-col-mammals.zip /data/lucene/sources/
COPY IRMNG_DWC_HOMONYMS.zip /data/lucene/sources/
COPY col_vernacular.txt.zip /data/lucene/sources/

RUN unzip /data/lucene/sources/dwca-col.zip -d /data/lucene/sources/ && \
	unzip /data/lucene/sources/dwca-col-mammals.zip -d /data/lucene/sources/ && \
	mkdir -p /data/lucene/sources/IRMNG_DWC_HOMONYMS && \
	unzip /data/lucene/sources/IRMNG_DWC_HOMONYMS.zip -d /data/lucene/sources/IRMNG_DWC_HOMONYMS/ && \
	unzip /data/lucene/sources/col_vernacular.txt.zip -d /data/lucene/sources/ && \
	rm -Rf /data/lucene/sources/*.zip

#COPY backbone.zip /data/lucene/sources/
#RUN unzip /data/lucene/sources/backbone.zip -d /data/lucene/sources/ && \
#	rm -Rf /data/lucene/sources/*.zip

COPY nameindexer.zip /usr/lib/nameindexer/
RUN unzip -o /usr/lib/nameindexer/nameindexer.zip -d /usr/lib/nameindexer
COPY lib/log4j.xml /usr/lib/nameindexer/
COPY nameindexer.sh /usr/lib/nameindexer/nameindexer

RUN chmod 777 /usr/lib/nameindexer/nameindexer && \
	mv /usr/lib/nameindexer/ala-name-matching-2.3.1.jar /usr/lib/nameindexer/nameindexer.jar && \
	cat /usr/lib/nameindexer/nameindexer.jar >> /usr/lib/nameindexer/nameindexer && \
	ln -s /usr/lib/nameindexer/nameindexer /usr/bin/nameindexer

VOLUME /data/lucene/namematching