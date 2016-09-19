include .env

NAME = dina-web/ala-docker
VERSION = $(TRAVIS_BUILD_ID)
ME = $(USER)
HOST = ala.dina-web.net
TS := $(shell date '+%Y_%m_%d_%H_%M')

URL_NAMEIDX = https://s3.amazonaws.com/ala-nameindexes/20140610
URL_COL= $(URL_NAMEIDX)/col_namematching.tgz
URL_ALA= $(URL_NAMEIDX)/namematching.tgz
URL_MRG= $(URL_NAMEIDX)/merge_namematching.tgz
URL_SDS = http://biocache.ala.org.au/archives/layers/sds-layers.tgz
URL_COLLECTORY = http://nexus.ala.org.au/service/local/repositories/releases/content/au/org/ala/generic-collectory/1.4.3/generic-collectory-1.4.3.war
URL_NAMESDIST = http://nexus.ala.org.au/service/local/repositories/releases/content/au/org/ala/ala-name-matching/2.3.1/ala-name-matching-2.3.1-distribution.zip 

all: init build up
.PHONY: all

init:
	@echo "Caching files required for the build..."

	@mkdir -p mysql-datadir cassandra-datadir initdb \
		lucene-datadir tomcat/biocache-properties-files

	@curl --progress -L -s -o wait-for-it.sh \
		https://raw.githubusercontent.com/vishnubob/wait-for-it/master/wait-for-it.sh && \
		chmod +x wait-for-it.sh

	@test -f cassandra/wait-for-it.sh || \
		cp wait-for-it.sh cassandra/

	@test -f tomcat/collectory.war || \
		curl --progress -o tomcat/collectory.war $(URL_COLLECTORY)

	@test -f nameindex/namematching.tgz || \
		curl --progress -o nameindex/namematching.tgz $(URL_COL)

	@test -f nameindex/nameindexer.zip || \
		curl --progress -o nameindex/nameindexer.zip $(URL_NAMESDIST)

	@test -f nameindex/dwca-col.zip || \
		curl --progress -o nameindex/dwca-col.zip $(URL_NAMEIDX)/dwca-col.zip

	@test -f nameindex/dwca-col-mammals.zip || \
		curl --progress -o nameindex/dwca-col-mammals.zip $(URL_NAMEIDX)/dwca-col-mammals.zip

	@test -f nameindex/IRMNG_DWC_HOMONYMS.zip || \
		curl --progress -o nameindex/IRMNG_DWC_HOMONYMS.zip $(URL_NAMEIDX)/IRMNG_DWC_HOMONYMS.zip

	@test -f nameindex/col_vernacular.txt.zip || \
		curl --progress -o nameindex/col_vernacular.txt.zip $(URL_NAMEIDX)/col_vernacular.txt.zip

	@test -f tomcat/biocache-properties-files/sds-layers.tgz || \
		curl --progress -o tomcat/biocache-properties-files/sds-layers.tgz $(URL_SDS)

build:
	@echo "Building images..."
	#touch tomcat/biocache-properties-files/subgroups.json
	#touch tomcat/biocache-properties-files/biocache-config.properties
	@docker build -t dina/ala-solrindex:v0.1 solr4
	@docker build -t dina/ala-cassandra:v0.1 cassandra
	@docker build -t dina/ala-tomcat:v0.1 tomcat
	@docker build -t dina/ala-nameindex:v0.1 nameindex

up:
	@echo "Starting services..."
	@docker-compose up -d

test-solr:
	@docker exec -it aladocker_solr_1 sh -c \
		"curl http://localhost:8983/solr/admin/cores?status" > solr.xml && \
		firefox solr.xml

test-cas:
	@echo "Listing keyspaces in cassandra:"
	@docker exec -it aladocker_cas_1 sh -c \
		'echo "DESC KEYSPACES;" | cqlsh'

test:
	@echo "Opening up collectory... did you add ala.local in /etc/hosts?"
	#@curl -H "Host: ala.local" localhost/collectory/
	./wait-for-it.sh ala.local:80 -q -- xdg-open http://ala.local/collectory/ &

stop:
	@echo "Stopping services..."
	@docker-compose stop

clean:
	@echo "Removing downloaded files and build artifacts"
	#rm -f wait-for-it.sh
	#rm -f *.war

rm: stop
	@echo "Removing containers and persisted data"
	docker-compose rm -vf
	#sudo rm -rf mysql-datadir cassandra-datadir initdb lucene-datadir

push:
	@docker push dina/ala-cassandra:v0.1
	@docker push dina/ala-tomcat:v0.1
	@docker push dina/ala-nameindex:v0.1
	@docker push dina/ala-solrindex:v0.1

release: build push

