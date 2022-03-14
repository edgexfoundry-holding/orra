# Include base Makefile
include make/base.mk

# include all the version numbers
include versions.mk

export ARCH ?= $(shell hzn architecture)

SUBPROJECTS = redis consul mqtt-broker core-command core-metadata device-mqtt edgex-ui asc-mqtt device-onvif-camera
PATTERNS = edgex-jakarta

# make sure version is defined for all subproject
$(call require_versions_for,$(SUBPROJECTS))

file ?=
p ?= $(word 1,$(PATTERNS))
n ?= 0.1

.PHONY: all publish $(SUBPROJECTS:%=publish-%) publish-patterns $(PATTERNS:%=publish-pattern-%) \
		unregister register watch envsubst $(PATTERNS:%=print-pattern-%) $(SUBPROJECTS:%=print-%)

all: publish publish-patterns

publish: $(SUBPROJECTS:%=publish-%)

publish-patterns: $(PATTERNS:%=publish-pattern-%)

$(SUBPROJECTS:%=publish-%): publish-% :
	$(MAKE) -C "src/$*" publish-service

$(SUBPROJECTS:%=print-%): print-% :
	$(MAKE) -C "src/$*" print-service

$(PATTERNS:%=publish-pattern-%): publish-pattern-% :
	hzn exchange pattern publish -f "horizon/$*.pattern.json"

unregister:
	hzn unregister -rfD

register:
	$(call require_arg,p,$(word 1,$(PATTERNS)))
	hzn register -p "pattern-$(EDGE_OWNER).$(EDGE_DEPLOY).$(p)"

watch:
	watch -n $(n) hzn agreement list

$(PATTERNS:%=print-pattern-%): print-pattern-% :
	envsubst < "horizon/$*.pattern.json"
