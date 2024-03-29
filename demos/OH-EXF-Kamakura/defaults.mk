# Copyright (C) 2022 Intel Corporation
# SPDX-License-Identifier: Apache-2.0

# Docker registry for locally built images
# this can be overridden to use your own registry
export LOCAL_DOCKER_REGISTRY ?= localhost:5000
# Org to push local-built images to. Can be left blank.
export LOCAL_DOCKER_ORG ?=

# Username to authenticate to LOCAL_DOCKER_REGISTRY
# NOTE: If LOCAL_DOCKER_USERNAME is defined, the code will assume you want to use authenticated access,
#       and LOCAL_DOCKER_API_KEY_RW_PUSH and LOCAL_DOCKER_API_KEY_RO_PULL _must_ be defined as well!
export LOCAL_DOCKER_USERNAME ?=
# API key for user LOCAL_DOCKER_USERNAME with RW access to LOCAL_DOCKER_REGISTRY
export LOCAL_DOCKER_API_KEY_RW_PUSH ?=
# API key for user LOCAL_DOCKER_USERNAME with RO access to LOCAL_DOCKER_REGISTRY
# NOTE: This can be the same or different from the RW_PUSH key
export LOCAL_DOCKER_API_KEY_RO_PULL ?= $(LOCAL_DOCKER_API_KEY_RW_PUSH)

# Base docker registry to use for dependency services that are not
# EdgeX or Locally built.
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
export REPO_URL_edgex_examples ?= https://github.com/edgexfoundry/edgex-examples.git
# branch or tag name for edgex-examples
export TAG_edgex_examples ?= main

# root volume mount point for services
export APP_BIND_HORIZON_DIR ?= /var/local/horizon
