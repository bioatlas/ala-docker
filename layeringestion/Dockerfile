FROM openjdk:8

RUN apt-get update && apt-get install -y postgis gdal-bin

RUN mkdir -p /usr/lib/layer-ingestion
RUN rm -Rf /usr/lib/layer-ingestion/lib /usr/lib/layer-ingestion/*.jar
COPY layer-ingestion.zip /tmp/layer-ingestion.zip
RUN unzip -d /usr/lib/layer-ingestion /tmp/layer-ingestion.zip
RUN mv /usr/lib/layer-ingestion/layer-ingestion*/* /usr/lib/layer-ingestion/
RUN chmod +x /usr/lib/layer-ingestion/*.sh

VOLUME /data
