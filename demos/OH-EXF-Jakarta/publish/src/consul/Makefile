# Include base Makefile
include ../../make/base.mk

# Define and export service specific variables
export IMAGE_NAME=consul
export SERVICE_NAME=$(EDGE_OWNER).$(EDGE_DEPLOY).$(IMAGE_NAME)
export SERVICE_VERSION=1.10.3
export DOCKER_IMAGE_BASE=$(IMAGE_NAME)

# Include service template file
include ../../make/service-tmpl.mk
