# Include base Makefile
include ../../make/base.mk

# Define and export service specific variables
export IMAGE_NAME ?= $(current_folder_name)
export DOCKER_IMAGE_BASE ?= localhost:5000/$(IMAGE_NAME)

# Include service template file
include ../../make/service-tmpl.mk

.PHONY: build push

publish-service: build push $(SERVICE_JSON_OUTPUT)
	hzn exchange service publish -O -f "$(SERVICE_JSON_OUTPUT)" --pull-image

build:
	@echo "building docker image..."
	docker build -t "$(DOCKER_IMAGE_BASE):$(DOCKER_IMAGE_VERSION)" .

push: build
	@echo "pushing docker image..."
	docker push "$(DOCKER_IMAGE_BASE):$(DOCKER_IMAGE_VERSION)"
