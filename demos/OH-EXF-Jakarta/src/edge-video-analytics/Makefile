# Include base Makefile
include ../../make/base.mk

# Define and export service specific variables
export ENTRYPOINT=/app/run.sh
export IMAGE_NAME=$(current_folder_name)
export DOCKER_IMAGE_BASE=intel/edge_video_analytics_microservice

# Include service template file
include ../../make/service-template.mk
