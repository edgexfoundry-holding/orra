# Guard to prevent it from being included more than once
ifndef HELPERS_MK_DEFINED
HELPERS_MK_DEFINED := 1

# Checks to see if variable ENV_NAME is defined. If not, throw an error
# and request the user to set it.
# usage: $(call check_env,ENV_NAME,value recommendation)
check_env = $(if $($1),,$(error $1 is not set. export $1=$2))

# Checks to see if user passed arg ($1) in. If not, print error
# usage: $(call require_arg,ARG_NAME,value recommendation)
require_arg = $(if $($1),,$(error usage: make $(MAKECMDGOALS) $1=$2))

# returns the name of the make variable that contains the version for a given service
# usage: $(call version_name,service-name)
version_name = VERSION_$(subst -,_,$1)

# returns the version for a given service
# usage: $(call version_of,service-name)
version_of = $($(call version_name,$1))

# for each service given, make sure there is a version defined
require_versions_for = $(foreach sub,$1,$(call check_env,$(call version_name,$(sub)),<version_number>. Or update versions.mk))

current_folder_name = $(notdir $(CURDIR:/=))

endif # HELPERS_MK_DEFINED
