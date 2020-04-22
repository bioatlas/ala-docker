# Branch of the ala-docker deployed at NRM, decommissioned in April 2020.

# Check the master or the develop branch

# Docker version of Atlas of Living Australia

This is currently Work In Progress! Beware!

# Usage

You need `git`, `make`, `docker`(v 17.04.0-ce was used) and `docker-compose` (v 1.11.2 was used). 

Clone the repo with

	git clone --depth=1 $REPO_SLUG

Build and start services with
	
	make  # build images and start containers
	
Other commands include
	make test  # verify that services run
	make release  # push a tagged images to Docker Hub

## Considerations

Note that building the system from scratch (with `make`, `make all` will run which starts with `make init` to get files then `make build` to build images locally and then `make up` to start services) is a lengthy step that takes some time to complete, especially if on a slow Internet connection. 

On a laptop with poor Internet connection, expect the initial sources dl step to take at least 20 minutes and the build step to take another 20 minutes. Approx 10-15 images will be built, most around a couple of hundred MB large b are larger - the nameindex and the biocache backend. All can be `docker images | grep ala`.

The steps that downloads sources and build images locally can be skipped and recent binaries can instead be pulled directly from Docker Hub, using `make up` which relies on `docker-compose.yml` using appropriate image tags and versions.


