FROM cassandra:1.2

COPY conf/90-nproc.conf /etc/security/limits.d/
COPY conf/limits.conf /etc/security/ 
COPY templates/cassandra.yaml /etc/cassandra/

COPY biocache-db/cassandra-schema.txt /opt/

COPY wait-for-it.sh /opt/

RUN mkdir -p /data/cassandra/data /data/cassandra/commitlog /data/cassandra/saved_caches \
	&& chown -R cassandra:cassandra /data/cassandra \
	&& chmod 777 /data/cassandra

RUN cassandra && \
	./opt/wait-for-it.sh --timeout=30 localhost:9042 --strict -- \ 
	cassandra-cli -f /opt/cassandra-schema.txt && \
	cassandra stop
