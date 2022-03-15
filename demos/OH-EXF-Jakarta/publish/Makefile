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
		unregister register watch-agreements envsubst $(PATTERNS:%=print-pattern-%) $(SUBPROJECTS:%=print-%) \
		tail inspect watch-services

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

sv ?=
tail:
	$(call require_arg,sv,service_name)
	@x2=; \
	while true; do \
    	x=$$(docker ps -aqf "name=$(sv)"); \
    	if [ -n "$$x" ] && [ ! "$$x2" = "$$x"  ]; then \
    	    echo "---- $(sv): ($$x) ----"; \
    	    docker logs -f "$$x"; \
    	    echo "----- $(sv): ($$x) -----"; \
			x2="$$x"; \
		fi \
	done

inspect:
	$(call require_arg,sv,service_name)
	@x2=; \
	while true; do \
    	x=$$(docker ps -aqf "name=$(sv)"); \
    	if [ -n "$$x" ]; then \
    	    echo "---- $(sv): ($$x) ----"; \
    	    docker inspect "$$x"; \
    	    echo "----- $(sv): ($$x) -----"; \
			x2="$$x"; \
		fi \
	done

watch-services:
	@while true; do \
		n="$$(docker network ls | grep $(HZN_ORG_ID)_$(EDGE_OWNER).$(EDGE_DEPLOY) | wc -l)"; \
		s="$$(docker ps |& sed -En 's/.*$(EDGE_OWNER)\.$(EDGE_DEPLOY)\.(.*)/\1/p' | sort -u | xargs echo -n | sed -E 's/ /, /g')"; \
		c="$$(wc -w <<< "$$s")"; \
		printf "[$$(date '+%D %T')] Networks: %2d, Containers: %2d, Services: [%-109s]\n" "$$n" "$$c" "$$s"; \
		sleep $(n); \
	done
