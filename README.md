# Docker version of Atlas of Living Australia

This is currently Work In Progress! Beware!

# Usage

You need `git`, `make`, `docker` and `docker-compose` (v 1.8 was used). 

Clone the repo with

	git clone --depth=1 $REPO_SLUG

Manage services with
	
	make  # build images and start containers
	make test  # verify that services run
	make release  # push a tagged images to Docker Hub

