FROM tomcat:7-alpine

RUN mkdir -p /data/layers-store/config \
  /data/layers-service/config \
  /data/layers-service/batch_requests \
  /data/ala/data/layers/raw \
  /data/ala/data/layers/ready/shape \
  /data/ala/data/layers/ready/shape_diva \
  /data/ala/data/layers/ready/diva \
  /data/ala/data/layers/analysis/tmp

COPY layers-service.war $CATALINA_HOME/webapps/
VOLUME /data

RUN apk add --update tini
ENTRYPOINT ["tini", "--"]
CMD ["catalina.sh", "run"]
