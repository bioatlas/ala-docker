include .env

NAME = dina-web/ala-docker
VERSION = $(TRAVIS_BUILD_ID)
ME = $(USER)
HOST = ala.dina-web.net
TS := $(shell date '+%Y_%m_%d_%H_%M')

URL_NAMEIDX = https://s3.amazonaws.com/ala-nameindexes/20140610
URL_COL = $(URL_NAMEIDX)/col_namematching.tgz
URL_ALA = $(URL_NAMEIDX)/namematching.tgz
URL_MRG = $(URL_NAMEIDX)/merge_namematching.tgz
URL_SDS = http://biocache.ala.org.au/archives/layers/sds-layers.tgz
URL_COLLECTORY = http://nexus.ala.org.au/service/local/repositories/releases/content/au/org/ala/generic-collectory/1.4.3/generic-collectory-1.4.3.war
URL_NAMESDIST = http://nexus.ala.org.au/service/local/repositories/releases/content/au/org/ala/ala-name-matching/2.3.1/ala-name-matching-2.3.1-distribution.zip 
URL_BIOCACHE_SERVICE = http://nexus.ala.org.au/service/local/repositories/releases/content/au/org/ala/biocache-service/1.8.0/biocache-service-1.8.0.war
URL_BIOCACHE_HUB = http://nexus.ala.org.au/service/local/repositories/releases/content/au/org/ala/generic-hub/1.2.5/generic-hub-1.2.5.war
URL_BIOCACHE_CLI = http://nexus.ala.org.au/service/local/repositories/releases/content/au/org/ala/biocache-store/1.8.0/biocache-store-1.8.0-distribution.zip 

all: init build up
.PHONY: all

init:
	@echo "Caching files required for the build..."

	@mkdir -p mysql-datadir cassandra-datadir initdb \
		lucene-datadir

	@curl --progress -L -s -o wait-for-it.sh \
		https://raw.githubusercontent.com/vishnubob/wait-for-it/master/wait-for-it.sh && \
		chmod +x wait-for-it.sh

	@test -f cassandra/wait-for-it.sh || \
		cp wait-for-it.sh cassandra/

	@test -f collectory/collectory.war || \
		curl --progress -o collectory/collectory.war $(URL_COLLECTORY)

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

	@test -f biocachebackend/biocache-properties-files/sds-layers.tgz || \
		curl --progress --create-dirs -o biocachebackend/biocache-properties-files/sds-layers.tgz $(URL_SDS)

	@test -f biocacheservice/biocache-service.war || \
		curl --progress -o biocacheservice/biocache-service.war $(URL_BIOCACHE_SERVICE)

	@test -f biocachehub/generic-hub.war || \
		curl --progress -o biocachehub/generic-hub.war $(URL_BIOCACHE_HUB)

	@test -f biocachebackend/biocache.zip || \
		curl --progress -o biocachebackend/biocache.zip $(URL_BIOCACHE_CLI)	

build:
	@echo "Building images..."
	@docker build -t dina/ala-solrindex:v0.1 solr4
	@docker build -t dina/ala-biocachebackend:v0.1 biocachebackend
	@docker build -t dina/ala-nameindex:v0.1 nameindex
	@docker build -t dina/ala-nginx:v0.1 nginx
	@docker build -t dina/ala-biocachehub:v0.1 biocachehub
	@docker build -t dina/ala-collectory:v0.1 collectory
	@docker build -t dina/ala-biocacheservice:v0.1 biocacheservice
	@docker build -t dina/ala-cassandra:v0.1 cassandra
	@docker build -t dina/ala-mongo:v0.1 mongo

up:
	@echo "Starting services..."
	@docker-compose up -d


test:
	@echo "run cd ghost && rm -rf content && make content first to populate front page with content"
	@echo "Opening up front page... use the bigmac/hamburger menu at the front page to get the toolbar for testing all services.."
	./wait-for-it.sh gbifsweden.se:80 -q -- xdg-open http://gbifsweden.se/ &

test-solr:
	@curl -L -s gbifsweden.se/solr/admin/cores?status > solr.xml && \
		firefox solr.xml

test-cas:
	@echo "Listing keyspaces in cassandra:"
	@docker exec -it cassandradb sh -c \
		'echo "DESC KEYSPACES;" | cqlsh'

test-uptime:
	#@curl -L admin:password@uptime.gbifsweden.se
	@xdg-open http://admin:password@uptime.gbifsweden.se

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
	@docker push dina/ala-nameindex:v0.1
	@docker push dina/ala-solrindex:v0.1
	@docker push dina/ala-nginx:v0.1
	@docker push dina/ala-biocachehub:v0.1
	@docker push dina/ala-collectory:v0.1
	@docker push dina/ala-biocacheservice:v0.1
	@docker push dina/ala-biocachebackend:v0.1

release: build push
