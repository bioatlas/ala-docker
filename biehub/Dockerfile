FROM tomcat:7-jre8-alpine

RUN mkdir -m 0775 -p /data/ala-bie/config
COPY biehub-files/*.json /data/ala-bie/config/
COPY ala-bie.war $CATALINA_HOME/webapps/
COPY server.xml $CATALINA_HOME/conf/server.xml

RUN apk add --update tini
ENTRYPOINT ["tini", "--"]
CMD ["catalina.sh", "run"]
