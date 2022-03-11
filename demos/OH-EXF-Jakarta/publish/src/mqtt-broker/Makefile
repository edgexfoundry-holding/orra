# Include base Makefile
include ../../make/base.mk

# Define and export service specific variables
export IMAGE_NAME=mqtt-broker
export DOCKER_IMAGE_BASE=eclipse-mosquitto
export SERVICE_NAME=$(EDGE_OWNER).$(EDGE_DEPLOY).$(IMAGE_NAME)
export SERVICE_VERSION=2.0.12

# Include service template file
include ../../make/service-tmpl.mk
