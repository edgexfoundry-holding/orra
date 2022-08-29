# Copyright (C) 2022 Intel Corporation
# SPDX-License-Identifier: Apache-2.0

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

# Base docker registry to use for edgexfoundry nexus images (Beta/Nightly)
export EDGEX_NEXUS_REGISTRY ?= nexus3.edgexfoundry.org:10004
export DOCKER_EDGEX_NEXUS_ORG ?=

# git url to clone for the model downloader tool
export REPO_URL_model_downloader ?= https://github.com/intel/edge-video-analytics-microservice.git
# branch or tag name for model downloader tool
export TAG_model_downloader ?= v0.7.0
# full image name and version of openvino data image to use when downloading and converting models
export OPENVINO_DATA_IMAGE ?= openvino/ubuntu20_data_dev:2021.4.2

# git url to clone for the edgex-examples source code
export REPO_URL_edgex_examples ?= https://github.com/EdgeX-Camera-Management/edgex-examples.git
# branch or tag name for edgex-examples
export TAG_edgex_examples ?= main

# root volume mount point for services
export APP_BIND_HORIZON_DIR ?= /var/local/horizon
