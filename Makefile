.PHONY: help .check-server .check-port .check .build-builder \
.build-runner build-spigot create-spigot create-mc run stop \
restart attach

DOCKER_BUILD=docker build
DOCKER_RUN=docker run -it
DOCKER_ATTACH=docker attach
DOCKER_STOP=$(DOCKER_ATTACH)

SPIGOT_DIR=$(PWD)/spigot
SPIGOT_BUILD_DIR=$(SPIGOT_DIR)/build
SPIGOT_RUNNER_DIR=$(SPIGOT_DIR)/runner
SPIGOT_BUILDER_IMG=mvaldron/spigot-builder
SPIGOT_RUNNER_IMG=mvaldron/spigot-runner

MINECRAFT_RUNNER_IMG=itzg/minecraft-server

ifndef MEMORY
MEMORY=1G
endif

# Global
help:
	echo 

.check-server:
	if [ -z $(SRV) ]; then echo "ERROR: 'SRV' is not defined." && exit 1; fi

.check-port:
	if [ -z $(P) ]; then echo "ERROR: 'P' is not defined." && exit 1; fi

.check: .check-server .check-port

# SPIGOT
.build-builder:
	$(DOCKER_BUILD) $(SPIGOT_BUILD_DIR) -t $(SPIGOT_BUILDER_IMG)

.build-runner:
	$(DOCKER_BUILD) $(SPIGOT_RUNNER_DIR) -t $(SPIGOT_RUNNER_IMG)

build-spigot: .check-server .build-builder
	mkdir -p $(PWD)/data/$(SRV)
	$(DOCKER_RUN) --rm -v $(PWD)/data/$(SRV):/data $(SPIGOT_BUILDER_IMG)

create-spigot: .check .build-runner
	$(DOCKER_RUN) -d -p $(P):25565 -v $(PWD)/data/$(SRV):/data --name $(SRV) $(SPIGOT_RUNNER_IMG)

# Vanilla
create-mc: .check
	mkdir -p $(PWD)/data/$(SRV)
	$(DOCKER_RUN) -d \
-e EULA=TRUE \
-e MEMORY=4G \
-p $(P):25565 \
-v $(PWD)/data/$(SRV):/data \
--name $(SRV) \
$(MINECRAFT_RUNNER_IMG)

# General
run: .check-server
	docker start $(SRV)

stop: .check-server
	$(DOCKER_STOP) $(SRV)

restart: stop-mc run-mc

attach: .check-server
	$(DOCKER_ATTACH) $(SRV)