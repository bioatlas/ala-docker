FROM openjdk:7

RUN mkdir -p /data/lucene/namematching
COPY namematching.tgz /data/lucene/ 
RUN tar xvf /data/lucene/namematching.tgz -C /data/lucene/namematching --strip-components 1
