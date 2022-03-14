# Include base Makefile
include make/base.mk

# include all the version numbers
include versions.mk

export ARCH ?= $(shell hzn architecture)

SUBPROJECTS = redis consul mqtt-broker core-command core-metadata device-mqtt edgex-ui asc-mqtt device-onvif-camera
PATTERNS = edgex-jakarta

# make sure version is defined for all subproject
$(call require_versions_for,$(SUBPROJECTS))

BUILD_DIR = build

file ?=
p ?= $(word 1,$(PATTERNS))
n ?= 0.1

.PHONY: all publish $(SUBPROJECTS:%=publish-%) publish-patterns $(PATTERNS:%=publish-pattern-%) \
		unregister register watch-agreements envsubst $(PATTERNS:%=print-pattern-%) $(SUBPROJECTS:%=print-%)

all: publish publish-patterns

publish: $(SUBPROJECTS:%=publish-%)

publish-patterns: $(PATTERNS:%=publish-pattern-%)

$(SUBPROJECTS:%=publish-%): publish-% :
	$(MAKE) -C "src/$*" publish-service

$(SUBPROJECTS:%=print-%): print-% :
	$(MAKE) -C "src/$*" print-service

$(PATTERNS:%=publish-pattern-%): publish-pattern-% : $(BUILD_DIR)/%.pattern.json
	hzn exchange pattern publish -f "$(BUILD_DIR)/$*.pattern.json"

# print out the pattern.json file using specific
$(PATTERNS:%=print-pattern-%): print-pattern-% : $(BUILD_DIR)/%.pattern.json
	envsubst < "$(BUILD_DIR)/$*.pattern.json"

unregister:
	sudo -E hzn unregister -rfD

register:
	$(call require_arg,p,$(word 1,$(PATTERNS)))
	hzn register -p "pattern-$(EDGE_OWNER).$(EDGE_DEPLOY).$(p)"

watch-agreements:
	watch -n $(n) hzn agreement list

$(BUILD_DIR):
	mkdir -p "$@"

# remove comments from pattern.json files (any line starting with //)
$(PATTERNS:%=$(BUILD_DIR)/%.pattern.json): $(BUILD_DIR)/%.pattern.json : horizon/%.pattern.json | $(BUILD_DIR)
	sed -E 's|^\s*//.*||g' "horizon/$*.pattern.json" > "$@"

# write all docker logs to file in background, then tail all of them
tail-all:
	-pkill -f "docker logs -f"
	-rm -f /tmp/*.dockerlog
	for name in $$(docker ps --format="{{.Names}}"); do \
		docker logs -f $$name > /tmp/$$name.dockerlog 2>&1 & \
	done
	-trap 'pkill -f "docker logs -f"' INT; tail -f /tmp/*.dockerlog
