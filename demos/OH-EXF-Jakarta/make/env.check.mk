# Sets the scope so that multiple users can use the same instance
$(call check_env,EDGE_OWNER,<sg.edge>)
# Lets you manage and deploy different group of code across dev, demo, test, prod or project
$(call check_env,EDGE_DEPLOY,example.visual)
$(call check_env,HZN_ORG_ID,<org_id>)
$(call check_env,HZN_EXCHANGE_USER_AUTH,iamapikey:<your-iamapikey>)
# Root bind directory for app volumes
$(call check_env,APP_BIND_HORIZON_DIR,/var/local/horizon)
