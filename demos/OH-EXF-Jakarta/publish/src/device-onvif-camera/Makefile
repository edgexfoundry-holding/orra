# Include base Makefile
include ../../make/base.mk

# Define and export service specific variables
export IMAGE_NAME=device-onvif-camera
export DOCKER_IMAGE_BASE=$(DOCKER_BASE)/$(IMAGE_NAME)-dev
export SERVICE_NAME=$(EDGE_OWNER).$(EDGE_DEPLOY).$(IMAGE_NAME)
export SERVICE_VERSION=0.0.0

# Include service template file
include ../../make/service-tmpl.mk

.PHONY: build

publish-service: build
	hzn exchange service publish -O -f service.definition.json --dont-change-image-tag

build: src
	@echo "fetching latest code..."
	cd src && git pull
	@echo "building..."
	make -C src docker

src:
	@echo "cloning..."
	git clone https://github.com/edgexfoundry-holding/device-onvif-camera.git src
