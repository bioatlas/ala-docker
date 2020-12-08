FROM tomcat:8-jre8-alpine

RUN rm -r ${CATALINA_HOME}/webapps/ROOT \
    && rm -r ${CATALINA_HOME}/webapps/docs \
    && rm -r ${CATALINA_HOME}/webapps/examples \
    && rm -r ${CATALINA_HOME}/webapps/host-manager \
    && rm -r ${CATALINA_HOME}/webapps/manager

RUN mkdir -m 0775 -p /data/ala-bie/config
COPY biehub-files/*.json /data/ala-bie/config/

COPY ala-bie.war $CATALINA_HOME/webapps/ROOT.war

RUN apk add --update tini
ENTRYPOINT ["tini", "--"]
CMD ["catalina.sh", "run"]
