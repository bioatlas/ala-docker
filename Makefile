NAME = dina-web/ala-docker
VERSION = $(TRAVIS_BUILD_ID)
ME = $(USER)
HOST = ala.dina-web.net
TS := $(shell date '+%Y_%m_%d_%H_%M')


all: init build up

init:
	@echo "Pulling source code for dependencies..."
	mkdir -p mysql-datadir cassandra-datadir initdb
	curl -L -s -o wait-for-it.sh \
		https://raw.githubusercontent.com/vishnubob/wait-for-it/master/wait-for-it.sh && \
		chmod +x wait-for-it.sh
	curl -o tomcat/collectory.war http://nexus.ala.org.au/service/local/repositories/releases/content/au/org/ala/generic-collectory/1.4.3/generic-collectory-1.4.3.war

build:
	@echo "Building Docker image..."
	docker-compose build collectory_as

up: 
	@echo "Starting services..."
	docker-compose up -d

stop:
	@echo "Stopping services..."
	docker-compose stop

clean:
	@echo "Removing code and persisted db data..."
	sudo rm -rf wait-for-it.sh
	sudo rm -f *.war

rm: stop clean
	docker-compose rm -vf
	sudo rm -rf mysql-datadir cassandra-datadir initdb

push:
	docker push $(NAME)

release: build push
