# Guard to prevent it from being included more than once
ifndef SERVICE_TMPL_MK_DEFINED
SERVICE_TMPL_MK_DEFINED := 1

export IMAGE_NAME ?= $(current_folder_name)
export DOCKER_IMAGE_BASE ?= $(DOCKER_BASE)/$(IMAGE_NAME)
export VERSION_SUFFIX ?=
export SERVICE_NAME ?= $(EDGE_OWNER).$(EDGE_DEPLOY).$(IMAGE_NAME)
export SERVICE_VERSION ?= $(call version_of,$(IMAGE_NAME))
export DOCKER_IMAGE_VERSION ?= $(SERVICE_VERSION)$(VERSION_SUFFIX)

.PHONY: all publish-service deploy-policy print-service

all: publish-service deploy-policy

# Publish a Horizon service (per service.json) and pull image to get its sha256
publish-service:
	hzn exchange service publish -O -f service.definition.json --pull-image

print-service:
	envsubst < "service.definition.json"

# Only add a deploy policy if one is specified in "service.policy.json"
deploy-policy:
ifneq ("$(wildcard service.policy.json)","")
	hzn exchange deployment addpolicy -f service.policy.json deploy_$(EDGE_OWNER).$(EDGE_DEPLOY).$(IMAGE_NAME)_$(ARCH)
endif

endif # SERVICE_TMPL_MK_DEFINED
