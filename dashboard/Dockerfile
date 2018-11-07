FROM tomcat:7-jre8-alpine

# dashboard deployment section

RUN mkdir -p /data \
	/data/dashboard \
	/data/dashboard/config \
	/data/dashboard/csv \
	/data/dashboard/zip

COPY dashboard.war $CATALINA_HOME/webapps/

RUN apk add --update tini
ENTRYPOINT ["tini", "--"]
CMD ["catalina.sh", "run"]
