#### Service Versions ####
# Format: VERSION_<service_name>, where service_name is the base name of the service
# 		  (often the name of the folder), but with `-` converted to `_`.
export VERSION_redis ?= 6.2.6
export VERSION_consul ?= 1.10.10
export VERSION_mqtt_broker ?= 2.0.12
export VERSION_deploy_data ?= 0.1.0
export VERSION_edge_video_analytics ?= 0.7.2
export VERSION_model_data ?= 0.1.0
export VERSION_device_onvif_camera ?= 2.2.0
# because device-onvif camera is in nexus registry, it gets incremental build numbers
export VERSION_SUFFIX_device_onvif_camera ?= -dev.9

#### EdgeX Core/Stock Service Versions ####
# Format: VERSION_<service_name>, where service_name is the base name of the service
# 		  (often the name of the folder), but with `-` converted to `_`.
export EDGEX_CORE_VERSION ?= 2.2.0
export VERSION_asc_mqtt ?= $(EDGEX_CORE_VERSION)
export VERSION_core_command ?= $(EDGEX_CORE_VERSION)
export VERSION_core_metadata ?= $(EDGEX_CORE_VERSION)
export VERSION_device_mqtt ?= $(EDGEX_CORE_VERSION)
export VERSION_edgex_ui ?= $(EDGEX_CORE_VERSION)

#### Pattern Versions ####
# Format: VERSION_PATTERN_<pattern_name>, where pattern_name is the base name of the pattern,
# 		  but with `-` converted to `_`.
export VERSION_PATTERN_edgex_kamakura ?= 0.2.0
export VERSION_PATTERN_edgex_kamakura_edge_video_analytics ?= 0.2.0
export VERSION_PATTERN_edge_video_analytics ?= 0.2.0
