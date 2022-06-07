# Include base Makefile
include ../../make/base.mk

# Define and export service specific variables
export DOCKER_REGISTRY_BASE=$(LOCAL_DOCKER_REGISTRY:%=%/)

# Include service template file
include ../../make/service-template.mk

SRC_DIR = src
MODELS_LIST = models.list.yml
MODELS_DIR = models

.PHONY: build push download-models clean

publish-service: build push $(SERVICE_JSON_OUTPUT)
	hzn exchange service publish -O -f "$(SERVICE_JSON_OUTPUT)" --pull-image

build: $(SRC_DIR) download-models
	@echo "building docker image..."
	docker build -t "$(DOCKER_FULL_IMAGE_NAME)" .

push: build
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
