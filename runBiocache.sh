#!/bin/sh

echo "Creating volume for nameindex using global nameindex data"

docker volume create --driver local \
    --opt type=none \
    --opt device=/docker_nfs/var/volumes/data_nameindex \
    --opt o=bind ala_data_nameindex

echo "Creating volume for biocachebackend"

docker volume create --driver local \
    --opt type=none \
    --opt device=/docker_nfs/var/volumes/data_biocachebackend \
    --opt o=bind ala_data_biocachebackend

echo "Starting biocachebackend container"

docker run --rm --network=basnet \
-v ala_data_nameindex:/data/lucene/namematching \
-v ala_data_biocachebackend:/data \
--mount type=bind,source="$(pwd)"/config/blacklistMediaUrls.txt,target=/data/biocache/config/blacklistMediaUrls.txt \
--mount type=bind,source="$(pwd)"/config/biocache-config.properties,target=/data/biocache/config/biocache-config.properties  \
--mount type=bind,source=/data/temp,target=/tmp \
-e BIOCACHE_MEMORY_OPTS="-Xmx16g -Xms1g" \
-it bioatlas/ala-biocachebackend:v2.6.1 bash

