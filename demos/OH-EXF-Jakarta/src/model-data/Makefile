# Include base Makefile
include ../../make/base.mk

# Define and export service specific variables
export VERSION_SUFFIX=
export IMAGE_NAME ?= $(current_folder_name)
export LOCAL_DOCKER_BASE ?= localhost:5000
export DOCKER_IMAGE_BASE ?= $(LOCAL_DOCKER_BASE:%=%/)$(IMAGE_NAME)

# Include service template file
include ../../make/service-template.mk

GITHUB_URL = https://github.com/intel/edge-video-analytics-microservice.git
SRC = src
MODELS_LIST = models.list.yml

.PHONY: build push

publish-service: build push fetch $(SERVICE_JSON_OUTPUT)
	hzn exchange service publish -O -f "$(SERVICE_JSON_OUTPUT)" --pull-image

fetch:
	@echo "fetching latest code..."
	cd src && git pull origin "v$(SERVICE_VERSION)$(VERSION_SUFFIX)"

build: $(SRC) fetch download-models patch-pipelines
	@echo "building docker image..."
	docker build -t "$(DOCKER_IMAGE_BASE):$(DOCKER_IMAGE_VERSION)" .

push: build
	@echo "pushing docker image..."
	docker push "$(DOCKER_IMAGE_BASE):$(DOCKER_IMAGE_VERSION)"

$(SRC):
	@echo "cloning..."
	git clone --branch "v$(SERVICE_VERSION)$(VERSION_SUFFIX)" $(GITHUB_URL) $@

download-models: $(SRC) $(MODELS_LIST)
	chmod +x $(SRC)/tools/model_downloader/model_downloader.sh $(SRC)/docker/run.sh
	$(SRC)/tools/model_downloader/model_downloader.sh --model-list $(MODELS_LIST)

# patch pipeline to accept rtsp video
patch-pipelines:
	sed -Ei "s|\{auto_source\} ! decodebin|{auto_source} ! application/x-rtp,media=video ! decodebin|g" $(SRC)/pipelines/*/*/pipeline.json
