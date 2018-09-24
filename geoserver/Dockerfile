FROM kartoza/geoserver:2.13.0

RUN apt-get install -y netcat
RUN mkdir -p /data/ala/data/geoserver_data_dir \
  /data/ala/data/geoserver_data_dir/GeoNetwork_opensource

COPY geoserver-files/geoserver.distributions.xml /data/
COPY geoserver-files/geoserver.objects.xml /data/
COPY geoserver-files/geoserver.sh /data/
RUN chmod a+x /data/geoserver.sh
