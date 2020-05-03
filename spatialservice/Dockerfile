FROM tomcat:7-jre8
RUN apt-get update && apt-get install -y gettext-base gdal-bin

RUN rm -r ${CATALINA_HOME}/webapps/ROOT \
    && rm -r ${CATALINA_HOME}/webapps/docs \
    && rm -r ${CATALINA_HOME}/webapps/examples \
    && rm -r ${CATALINA_HOME}/webapps/host-manager \
    && rm -r ${CATALINA_HOME}/webapps/manager

RUN mkdir -p /data/spatial-service/config \
  /data/ala/data/runtime/files \
  /data/spatial-data/standard_layer \
  /data/spatial-data/private \
  /data/spatial-data/layer \
  /data/spatial-data/uploads \
  /data/spatial-data/public \
  /data/tmp/tomcat-tmp

RUN mkdir -p \
  /data/ala/data/alaspatial \
  /data/ala/runtime/output/maxent \
  /data/ala/runtime/files \
  /data/ala/runtime/output \
  /data/ala/data/layers/analysis

RUN mkdir -p \
  /data/spatial-data/modelling/gdm \
  /data/spatial-data/modelling/maxent

COPY log4j.properties /data/spatial-service/config/log4j.properties
COPY spatial-service.war $CATALINA_HOME/webapps/ws.war
COPY files.xml /usr/local/tomcat/conf/Catalina/localhost/files.xml
COPY maxent.jar /data/spatial-data/modelling/maxent/maxent.jar

VOLUME /data/spatial-data

CMD ["catalina.sh", "run"]
