# Checks required environment variables
include make/base.mk

export ARCH ?= $(shell hzn architecture)

SUBPROJECTS = redis consul
#SUBPROJECTS = asc-mqtt consul core-command core-metadata device-mqtt device-onvif-camera edgex-ui mqtt-broker redis
PATTERNS = edgex-jakarta

.PHONY: all publish $(SUBPROJECTS:%=publish-%) publish-patterns $(PATTERNS:%=publish-pattern-%)

all: publish publish-patterns

publish: $(SUBPROJECTS:%=publish-%)

publish-patterns: $(PATTERNS:%=publish-pattern-%)

$(SUBPROJECTS:%=publish-%): publish-% :
	$(MAKE) -C "src/$*" publish-service

$(PATTERNS:%=publish-pattern-%): publish-pattern-% :
	hzn exchange pattern publish -f "horizon/$*.pattern.json"
