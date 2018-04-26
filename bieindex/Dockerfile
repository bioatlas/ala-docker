FROM tomcat:8-alpine

RUN mkdir -p /data/bie-index/config \
  /data/bie/import

COPY bieindex-files/*.json \
  	/data/bie-index/config/

COPY bie-index.war $CATALINA_HOME/webapps/

RUN apk add --update tini
ENTRYPOINT ["tini", "--"]
CMD ["catalina.sh", "run"]
