# Include base Makefile
include ../../make/base.mk

# Define and export service specific variables
export IMAGE_NAME=redis
export DOCKER_IMAGE_BASE=$(IMAGE_NAME)
export SERVICE_NAME=$(EDGE_OWNER).$(EDGE_DEPLOY).$(IMAGE_NAME)
export SERVICE_VERSION=6.2.6

# Include service template file
include ../../make/service-tmpl.mk
