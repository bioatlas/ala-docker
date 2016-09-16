NAME = dina-web/ala-docker
VERSION = $(TRAVIS_BUILD_ID)
ME = $(USER)
HOST = ala.dina-web.net
TS := $(shell date '+%Y_%m_%d_%H_%M')

name_indexes_repo= https://s3.amazonaws.com/ala-nameindexes/20140610

col_namematching_url= $(name_indexes_repo)/col_namematching.tgz
merged_namematching_url= $(name_indexes_repo)/merge_namematching.tgz
ala_namematching_url= $(name_indexes_repo)/namematching.tgz

collectory_war_url= http://nexus.ala.org.au/service/local/repositories/releases/content/au/org/ala/generic-collectory/1.4.3/generic-collectory-1.4.3.war

ala_names_distribution_url= http://nexus.ala.org.au/service/local/repositories/releases/content/au/org/ala/ala-name-matching/2.3.1/ala-name-matching-2.3.1-distribution.zip 

all: init build up

init:
	@echo "Pulling source code for dependencies..."
	mkdir -p mysql-datadir cassandra-datadir initdb lucene-datadir
	curl -L -s -o wait-for-it.sh \
		https://raw.githubusercontent.com/vishnubob/wait-for-it/master/wait-for-it.sh && \
		chmod +x wait-for-it.sh
	test -f cassandra/wait-for-it.sh || cp wait-for-it.sh cassandra/
	test -f tomcat/collectory.war || curl -o tomcat/collectory.war $(collectory_war_url)		
	test -f nameindex/namematching.tgz || curl -o nameindex/namematching.tgz $(col_namematching_url)
	test -f nameindex/nameindexer.zip || curl -o nameindex/nameindexer.zip $(ala_names_distribution_url)
	test -f nameindex/dwca-col.zip || curl -o nameindex/dwca-col.zip $(name_indexes_repo)/dwca-col.zip		
	test -f nameindex/dwca-col-mammals.zip || curl -o nameindex/dwca-col-mammals.zip $(name_indexes_repo)/dwca-col-mammals.zip
	test -f nameindex/IRMNG_DWC_HOMONYMS.zip || curl -o nameindex/IRMNG_DWC_HOMONYMS.zip $(name_indexes_repo)/IRMNG_DWC_HOMONYMS.zip
	test -f nameindex/col_vernacular.txt.zip || curl -o nameindex/col_vernacular.txt.zip $(name_indexes_repo)/col_vernacular.txt.zip

build:	
	@echo "Building Docker image..."
	docker-compose build --no-cache

up:
	@echo "Starting services..."
	docker-compose up -d

test:
	@echo "Opening up collectory..."
	firefox http://localhost:8080/collectory/ &

stop:
	@echo "Stopping services..."
	docker-compose stop

clean:
	@echo "Removing downloaded files and build artifacts"
	rm -f wait-for-it.sh
	#rm -f *.war

rm: stop
	@echo "Removing containers and persisted data"
	docker-compose rm -vf
	sudo rm -rf mysql-datadir cassandra-datadir initdb lucene-datadir

push:
	docker push $(NAME)

release: build push


#docker build -t solr:4.10 --no-cache .
#docker build -t cassandra:1.2 --no-cache .
