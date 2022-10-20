# Copyright (C) 2022 Intel Corporation
# SPDX-License-Identifier: Apache-2.0

# Include base Makefile
include ../../make/base.mk

# Define and export service specific variables
export DOCKER_REGISTRY=$(LOCAL_DOCKER_REGISTRY)
export DOCKER_ORG=$(LOCAL_DOCKER_ORG)

# Include service template file
include ../../make/service-template.mk

.PHONY: build push

publish-service: build push $(SERVICE_JSON_OUTPUT) login
	hzn exchange service publish -O -f "$(SERVICE_JSON_OUTPUT)" --pull-image $(if $(LOCAL_DOCKER_USERNAME),-r "$(DOCKER_REGISTRY):$(LOCAL_DOCKER_USERNAME):$${LOCAL_DOCKER_API_KEY_RO_PULL}",)

build:
	@echo "building docker image..."
	docker build -f "Dockerfile" -t "$(DOCKER_FULL_IMAGE_NAME)" ../

push: build login
	@echo "pushing docker image..."
	docker push "$(DOCKER_FULL_IMAGE_NAME)"
