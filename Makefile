#! make

VERSION = $(TRAVIS_BUILD_ID)
ME = $(USER)
HOST = bioatlas.se
TS := $(shell date '+%Y_%m_%d_%H_%M')
PWD := $(shell pwd)
UID := $(shell id -u)
GID := $(shell id -g)

URL_COLLECTORY = https://github.com/bioatlas/ala-collectory/releases/download/1.5.5-SNAPSHOT/ala-collectory-1.5.5-SNAPSHOT.war
URL_NAMESDIST = http://nexus.ala.org.au/service/local/repositories/releases/content/au/org/ala/ala-name-matching/3.1/ala-name-matching-3.1-distribution.zip
URL_BIOCACHE_SERVICE = http://nexus.ala.org.au/service/local/repositories/releases/content/au/org/ala/biocache-service/2.1.1/biocache-service-2.1.1.war
URL_BIOCACHE_HUB = https://github.com/bioatlas/ala-hub/releases/download/3.0.10-SNAPSHOT/ala-hub-3.0.10-SNAPSHOT.war
URL_BIOCACHE_CLI = http://nexus.ala.org.au/service/local/repositories/releases/content/au/org/ala/biocache-store/2.2/biocache-store-2.2-distribution.zip
URL_LOGGER_SERVICE = http://nexus.ala.org.au/service/local/repositories/releases/content/au/org/ala/logger-service/2.3.5/logger-service-2.3.5.war
URL_IMAGE_SERVICE = https://github.com/bioatlas/image-service/releases/download/0.9.1-SNAPSHOT/ala-images.war
URL_API = https://github.com/bioatlas/webapi/releases/download/v0.3/webapi-2.0-SNAPSHOT.war
URL_GBIF_BACKBONE = http://rs.gbif.org/datasets/backbone/backbone-current.zip
URL_BIEHUB = https://nexus.ala.org.au/service/local/repositories/releases/content/au/org/ala/ala-bie/1.4.3/ala-bie-1.4.3.war
URL_BIEINDEX = https://github.com/bioatlas/bie-index/releases/download/1.4.3-SNAPSHOT/bie-index-1.4.3-SNAPSHOT.war
URL_SPECIESLIST = https://github.com/bioatlas/specieslist-webapp/releases/download/bas-3.0/specieslist-webapp-3.0.war
URL_BIOATLAS_WORDPRESS_THEME = https://github.com/bioatlas/bioatlas-wordpress-theme/archive/master.zip
URL_LAYERS_SERVICE = https://github.com/bioatlas/layers-service/releases/download/2.1-SNAPSHOT/layers-service.war
URL_LAYER_INGESTION = http://nexus.ala.org.au/service/local/repositories/snapshots/content/au/org/ala/layer-ingestion/1.0-SNAPSHOT/layer-ingestion-1.0-20160224.160123-13-bin.zip
URL_REGIONS = https://github.com/bioatlas/regions/releases/download/3.0-SNAPSHOT/regions-3.0-SNAPSHOT.war
URL_GEONETWORK = https://jaist.dl.sourceforge.net/project/geonetwork/GeoNetwork_opensource/v3.4.1/geonetwork.war
URL_SPATIAL_SERVICE = https://github.com/bioatlas/spatial-service/releases/download/0.3-SNAPSHOT/spatial-service-0.3-SNAPSHOT.war
URL_SPATIAL_HUB = https://github.com/bioatlas/spatial-hub/releases/download/0.3-SNAPSHOT/spatial-hub-0.3-SNAPSHOT.war
URL_CAS2 = https://github.com/bioatlas/ala-cas-2.0/releases/download/v0.1/cas.war
URL_USERDETAILS = https://github.com/bioatlas/userdetails/releases/download/bioatlas-1.0.0/userdetails-1.0.0.war
URL_APIKEY = https://github.com/bioatlas/apikey/releases/download/1.4-SNAPSHOT/apikey-1.4-SNAPSHOT.war
URL_JTS = http://central.maven.org/maven2/org/locationtech/jts/jts-core/1.15.0/jts-core-1.15.0.jar


all: init build up
.PHONY: all

init: theme-dl
	@echo "Caching files required for the build..."

	@test -f cassandra/wait-for-it.sh || \
		curl --progress -L -s -o cassandra/wait-for-it.sh \
		https://raw.githubusercontent.com/vishnubob/wait-for-it/master/wait-for-it.sh && \
		chmod +x cassandra/wait-for-it.sh

	@test -f collectory/collectory.war || \
		wget -q --show-progress -O collectory/collectory.war $(URL_COLLECTORY)

	@test -f nameindex/nameindexer.zip || \
		wget -q --show-progress -O nameindex/nameindexer.zip $(URL_NAMESDIST)

	@test -f nameindex/backbone.zip || \
		wget -q --show-progress -O nameindex/backbone.zip $(URL_GBIF_BACKBONE)

	@test -f biocacheservice/biocache-service.war || \
		wget -q --show-progress -O biocacheservice/biocache-service.war $(URL_BIOCACHE_SERVICE)

	@test -f biocachehub/ala-hub.war || \
		wget -q --show-progress -O biocachehub/ala-hub.war $(URL_BIOCACHE_HUB)

	@test -f biocachebackend/biocache.zip || \
		wget -q --show-progress -O biocachebackend/biocache.zip $(URL_BIOCACHE_CLI)

	@test -f loggerservice/logger-service.war || \
		wget -q --show-progress -O loggerservice/logger-service.war $(URL_LOGGER_SERVICE)

	@test -f imageservice/images.war || \
		wget -q --show-progress -O imageservice/images.war $(URL_IMAGE_SERVICE)

	@test -f api/api.war || \
		wget -q --show-progress -O api/api.war $(URL_API)

	@test -f biehub/ala-bie.war || \
		wget -q --show-progress -O biehub/ala-bie.war $(URL_BIEHUB)

	@test -f bieindex/bie-index.war || \
		wget -q --show-progress -O bieindex/bie-index.war $(URL_BIEINDEX)

	@test -f specieslists/specieslist-webapp.war || \
		wget -q --show-progress -O specieslists/specieslist-webapp.war $(URL_SPECIESLIST)

	@test -f layersservice/layers-service.war || \
		wget -q --show-progress -O layersservice/layers-service.war $(URL_LAYERS_SERVICE)

	@test -f layeringestion/layer-ingestion.zip || \
		wget -q --show-progress -O layeringestion/layer-ingestion.zip $(URL_LAYER_INGESTION)

	@test -f regions/regions.war || \
			wget -q --show-progress -O regions/regions.war $(URL_REGIONS)

	@test -f geonetwork/geonetwork.war || \
			wget -q --show-progress -O geonetwork/geonetwork.war $(URL_GEONETWORK)

	@test -f spatialservice/spatial-service.war || \
			wget -q --show-progress -O spatialservice/spatial-service.war $(URL_SPATIAL_SERVICE)

	@test -f spatialhub/spatial-hub.war || \
			wget -q --show-progress -O spatialhub/spatial-hub.war $(URL_SPATIAL_HUB)

	@test -f cas2/cas.war || \
			wget -q --show-progress -O cas2/cas.war $(URL_CAS2)

	@test -f userdetails/userdetails.war || \
			wget -q --show-progress -O userdetails/userdetails.war $(URL_USERDETAILS)

	@test -f apikey/apikey.war || \
			wget -q --show-progress -O apikey/apikey.war $(URL_APIKEY)

	@test -f solr7/lib/jts-core-1.15.0.jar || \
		wget -q --show-progress -O solr7/lib/jts-core-1.15.0.jar $(URL_JTS)

theme-dl:
	@echo "Downloading bioatlas wordpress theme..."
	@test -f wordpress/themes/atlas/master.zip || \
		mkdir -p wordpress/themes/atlas && \
		wget -q --show-progress -O wordpress/themes/atlas/master.zip $(URL_BIOATLAS_WORDPRESS_THEME) && \
		unzip -q -o wordpress/themes/atlas/master.zip -d wordpress/themes/atlas/

secrets:
	docker run --rm -it -v $(PWD):/tmp -u $(UID):$(GID) httpd:alpine bash -c \
		'printf "export SECRET_MYSQL_ROOT_PASSWORD=%b\n" \
			$$(cat /dev/urandom | tr -dc 'a-zA-Z0-9' | head -c 50) > /tmp/secrets && \
		printf "export SECRET_MYSQL_PASSWORD=%b\n" \
			$$(cat /dev/urandom | tr -dc 'a-zA-Z0-9' | head -c 50) >> /tmp/secrets && \
		printf "export SECRET_POSTGRES_PASSWORD=%b\n" \
			$$(cat /dev/urandom | tr -dc 'a-zA-Z0-9' | head -c 50) >> /tmp/secrets && \
		printf "export SECRET_MIRROREUM_PASSWORD=%b\n" \
			$$(cat /dev/urandom | tr -dc 'a-zA-Z0-9' | head -c 50) >> /tmp/secrets'

dotfiles: secrets htpasswd
	docker run --rm -it \
		-v $(PWD)/secrets:/etc/profile.d/secrets.sh \
		-v $(PWD):/tmp \
		-u $(UID):$(GID) \
		-w /tmp \
		nginx:alpine sh -l -c \
			'envsubst < env/envapi.template > env/.envapi && \
			envsubst < env/envcollectory.template > env/.envcollectory && \
			envsubst < env/envimage.template > env/.envimage && \
			envsubst < env/envlogger.template > env/.envlogger && \
			envsubst < env/envmirroreum.template > env/.envmirroreum && \
			envsubst < env/envwordpress.template > env/.envwordpress && \
			envsubst < env/envspecieslists.template > env/.envspecieslists && \
			envsubst < env/envpostgis.template > env/.envpostgis && \
			envsubst < env/envgeoserver.template > env/.envgeoserver &&\
			envsubst < env/envgeonetwork.template > env/.envgeonetwork && \
			envsubst < env/envgeonetworkdb.template > env/.envgeonetworkdb && \
			envsubst < env/envspatial.template > env/.envspatial && \
			envsubst < env/layersservice.template > env/.envlayersservice && \
			envsubst < env/envcas.template > env/.envcas && \
			envsubst < env/envapikey.template > env/.envapikey'
	touch dotfiles

htpasswd:
	docker run --rm -it httpd:alpine htpasswd -nb admin admin > env/.htpasswd

init-clean:
	@echo "Removing cached files from the build"
	rm -f cassandra/wait-for-it.sh \
		collectory/collectory.war \
		nameindex/nameindexer.zip \
		nameindex/backbone.zip \
		biocacheservice/biocache-service.war \
		biocachehub/ala-hub.war \
		biocachebackend/biocache.zip \
		loggerservice/logger-service.war \
		imageservice/images.war \
		api/api.war \
		biehub/ala-bie.war \
		bieindex/bie-index.war \
		specieslists/specieslist-webapp.war \
		layersservice/layers-service.war \
		layeringestion/layer-ingestion.zip \
		regions/regions.war \
		geonetwork/geonetwork.war \
		spatialservice/spatial-service.war \
		spatialhub/spatial-hub.war \
		cas2/cas.war \
		userdetails/userdetails.war \
		apikey/apikey.war \
		solr7/lib/jts-core-1.15.0.jar

dotfiles-clean:
	rm -f secrets && \
		cd env && \
		rm -f .envapi .envcollectory .envimage .envlogger .envmirroreum .envwordpress .htpasswd .envspecieslists .envpostgis .envgeoserver .envgeonetwork .envgeonetworkdb .envspatial .envlayersservice .envcas .envapikey

clean:
	docker-compose down
	docker volume rm aladocker_data_biocachebackend aladocker_data_images aladocker_data_images_elasticsearch aladocker_data_nameindex aladocker_data_solr aladocker_db_data_apiservice aladocker_db_data_cassandra aladocker_db_data_collectory aladocker_db_data_imageservice aladocker_db_data_loggerservice aladocker_db_data_loggerservice aladocker_db_data_wordpress aladocker_db_data_specieslists

build:
	@echo "Building images..."
	@docker build -t bioatlas/ala-biocachebackend:v0.2 biocachebackend
	@docker build -t bioatlas/ala-nameindex:v0.2 nameindex
	@docker build -t bioatlas/ala-biocachehub:v0.2 biocachehub
	@docker build -t bioatlas/ala-collectory:v0.2 collectory
	@docker build -t bioatlas/ala-biocacheservice:v0.2 biocacheservice
	@docker build -t bioatlas/ala-loggerservice:v0.2 loggerservice
	@docker build -t bioatlas/ala-imageservice:v0.2 imageservice
	@docker build -t bioatlas/ala-imagestore:v0.2 imagestore
	@docker build -t bioatlas/ala-api:v0.2 api
	@docker build -t bioatlas/ala-specieslists:v0.2 specieslists
	@docker build -t bioatlas/ala-bieindex:v0.2 bieindex
	@docker build -t bioatlas/ala-biehub:v0.2 biehub
	@docker build -t bioatlas/ala-layersservice:v0.2 layersservice
	@docker build -t bioatlas/ala-layeringestion:v0.2 layeringestion
	@docker build -t bioatlas/ala-regions:v0.2 regions
	@docker build -t bioatlas/ala-spatialhub:v0.2 spatialhub
	@docker build -t bioatlas/ala-spatialservice:v0.2 spatialservice
	@docker build -t bioatlas/ala-geoserver:v0.2 geoserver
	@docker build -t bioatlas/ala-cas:v0.2 cas2
	@docker build -t bioatlas/ala-userdetails:v0.2 userdetails
	@docker build -t bioatlas/ala-apikey:v0.2 apikey

up:
	@echo "Starting services..."
	@docker-compose up -d

stop:
	@echo "Stopping services..."
	@docker-compose stop

pull:
	@echo "Downloading docker images for ALA modules..."
	@docker pull bioatlas/ala-biocachebackend:v0.2
	@docker pull bioatlas/ala-nameindex:v0.2
	@docker pull bioatlas/ala-biocachehub:v0.2
	@docker pull bioatlas/ala-collectory:v0.2
	@docker pull bioatlas/ala-biocacheservice:v0.2
	@docker pull bioatlas/ala-loggerservice:v0.2
	@docker pull bioatlas/ala-imageservice:v0.2
	@docker pull bioatlas/ala-imagestore:v0.2
	@docker pull bioatlas/ala-api:v0.2
	@docker pull bioatlas/ala-specieslists:v0.2
	@docker pull bioatlas/ala-bieindex:v0.2
	@docker pull bioatlas/ala-biehub:v0.2
	@docker pull bioatlas/ala-layersservice:v0.2
	@docker pull bioatlas/ala-layeringestion:v0.2
	@docker pull bioatlas/ala-regions:v0.2
	@docker pull bioatlas/ala-spatialhub:v0.2
	@docker pull bioatlas/ala-spatialservice:v0.2
	@docker pull bioatlas/ala-geoserver:v0.2
	@docker pull bioatlas/ala-cas:v0.2
	@docker pull bioatlas/ala-userdetails:v0.2
	@docker pull bioatlas/ala-apikey:v0.2

pull2:
	@echo "Downloading other official docker images ..."
	@docker pull mysql:5.7
	@docker pull cassandra:3.11.2
	@docker pull postgres:9.6.8-alpine
	@docker pull solr:7.3-alpine
	@docker pull wordpress:4.9.5-apache
	@docker pull nginx:alpine
	@docker pull andyshinn/dnsmasq:2.76
	@docker pull jwilder/nginx-proxy

push:
	@docker push bioatlas/ala-biocachebackend:v0.2
	@docker push bioatlas/ala-nameindex:v0.2
	@docker push bioatlas/ala-biocachehub:v0.2
	@docker push bioatlas/ala-collectory:v0.2
	@docker push bioatlas/ala-biocacheservice:v0.2
	@docker push bioatlas/ala-loggerservice:v0.2
	@docker push bioatlas/ala-imageservice:v0.2
	@docker push bioatlas/ala-imagestore:v0.2
	@docker push bioatlas/ala-api:v0.2
	@docker push bioatlas/ala-specieslists:v0.2
	@docker push bioatlas/ala-bieindex:v0.2
	@docker push bioatlas/ala-biehub:v0.2
	@docker push bioatlas/ala-layersservice:v0.2
	@docker push bioatlas/ala-layeringestion:v0.2
	@docker push bioatlas/ala-regions:v0.2
	@docker push bioatlas/ala-spatialhub:v0.2
	@docker push bioatlas/ala-spatialservice:v0.2
	@docker push bioatlas/ala-geoserver:v0.2
	@docker push bioatlas/ala-cas:v0.2
	@docker push bioatlas/ala-userdetails:v0.2
	@docker push bioatlas/ala-apikey:v0.2

release: build push

ssl-certs:
	@echo "Generating SSL certs using https://hub.docker.com/r/paulczar/omgwtfssl/"
	docker run --rm -v /tmp/certs:/certs -e SSL_SUBJECT=bioatlas.se paulczar/omgwtfssl
	mkdir -p nginx-proxy-certs
	cp /tmp/certs/ca.pem /tmp/certs/cert.pem /tmp/certs/key.pem nginx-proxy-certs
	cd nginx-proxy-certs && mv key.pem bioatlas.se.key && mv cert.pem bioatlas.se.crt

	@echo "Using self-signed certificates will require either the CA cert to be imported system-wide or into apps"
	@echo "if you don't do this, apps will fail to request data using SSL (https)"
	@echo "WARNING! You now need to import the /tmp/certs/ca.pem file into Firefox/Chrome etc"
	@echo "WARNING! For curl to work, you need to provide '--cacert /tmp/certs/ca.pem' switch or SSL requests will fail."

ssl-certs-clean:
	rm -f nginx-proxy-certs/bioatlas.se.crt nginx-proxy-certs/bioatlas.se.key nginx-proxy-certs/ca.pem
	sudo rm -rf /tmp/certs

ssl-certs-show:
	openssl x509 -noout -text -in nginx-proxy-certs/bioatlas.se.crt
