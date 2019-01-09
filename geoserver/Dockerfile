FROM kartoza/geoserver:2.13.0

RUN apt-get -y update && apt-get install -y wget netcat
RUN mkdir -p /data/ala/data/geoserver_data_dir \
  /data/ala/data/geoserver_data_dir/GeoNetwork_opensource \
  /data/geoserver-files
COPY server.xml $CATALINA_HOME/conf/server.xml
COPY geoserver-files/* /data/geoserver-files/
RUN chmod a+x /data/geoserver-files/geoserver.sh
VOLUME /data/ala/data/geoserver_data_dir
