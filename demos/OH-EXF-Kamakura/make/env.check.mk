# Copyright (C) 2022 Intel Corporation
# SPDX-License-Identifier: Apache-2.0

# Sets the scope so that multiple users can use the same instance
$(call check_env,EDGE_OWNER,<sg.edge>)
# Lets you manage and deploy different group of code across dev, demo, test, prod or project
$(call check_env,EDGE_DEPLOY,example.visual)
$(call check_env,HZN_ORG_ID,<org_id>)
$(call check_env,HZN_EXCHANGE_USER_AUTH,iamapikey:<your-iamapikey>)
# Root bind directory for app volumes
$(call check_env,APP_BIND_HORIZON_DIR,/var/local/horizon)

# Check for authenticated access variables. If LOCAL_DOCKER_USERNAME is defined,
# then we expect LOCAL_DOCKER_API_KEY_RW_PUSH and LOCAL_DOCKER_API_KEY_RO_PULL to
# also be defined.
ifdef LOCAL_DOCKER_USERNAME
$(call check_env,LOCAL_DOCKER_API_KEY_RW_PUSH,<read-write api-key>)
$(call check_env,LOCAL_DOCKER_API_KEY_RO_PULL,<read-only api key>)
endif
