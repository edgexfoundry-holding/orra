# Include base Makefile
include make/base.mk

export ARCH ?= $(shell hzn architecture)

SUBPROJECTS = redis consul mqtt-broker core-command core-metadata device-mqtt edgex-ui asc-mqtt device-onvif-camera
PATTERNS = edgex-jakarta

p ?= $(word 1,$(PATTERNS))
n ?= 0.1

.PHONY: all publish $(SUBPROJECTS:%=publish-%) publish-patterns $(PATTERNS:%=publish-pattern-%) \
		unregister register watch

all: publish publish-patterns

publish: $(SUBPROJECTS:%=publish-%)

publish-patterns: $(PATTERNS:%=publish-pattern-%)

$(SUBPROJECTS:%=publish-%): publish-% :
	$(MAKE) -C "src/$*" publish-service

$(PATTERNS:%=publish-pattern-%): publish-pattern-% :
	hzn exchange pattern publish -f "horizon/$*.pattern.json"

unregister:
	hzn unregister -rfD &

register:
	hzn register -p "pattern-$(EDGE_OWNER).$(EDGE_DEPLOY).$(p)"

watch:
	watch -n $(n) hzn agreement list
