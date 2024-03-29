# Copyright (C) 2022 Intel Corporation
# SPDX-License-Identifier: Apache-2.0

# Include base Makefile
include ../../make/base.mk

# Define and export service specific variables
export DOCKER_REGISTRY=$(LOCAL_DOCKER_REGISTRY)
export DOCKER_ORG=$(LOCAL_DOCKER_ORG)

# Include service template file
include ../../make/service-template.mk

SRC_DIR = src
MODELS_LIST = models.list.yml
MODELS_DIR = models

.PHONY: build push download-models clean

publish-service: build push $(SERVICE_JSON_OUTPUT) login
	hzn exchange service publish -O -f "$(SERVICE_JSON_OUTPUT)" --pull-image $(if $(LOCAL_DOCKER_USERNAME),-r "$(DOCKER_REGISTRY):$(LOCAL_DOCKER_USERNAME):$${LOCAL_DOCKER_API_KEY_RO_PULL}",)

build: $(SRC_DIR) download-models
	@echo "building docker image..."
	docker build -t "$(DOCKER_FULL_IMAGE_NAME)" .

push: build login
	@echo "pushing docker image..."
	docker push "$(DOCKER_FULL_IMAGE_NAME)"

$(SRC_DIR):
	@echo "cloning..."
	git clone --depth=1 --branch $(TAG_model_downloader) $(REPO_URL_model_downloader) $@

clean:
	rm -rf $(SRC_DIR)
	rm -rf $(MODELS_DIR)

$(MODELS_DIR):
	mkdir -p $@

download-models: $(SRC_DIR) $(MODELS_LIST) | $(MODELS_DIR)
	docker run -it \
           --rm \
           -e HOME=/tmp \
           -v $(CURDIR)/$(SRC_DIR)/tools:/tools \
           -v $(CURDIR)/$(MODELS_LIST):/models.list.yml \
           -v $(CURDIR)/$(MODELS_DIR):/output/models \
           --entrypoint /bin/bash \
           --name openvino-model-downloader \
           --user "$$(id -u)" \
           -w /tools \
           $(OPENVINO_DATA_IMAGE) \
                -i -c 'pip3 install -r model_downloader/requirements.txt; \
                       python3 -u model_downloader \
                               --model-proc-version v1.5 \
                               --model-list /models.list.yml \
                               --output /output'
