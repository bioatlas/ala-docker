FROM cassandra:3.11.2

COPY entrypoint-wrap.sh /entrypoint-wrap.sh
COPY biocache-db/cassandra3-schema.txt /docker-entrypoint-initdb.d/cassandra3-schema.cql
COPY cassandra-files/cassandra-env.sh /tmp/cassandra-env.sh
COPY cassandra-files/cassandra.yaml /tmp/cassandra.yaml
