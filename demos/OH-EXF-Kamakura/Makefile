# Copyright (C) 2022 Intel Corporation
# SPDX-License-Identifier: Apache-2.0

# Include base Makefile
include make/base.mk

# Note: These must be in sorted order based on their dependencies
# in order for everything to build properly on first build
SUBPROJECTS = deploy-data model-data redis consul mqtt-broker core-metadata device-mqtt \
			  device-onvif-camera asc-mqtt core-command edgex-ui edge-video-analytics \
			  app-camera-management

PATTERNS = edgex-kamakura-edge-video-analytics-management-app \
		   edgex-kamakura-edge-video-analytics \
		   edgex-kamakura \
		   edge-video-analytics

NODE_POLICY ?= horizon/node-policy.json
USER_INPUT ?= user-input.json

# do not let it be run in parallel to ensure dependency order is preserved
.NOTPARALLEL:

# make sure version is defined for all subprojects
$(call require_versions_for,$(SUBPROJECTS))

# make sure version is defined for all patterns
$(call require_versions_for,$(PATTERNS:%=PATTERN_%))

BUILD_DIR = build

file ?=
p ?= $(word 1,$(PATTERNS))
n ?= 0.1

.PHONY: all publish $(SUBPROJECTS:%=publish-%) publish-patterns $(PATTERNS:%=publish-pattern-%) \
		unregister register watch-agreements envsubst $(PATTERNS:%=print-pattern-%) $(SUBPROJECTS:%=print-%) \
		tail inspect watch-services cleanup force-clean register-pattern post-register

all: publish publish-patterns

publish: $(SUBPROJECTS:%=publish-%)

publish-patterns: $(PATTERNS:%=publish-pattern-%)

$(SUBPROJECTS:%=publish-%): publish-% :
	$(MAKE) -C "src/$*" publish-service deploy-policy

$(SUBPROJECTS:%=print-%): print-% :
	$(MAKE) -C "src/$*" print-service

$(PATTERNS:%=publish-pattern-%): publish-pattern-% : $(BUILD_DIR)/%.pattern.json
	export PATTERN_NAME="$*"; \
	export PATTERN_VERSION="$(VERSION_PATTERN_$(subst -,_,$*))"; \
	hzn exchange pattern publish -f "$(BUILD_DIR)/$*.pattern.json"

# print out the pattern.json file using specific
$(PATTERNS:%=print-pattern-%): print-pattern-% : $(BUILD_DIR)/%.pattern.json
	envsubst < "$(BUILD_DIR)/$*.pattern.json"

unregister:
	sudo -E hzn unregister -rfD
	$(MAKE) cleanup

cleanup:
	sudo rm -rf "$(APP_BIND_HORIZON_DIR)"
	sudo mkdir -p "$(APP_BIND_HORIZON_DIR)"
	sudo chmod 777 "$(APP_BIND_HORIZON_DIR)"

force-clean: cleanup
	docker container prune -f
	docker network prune -f

register:
	hzn register "$(addprefix --policy=,$(NODE_POLICY))" "$(addprefix --input-file=,$(USER_INPUT))"
	$(MAKE) post-register

# register with a specific pattern
register-pattern:
	$(call require_arg,p,$(word 1,$(PATTERNS)))
	hzn register -p "pattern-$(EDGE_OWNER).$(EDGE_DEPLOY).$(p)-$(VERSION_PATTERN_$(subst -,_,$(p)))" \
		"$(addprefix --policy=,$(NODE_POLICY))" "$(addprefix --input-file=,$(USER_INPUT))"
	$(MAKE) post-register

post-register:
	sudo mkdir -p "$(APP_BIND_HORIZON_DIR)"
	sudo chmod 777 "$(APP_BIND_HORIZON_DIR)"

watch-agreements:
	watch -n $(n) hzn agreement list

$(BUILD_DIR):
	mkdir -p "$@"

# remove comments from pattern.json files (any line starting with //)
$(PATTERNS:%=$(BUILD_DIR)/%.pattern.json): $(BUILD_DIR)/%.pattern.json : horizon/%.pattern.json | $(BUILD_DIR)
	sed -E 's|^\s*//.*||g' "horizon/$*.pattern.json" > "$@"

sv ?=
tail:
	$(call require_arg,sv,service_name)
	@x2=; \
	while true; do \
    	x=$$(docker ps -aqf "name=$(sv)" | tail -n 1); \
    	if [ -n "$$x" ]; then \
    	    echo ">>>> $(sv): ($$x) >>>>"; \
    	    docker logs -f "$$x"; \
    	    echo "<<<< $(sv): ($$x) <<<<"; \
			x2="$$x"; \
		fi \
	done

inspect:
	$(call require_arg,sv,service_name)
	@x2=; \
	while true; do \
    	x=$$(docker ps -qf "name=$(sv)"); \
    	if [ -n "$$x" ]; then \
    	    echo ">>>> $(sv): ($$x) >>>>"; \
    	    docker inspect "$$x"; \
    	    echo "<<<< $(sv): ($$x) <<<<"; \
			x2="$$x"; \
			sleep 0.2; \
		fi \
	done

watch-services:
	@while true; do \
		n="$$(docker network ls | grep $(HZN_ORG_ID)_$(EDGE_OWNER).$(EDGE_DEPLOY) | wc -l)"; \
		s="$$(docker ps |& sed -En 's/.*$(EDGE_OWNER)\.$(EDGE_DEPLOY)\.(.*)/\1/p' | sort -u | xargs echo -n | sed -E 's/ /, /g')"; \
		c="$$(wc -w <<< "$$s")"; \
		printf "\033[2m[$$(date '+%D %T')]\033[0m Networks: \033[1m%2d\033[0m, Containers: \033[1m%2d\033[0m, Services: [%-121s]\n" "$$n" "$$c" "$$s"; \
		sleep $(n); \
	done
