FROM solr:7.7.2-slim

#COPY mycores /opt/solr/server/solr/mycores
COPY --chown=8983:8983 solr.xml /opt/solr/server/solr/solr.xml
COPY --chown=8983:8983 zoo.cfg /opt/solr/server/solr/zoo.cfg
COPY --chown=8983:8983 lib/*.jar /opt/solr/server/solr-webapp/webapp/WEB-INF/lib/
COPY solr.in.sh /etc/default/solr.in.sh
