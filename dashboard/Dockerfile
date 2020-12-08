FROM tomcat:7-jre8-alpine

RUN rm -r ${CATALINA_HOME}/webapps/ROOT \
    && rm -r ${CATALINA_HOME}/webapps/docs \
    && rm -r ${CATALINA_HOME}/webapps/examples \
    && rm -r ${CATALINA_HOME}/webapps/host-manager \
    && rm -r ${CATALINA_HOME}/webapps/manager

# dashboard deployment section

RUN mkdir -p /data \
	/data/dashboard \
	/data/dashboard/config \
	/data/dashboard/csv \
	/data/dashboard/zip

COPY data.json /data/dashboard/data.json
COPY dashboard.war $CATALINA_HOME/webapps/ROOT.war

RUN apk add --update tini
ENTRYPOINT ["tini", "--"]
CMD ["catalina.sh", "run"]
