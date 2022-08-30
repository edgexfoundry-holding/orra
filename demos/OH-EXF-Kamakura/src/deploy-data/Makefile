# Copyright (C) 2022 Intel Corporation
# SPDX-License-Identifier: Apache-2.0

# Include base Makefile
include ../../make/base.mk

# Define and export service specific variables
export DOCKER_REGISTRY_BASE=$(LOCAL_DOCKER_REGISTRY:%=%/)

# Include service template file
include ../../make/service-template.mk

.PHONY: build push

publish-service: build push $(SERVICE_JSON_OUTPUT)
	hzn exchange service publish -O -f "$(SERVICE_JSON_OUTPUT)" --pull-image

build:
	@echo "building docker image..."
	docker build -f "Dockerfile" -t "$(DOCKER_FULL_IMAGE_NAME)" ../

push: build
	@echo "pushing docker image..."
	docker push "$(DOCKER_FULL_IMAGE_NAME)"
