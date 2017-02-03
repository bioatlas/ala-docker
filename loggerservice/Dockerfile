FROM tomcat:7-alpine

# logger-service deployment section

RUN mkdir -p /data \
	/data/logger/config

COPY logger-config.properties /data/logger/config/

COPY logger-service.war $CATALINA_HOME/webapps/

RUN apk add --update tini
ENTRYPOINT ["tini", "--"]
CMD ["catalina.sh", "run"]