# Include base Makefile
include ../../make/base.mk

# Define and export service specific variables
export IMAGE_NAME=$(current_folder_name)
export DOCKER_IMAGE_BASE=$(IMAGE_NAME)
export VERSION_SUFFIX=-alpine

# Include service template file
include ../../make/service-tmpl.mk
