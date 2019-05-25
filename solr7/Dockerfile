FROM solr:7.4-alpine

COPY mycores /opt/solr/server/solr/mycores
COPY solr.xml /opt/solr/server/solr/solr.xml
COPY zoo.cfg /opt/solr/server/solr/zoo.cfg
COPY lib/*.jar /opt/solr/server/solr-webapp/webapp/WEB-INF/lib/
copy solr.in.sh /etc/default/solr.in.sh
