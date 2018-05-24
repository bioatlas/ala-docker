FROM tomcat:7-jre8
RUN apt-get update && apt-get install -y gettext-base gdal-bin

RUN mkdir -p /data/spatial-service/config \
  /data/ala/data/runtime/files \
  /data/standard_layer \
  /data/private \
  /data/layer

COPY log4j.properties /data/spatial-service/config/log4j.properties
COPY spatial-service.war $CATALINA_HOME/webapps/spatial-service.war

VOLUME /data

CMD ["catalina.sh", "run"]
