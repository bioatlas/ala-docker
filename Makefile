NAME = dina-web/ala-docker
VERSION = $(TRAVIS_BUILD_ID)
ME = $(USER)
HOST = ala.dina-web.net
TS := $(shell date '+%Y_%m_%d_%H_%M')

name_indexes_repo:= https://s3.amazonaws.com/ala-nameindexes/20140610
col_namematching_url:= $(name_indexes_repo)/col_namematching.tgz
merged_namematching_url:= $(name_indexes_repo)/merge_namematching.tgz
ala_namematching_url:= $(name_indexes_repo)/namematching.tgz
ala_names_distribution_url:= 

collectory_war_url:= http://nexus.ala.org.au/service/local/repositories/releases/content/au/org/ala/generic-collectory/1.4.3/generic-collectory-1.4.3.war

all: init build up

init:
	@echo "Pulling source code for dependencies..."
	mkdir -p mysql-datadir cassandra-datadir initdb lucene-datadir
	curl -L -s -o wait-for-it.sh \
		https://raw.githubusercontent.com/vishnubob/wait-for-it/master/wait-for-it.sh && \
		chmod +x wait-for-it.sh
	test -f tomcat/collectory.war || curl -o tomcat/collectory.war $(collectory_war_url)		
	test -f nameindex/namematching.tgz || curl -o nameindex/namematching.tgz $(col_namematching_url)

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
