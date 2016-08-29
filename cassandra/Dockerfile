FROM cassandra

ADD conf/90-nproc.conf /etc/security/limits.d/
ADD conf/limits.conf /etc/security/ 
ADD templates/cassandra.yaml /etc/cassandra/

RUN mkdir -p /data && \
	chown -R cassandra:cassandra /data && \
	chmod 777 /data
