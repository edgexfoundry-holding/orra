# Include base Makefile
include ../../make/base.mk

# Define and export service specific variables
export DOCKER_REGISTRY_BASE=$(EDGEX_DOCKER_REGISTRY:%=%/)
export DOCKER_ORG=$(DOCKER_EDGEX_ORG)

# Include service template file
include ../../make/service-template.mk
