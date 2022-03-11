# Guard to prevent it from being included more than once
ifndef SERVICE_TMPL_MK_DEFINED
SERVICE_TMPL_MK_DEFINED := 1

.PHONY: all publish-service deploy-policy

all: publish-service deploy-policy

# Publish a Horizon service (per service.json) and pull image to get its sha256
publish-service:
	hzn exchange service publish -O -f service.definition.json --pull-image

# Only add a deploy policy if one is specified in "service.policy.json"
deploy-policy:
ifneq ("$(wildcard service.policy.json)","")
	hzn exchange deployment addpolicy -f service.policy.json deploy_$(EDGE_OWNER).$(EDGE_DEPLOY).$(IMAGE_NAME)_$(ARCH)
endif

endif # SERVICE_TMPL_MK_DEFINED
