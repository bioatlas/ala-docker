FROM tomcat:7
ADD collectory.war $CATALINA_HOME/webapps/
RUN mkdir -p /data/generic-collectory/config
ADD app.properties /data/generic-collectory/config/generic-collectory-config.properties

