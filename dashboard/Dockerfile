FROM tomcat:8-alpine

# dashboard deployment section

RUN mkdir -p /data \
	/data/dashboard \
	/data/dashboard/config

COPY dashboard.war $CATALINA_HOME/webapps/

RUN apk add --update tini
ENTRYPOINT ["tini", "--"]
CMD ["catalina.sh", "run"]
