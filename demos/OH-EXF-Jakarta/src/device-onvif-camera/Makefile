# Include base Makefile
include ../../make/base.mk

# Define and export service specific variables
export VERSION_SUFFIX=-dev
export DOCKER_REGISTRY_BASE=$(LOCAL_DOCKER_REGISTRY:%=%/)
export DOCKER_ORG=$(DOCKER_EDGEX_ORG)

# Include service template file
include ../../make/service-template.mk

.PHONY: build push clean

publish-service: build push $(SERVICE_JSON_OUTPUT)
	hzn exchange service publish -O -f "$(SERVICE_JSON_OUTPUT)" --pull-image

build: src
	@echo "building docker image..."
	make -C src docker

push: build
	@echo "tagging docker image..."
	docker tag "edgexfoundry/$(IMAGE_NAME):$(DOCKER_IMAGE_VERSION)" "$(DOCKER_FULL_IMAGE_NAME)"
	@echo "pushing docker image..."
	docker push "$(DOCKER_FULL_IMAGE_NAME)"

clean:
	rm -rf $(SRC_DIR)

src:
	@echo "cloning..."
	git clone --depth=1 --branch $(TAG_device_onvif_camera) $(REPO_URL_device_onvif_camera) src
