FROM tomcat:8-jdk8-openjdk-slim

RUN mkdir -p /data/sds/config \
  /data/sds/data \
  /data/lucene/namematching

COPY sds-webapp.war $CATALINA_HOME/webapps/sds.war

COPY sds-files/sensitivity-categories.xml /data/sds/sensitivity-categories.xml
COPY sds-files/sensitivity-zones.xml /data/sds/sensitivity-zones.xml
COPY sds-files/sensitive-species.xml /data/sds/sensitive-species.xml

CMD ["catalina.sh", "run"]
