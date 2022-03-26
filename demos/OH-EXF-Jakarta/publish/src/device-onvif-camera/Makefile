# Include base Makefile
include ../../make/base.mk

# Define and export service specific variables
export VERSION_SUFFIX=-dev
export IMAGE_NAME ?= $(current_folder_name)
export DOCKER_IMAGE_BASE ?= localhost:5000/$(IMAGE_NAME)

# Include service template file
include ../../make/service-template.mk

.PHONY: build push

publish-service: build push fetch $(SERVICE_JSON_OUTPUT)
	hzn exchange service publish -O -f "$(SERVICE_JSON_OUTPUT)" --pull-image

build: src fetch
	@echo "building docker image..."
	make -C src docker

fetch:
	@echo "fetching latest code..."
	cd src && git pull

push: build
	@echo "tagging docker image..."
	docker tag "$(DOCKER_BASE)/$(IMAGE_NAME):$(DOCKER_IMAGE_VERSION)" "$(DOCKER_IMAGE_BASE):$(DOCKER_IMAGE_VERSION)"
	@echo "pushing docker image..."
	docker push "$(DOCKER_IMAGE_BASE):$(DOCKER_IMAGE_VERSION)"

src:
	@echo "cloning..."
	git clone https://github.com/edgexfoundry-holding/device-onvif-camera.git src
