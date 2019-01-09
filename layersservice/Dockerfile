FROM tomcat:7-jre8

RUN apt-get update && apt-get install -y gettext-base gdal-bin

RUN mkdir -p /data/layers-store/config \
  /data/layers-service/config \
  /data/layers-service/batch_requests \
  /data/ala/data/layers/raw \
  /data/ala/data/layers/ready/shape \
  /data/ala/data/layers/ready/shape_diva \
  /data/ala/data/layers/ready/diva \
  /data/ala/data/layers/analysis/tmp \
  /data/ala/runtime/output

COPY layers-service.war $CATALINA_HOME/webapps/
VOLUME /data

CMD ["catalina.sh", "run"]
