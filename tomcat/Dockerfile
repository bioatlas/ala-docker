FROM tomcat:7

RUN mkdir /data

RUN mkdir -p /data/generic-collectory 
RUN mkdir -p /data/generic-collectory/upload/tmp
RUN mkdir -p /data/generic-collectory/taxa/data
COPY generic-collectory-data/generic-collectory/config /data/generic-collectory/config
COPY generic-collectory-data/generic-collectory/data /data/generic-collectory/data
COPY collectory.war $CATALINA_HOME/webapps/