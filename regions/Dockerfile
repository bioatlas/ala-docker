FROM tomcat:7-jre8-alpine

RUN mkdir -p /data/regions/config
COPY regions.war $CATALINA_HOME/webapps/

RUN apk add --update tini
ENTRYPOINT ["tini", "--"]
CMD ["catalina.sh", "run"]
