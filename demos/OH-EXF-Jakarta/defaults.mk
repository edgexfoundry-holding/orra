# Docker registry for locally built images
# this can be overridden to use your own registry
export LOCAL_DOCKER_REGISTRY ?= localhost:5000

# Base docker registry to use for dependency services.
# Leave blank to use the default registry (DockerHub)
export DOCKER_REGISTRY ?=

# Base docker registry to use for edgexfoundry services.
# Leave blank to use the default registry (DockerHub)
export EDGEX_DOCKER_REGISTRY ?= $(DOCKER_REGISTRY)
export DOCKER_EDGEX_ORG ?= edgexfoundry

# git url to clone for the device-onvif-camera source code
export REPO_URL_device_onvif_camera ?= https://github.com/edgexfoundry-holding/device-onvif-camera.git
# branch or tag name for device-onvif-camera
export TAG_device_onvif_camera ?= main

# git url to clone for the model downloader tool
export REPO_URL_model_downloader ?= https://github.com/intel/edge-video-analytics-microservice.git
# branch or tag name for model downloader tool
export TAG_model_downloader ?= v0.7.0

# root volume mount point for services
export APP_BIND_HORIZON_DIR ?= /var/local/horizon
