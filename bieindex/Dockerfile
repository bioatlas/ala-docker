FROM tomcat:8-jre8-alpine

RUN rm -r ${CATALINA_HOME}/webapps/ROOT \
    && rm -r ${CATALINA_HOME}/webapps/docs \
    && rm -r ${CATALINA_HOME}/webapps/examples \
    && rm -r ${CATALINA_HOME}/webapps/host-manager \
    && rm -r ${CATALINA_HOME}/webapps/manager

RUN mkdir -p /data/bie-index/config \
  /data/bie/import

COPY bieindex-files/*.json \
  /data/bie-index/config/

COPY bie-index.war $CATALINA_HOME/webapps/ws.war
#COPY server.xml $CATALINA_HOME/conf/server.xml

RUN apk add --update tini
ENTRYPOINT ["tini", "--"]
CMD ["catalina.sh", "run"]
VOLUME /data
