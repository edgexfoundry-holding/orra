# Checks to see if variable ENV_NAME is defined. If not, throw an error
# and request the user to set it.
# usage: $(call check_env,ENV_NAME,value recommendation)
check_env = $(if $($1),,$(error $1 is not set. export $1=$2))

# Sets the scope so that multiple users can use the same instance
$(call check_env,EDGE_OWNER,<sg.edge>)
# Lets you manage and deploy different group of code across dev, demo, test, prod or project
$(call check_env,EDGE_DEPLOY,example.visual)
$(call check_env,DOCKER_BASE,<your-docker-account-base>)
$(call check_env,HZN_ORG_ID,<org_id>)
$(call check_env,HZN_EXCHANGE_USER_AUTH,iamapikey:<your-iamapikey>)
$(call check_env,APP_BIND_HORIZON_DIR,/var/local/horizon)