#! make

VERSION = $(TRAVIS_BUILD_ID)
ME = $(USER)
HOST = bioatlas.se
TS := $(shell date '+%Y_%m_%d_%H_%M')
PWD := $(shell pwd)
UID := $(shell id -u)
GID := $(shell id -g)

URL_NAMEIDX = https://s3.amazonaws.com/ala-nameindexes/20140610
URL_COLLECTORY = https://github.com/bioatlas/ala-collectory/releases/download/1.5.5-SNAPSHOT/ala-collectory-1.5.5-SNAPSHOT.war
URL_NAMESDIST = https://nexus.ala.org.au/service/local/repositories/releases/content/au/org/ala/ala-name-matching/3.3/ala-name-matching-3.3-distribution.zip
URL_BIOCACHE_SERVICE = https://nexus.ala.org.au/service/local/repositories/releases/content/au/org/ala/biocache-service/2.1.14/biocache-service-2.1.14.war
URL_BIOCACHE_HUB = https://github.com/bioatlas/ala-hub/releases/download/BAS-3.0.13-SNAPSHOT/ala-hub-3.0.13-SNAPSHOT.war
URL_BIOCACHE_CLI = https://nexus.ala.org.au/service/local/repositories/releases/content/au/org/ala/biocache-store/2.4.1/biocache-store-2.4.1-distribution.zip
URL_LOGGER_SERVICE = http://nexus.ala.org.au/service/local/repositories/releases/content/au/org/ala/logger-service/2.3.5/logger-service-2.3.5.war
URL_IMAGE_SERVICE = https://github.com/bioatlas/image-service/releases/download/0.9.1-SNAPSHOT/ala-images.war
URL_API = https://github.com/bioatlas/webapi/releases/download/v0.3/webapi-2.0-SNAPSHOT.war
URL_GBIF_BACKBONE = http://rs.gbif.org/datasets/backbone/backbone-current.zip
URL_BIEHUB = https://github.com/bioatlas/ala-bie/releases/download/BAS-1.4.12-SNAPSHOT/ala-bie-1.4.12-SNAPSHOT.war
URL_BIEINDEX = https://github.com/bioatlas/bie-index/releases/download/BAS-1.4.3-SNAPSHOT/bie-index-1.4.3-SNAPSHOT.war
URL_SPECIESLIST = https://github.com/bioatlas/specieslist-webapp/releases/download/BAS-3.1/specieslist-webapp-3.1.war
#URL_BIOATLAS_WORDPRESS_THEME = https://github.com/bioatlas/bioatlas-wordpress-theme/archive/master.zip
URL_BIOATLAS_WORDPRESS_THEME = https://github.com/bioatlas/bioatlas-wordpress-theme/archive/beta.zip
URL_LAYERS_SERVICE = https://github.com/bioatlas/layers-service/releases/download/2.1-SNAPSHOT/layers-service.war
URL_LAYER_INGESTION = http://nexus.ala.org.au/service/local/repositories/snapshots/content/au/org/ala/layer-ingestion/1.0-SNAPSHOT/layer-ingestion-1.0-20160224.160123-13-bin.zip
URL_REGIONS = https://github.com/bioatlas/regions/releases/download/BAS-3.1-SNAPSHOT/regions-3.1-SNAPSHOT.war
URL_GEONETWORK = https://jaist.dl.sourceforge.net/project/geonetwork/GeoNetwork_opensource/v3.4.1/geonetwork.war
URL_SPATIAL_SERVICE = https://github.com/bioatlas/spatial-service/releases/download/BAS-0.3-SNAPSHOT/spatial-service-0.3-SNAPSHOT.war
URL_SPATIAL_HUB = https://github.com/bioatlas/spatial-hub/releases/download/BAS-0.3-SNAPSHOT/spatial-hub-0.3-SNAPSHOT.war
URL_CAS2 = https://github.com/bioatlas/ala-cas-2.0/releases/download/v0.1/cas.war
URL_USERDETAILS = https://github.com/bioatlas/userdetails/releases/download/bioatlas-1.0.0/userdetails-1.0.0.war
URL_APIKEY = https://github.com/bioatlas/apikey/releases/download/1.4-SNAPSHOT/apikey-1.4-SNAPSHOT.war
URL_JTS = http://central.maven.org/maven2/org/locationtech/jts/jts-core/1.15.0/jts-core-1.15.0.jar
URL_DYNTAXA = https://api.artdatabanken.se/taxonservice/v1/DarwinCore/DarwinCoreArchiveFile?Subscription-Key=4b068709e7f2427d9fc76bf42d8e2b57
URL_DASHBOARD = https://nexus.ala.org.au/service/local/repositories/releases/content/au/org/ala/dashboard/2.1.1/dashboard-2.1.1.war

all: init build dotfiles up
shortcut: pull pull2 dotfiles up

.PHONY: all shortcut

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

	@test -f nameindex/IRMNG_DWC_HOMONYMS.zip || \
		curl --progress -o nameindex/IRMNG_DWC_HOMONYMS.zip $(URL_NAMEIDX)/IRMNG_DWC_HOMONYMS.zip

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

	@test -f dyntaxa-index/dyntaxa.dwca.zip || \
		wget -q --show-progress -O dyntaxa-index/dyntaxa.dwca.zip $(URL_DYNTAXA)

	@test -f dyntaxa-index/nameindexer.zip || \
		wget -q --show-progress -O dyntaxa-index/nameindexer.zip $(URL_NAMESDIST)

	@test -f dashboard/dashboard.war || \
		wget -q --show-progress -O dashboard/dashboard.war $(URL_DASHBOARD)


theme-dl:
	@echo "Downloading bioatlas wordpress theme..."
	@test -f wordpress/themes/atlas/beta.zip || \
		mkdir -p wordpress/themes/atlas && \
		wget -q --show-progress -O wordpress/themes/atlas/beta.zip $(URL_BIOATLAS_WORDPRESS_THEME) && \
		unzip -q -o wordpress/themes/atlas/beta.zip -d wordpress/themes/atlas/

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
		solr7/lib/jts-core-1.15.0.jar \
		dashboard/dashboard.war

dotfiles-clean:
	rm -f secrets && \
		cd env && \
		rm -f .envapi .envcollectory .envimage .envlogger .envmirroreum .envwordpress .htpasswd .envspecieslists .envpostgis .envgeoserver .envgeonetwork .envgeonetworkdb .envspatial .envlayersservice .envcas .envapikey

clean:
	docker-compose down
	docker volume rm ala-docker_data_bieindex ala-docker_data_biocachebackend ala-docker_data_geonetwork ala-docker_data_geoserver ala-docker_data_images ala-docker_data_images_elasticsearch ala-docker_data_layersservice ala-docker_data_nameindex ala-docker_data_solr ala-docker_data_spatialhub ala-docker_data_spatialservice ala-docker_data_wordpress ala-docker_db_data_apiservice ala-docker_db_data_cassandra ala-docker_db_data_collectory ala-docker_db_data_geonetworkdb ala-docker_db_data_imageservice ala-docker_db_data_loggerservice ala-docker_db_data_mysqldbapikey ala-docker_db_data_mysqldbcas ala-docker_db_data_postgis ala-docker_db_data_specieslists ala-docker_db_data_wordpress

build:
	@echo "Building images..."
	@docker build -t bioatlas/ala-biocachebackend -t bioatlas/ala-biocachebackend:v0.5 biocachebackend
	@docker build -t bioatlas/ala-biocachehub -t bioatlas/ala-biocachehub:v0.5 biocachehub
	@docker build -t bioatlas/ala-collectory -t bioatlas/ala-collectory:v0.3 collectory
	@docker build -t bioatlas/ala-biocacheservice -t bioatlas/ala-biocacheservice:v0.4 biocacheservice
	@docker build -t bioatlas/ala-loggerservice -t bioatlas/ala-loggerservice:v0.3 loggerservice
	@docker build -t bioatlas/ala-imageservice -t bioatlas/ala-imageservice:v0.4 imageservice
	@docker build -t bioatlas/ala-imagestore -t bioatlas/ala-imagestore:v0.3 imagestore
	@docker build -t bioatlas/ala-api -t bioatlas/ala-api:v0.3 api
	@docker build -t bioatlas/ala-specieslists -t bioatlas/ala-specieslists:v0.4 specieslists
	@docker build -t bioatlas/ala-bieindex -t bioatlas/ala-bieindex:v0.5 bieindex
	@docker build -t bioatlas/ala-biehub -t bioatlas/ala-biehub:v0.4 biehub
	@docker build -t bioatlas/ala-layersservice -t bioatlas/ala-layersservice:v0.4 layersservice
	@docker build -t bioatlas/ala-layeringestion -t bioatlas/ala-layeringestion:v0.3 layeringestion
	@docker build -t bioatlas/ala-regions -t bioatlas/ala-regions:v0.4 regions
	@docker build -t bioatlas/ala-spatialhub -t bioatlas/ala-spatialhub:v0.4 spatialhub
	@docker build -t bioatlas/ala-spatialservice -t bioatlas/ala-spatialservice:v0.4 spatialservice
	@docker build -t bioatlas/ala-geoserver -t bioatlas/ala-geoserver:v0.3 geoserver
	@docker build -t bioatlas/ala-cas -t bioatlas/ala-cas:v0.3 cas2
	@docker build -t bioatlas/ala-userdetails -t bioatlas/ala-userdetails:v0.3 userdetails
	@docker build -t bioatlas/ala-apikey -t bioatlas/ala-apikey:v0.3 apikey
	@docker build -t bioatlas/ala-cassandra -t bioatlas/ala-cassandra:v0.3 cassandra3
	@docker build -t bioatlas/ala-solr -t bioatlas/ala-solr:v0.3 solr7
	@docker build -t bioatlas/ala-dyntaxaindex -t bioatlas/ala-dyntaxaindex:v0.3 dyntaxa-index
	@docker build -t bioatlas/ala-nameindex -t bioatlas/ala-nameindex:v0.3 nameindex
#	@docker build -t bioatlas/ala-dashboard -t bioatlas/ala-dashboard:v0.3 dashboard

up:
	@echo "Starting services..."
	@docker-compose up -d

stop:
	@echo "Stopping services..."
	@docker-compose stop

pull:
	@echo "Downloading docker images for ALA modules..."
	@docker pull bioatlas/ala-biocachebackend:v0.5
	@docker pull bioatlas/ala-biocachehub:v0.5
	@docker pull bioatlas/ala-collectory:v0.3
	@docker pull bioatlas/ala-biocacheservice:v0.4
	@docker pull bioatlas/ala-loggerservice:v0.3
	@docker pull bioatlas/ala-imageservice:v0.4
	@docker pull bioatlas/ala-imagestore:v0.3
	@docker pull bioatlas/ala-api:v0.3
	@docker pull bioatlas/ala-specieslists:v0.4
	@docker pull bioatlas/ala-bieindex:v0.5
	@docker pull bioatlas/ala-biehub:v0.4
	@docker pull bioatlas/ala-layersservice:v0.4
	@docker pull bioatlas/ala-layeringestion:v0.3
	@docker pull bioatlas/ala-regions:v0.4
	@docker pull bioatlas/ala-spatialhub:v0.4
	@docker pull bioatlas/ala-spatialservice:v0.4
	@docker pull bioatlas/ala-geoserver:v0.3
	@docker pull bioatlas/ala-cas:v0.3
	@docker pull bioatlas/ala-userdetails:v0.3
	@docker pull bioatlas/ala-apikey:v0.3
	@docker pull bioatlas/ala-cassandra:v0.3
	@docker pull bioatlas/ala-solr:v0.3
	@docker pull bioatlas/ala-dyntaxaindex:v0.3
	@docker pull bioatlas/ala-nameindex:v0.3

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
	@echo "Pushing images to Dockerhub..."
	@docker push bioatlas/ala-biocachebackend:v0.5
	@docker push bioatlas/ala-biocachehub:v0.5
	@docker push bioatlas/ala-collectory:v0.3
	@docker push bioatlas/ala-biocacheservice:v0.4
	@docker push bioatlas/ala-loggerservice:v0.3
	@docker push bioatlas/ala-imageservice:v0.4
	@docker push bioatlas/ala-imagestore:v0.3
	@docker push bioatlas/ala-api:v0.3
	@docker push bioatlas/ala-specieslists:v0.4
	@docker push bioatlas/ala-bieindex:v0.5
	@docker push bioatlas/ala-biehub:v0.4
	@docker push bioatlas/ala-layersservice:v0.4
	@docker push bioatlas/ala-layeringestion:v0.3
	@docker push bioatlas/ala-regions:v0.4
	@docker push bioatlas/ala-spatialhub:v0.4
	@docker push bioatlas/ala-spatialservice:v0.4
	@docker push bioatlas/ala-geoserver:v0.3
	@docker push bioatlas/ala-cas:v0.3
	@docker push bioatlas/ala-userdetails:v0.3
	@docker push bioatlas/ala-apikey:v0.3
	@docker push bioatlas/ala-cassandra:v0.3
	@docker push bioatlas/ala-solr:v0.3
	@docker push bioatlas/ala-dyntaxaindex:v0.3
	@docker push bioatlas/ala-nameindex:v0.3

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

test-nameindex:
	docker run --rm -it bioatlas/ala-nameindex nameindexer -testSearch "Rattus norvegicus"

test-dc:
	docker-compose run --rm nameindex
	docker-compose run --rm nameindex nameindexer -testSearch "Rattus norvegicus"
	docker-compose run --rm biocachebackend


