# Include base Makefile
include make/base.mk

export ARCH ?= $(shell hzn architecture)

SUBPROJECTS = redis consul mqtt-broker core-command core-metadata device-mqtt edgex-ui asc-mqtt device-onvif-camera
PATTERNS = edgex-jakarta

.PHONY: all publish $(SUBPROJECTS:%=publish-%) publish-patterns $(PATTERNS:%=publish-pattern-%)

all: publish publish-patterns

publish: $(SUBPROJECTS:%=publish-%)

publish-patterns: $(PATTERNS:%=publish-pattern-%)

$(SUBPROJECTS:%=publish-%): publish-% :
	$(MAKE) -C "src/$*" publish-service

$(PATTERNS:%=publish-pattern-%): publish-pattern-% :
	hzn exchange pattern publish -f "horizon/$*.pattern.json"
