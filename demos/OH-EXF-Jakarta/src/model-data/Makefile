# Include base Makefile
include ../../make/base.mk

# Define and export service specific variables
export DOCKER_REGISTRY_BASE=$(LOCAL_DOCKER_REGISTRY:%=%/)

# Include service template file
include ../../make/service-template.mk

SRC = src
MODELS_LIST = models.list.yml

.PHONY: build push clean

publish-service: build push $(SERVICE_JSON_OUTPUT)
	hzn exchange service publish -O -f "$(SERVICE_JSON_OUTPUT)" --pull-image

build: $(SRC) download-models patch-pipelines
	@echo "building docker image..."
	docker build -t "$(DOCKER_FULL_IMAGE_NAME)" .

push: build
	@echo "pushing docker image..."
	docker push "$(DOCKER_FULL_IMAGE_NAME)"

$(SRC):
	@echo "cloning..."
	git clone --depth=1 --branch $(TAG_model_downloader) $(REPO_URL_model_downloader) $@

clean:
	rm -rf $(SRC)

download-models: $(SRC) $(MODELS_LIST)
	chmod +x $(SRC)/tools/model_downloader/model_downloader.sh $(SRC)/docker/run.sh
	$(SRC)/tools/model_downloader/model_downloader.sh --model-list $(MODELS_LIST)

# patch pipeline to accept rtsp video
patch-pipelines:
	sed -Ei "s|\{auto_source\} ! decodebin|{auto_source} ! application/x-rtp,media=video ! decodebin|g" $(SRC)/pipelines/*/*/pipeline.json
