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
	test -f tomcat/collectory.war || curl -o tomcat/collectory.war \
		http://nexus.ala.org.au/service/local/repositories/releases/content/au/org/ala/generic-collectory/1.4.3/generic-collectory-1.4.3.war

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
	sudo rm -rf mysql-datadir cassandra-datadir initdb data

push:
	docker push $(NAME)

release: build push
