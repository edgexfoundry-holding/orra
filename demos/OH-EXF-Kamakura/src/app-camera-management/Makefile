# Copyright (C) 2022 Intel Corporation
# SPDX-License-Identifier: Apache-2.0

# Include base Makefile
include ../../make/base.mk

# Define and export service specific variables
export VERSION_SUFFIX=-dev
export DOCKER_REGISTRY=$(LOCAL_DOCKER_REGISTRY)
export DOCKER_ORG=$(LOCAL_DOCKER_ORG)

# Include service template file
include ../../make/service-template.mk

.PHONY: build push clean

publish-service: build push $(SERVICE_JSON_OUTPUT) login
	hzn exchange service publish -O -f "$(SERVICE_JSON_OUTPUT)" --pull-image $(if $(LOCAL_DOCKER_USERNAME),-r "$(DOCKER_REGISTRY):$(LOCAL_DOCKER_USERNAME):$${LOCAL_DOCKER_API_KEY_RO_PULL}",)

build: src
	@echo "building docker image..."
	$(MAKE) -C src/application-services/custom/camera-management docker

push: build login
	@echo "tagging docker image..."
	docker tag "edgexfoundry/$(IMAGE_NAME):$(DOCKER_IMAGE_VERSION)" "$(DOCKER_FULL_IMAGE_NAME)"
	@echo "pushing docker image..."
	docker push "$(DOCKER_FULL_IMAGE_NAME)"

clean:
	rm -rf $(SRC_DIR)

src:
	@echo "cloning..."
	git clone --depth=1 --branch $(TAG_edgex_examples) $(REPO_URL_edgex_examples) src
