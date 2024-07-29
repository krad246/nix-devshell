makefile_path := $(shell dirname $(realpath $(firstword $(MAKEFILE_LIST))))
top := $(TOP)

devcontainer_state := $(makefile_path)/.devcontainer
devcontainer_json := $(devcontainer_state)/devcontainer.json
devcontainer_json_tmpl := $(devcontainer_state)/devcontainer.json.tmpl
devcontainer_cache := $(devcontainer_state)/.cache

persist := $(devcontainer_state)/.persist
container_user_cache := $(devcontainer_cache)/user
container_system_cache := $(devcontainer_cache)/system
container_session_cache := $(devcontainer_cache)/session

devcontainer_build_args := --config $(devcontainer_json) \
														--workspace-folder $(makefile_path) \
														--docker-path "$$(command -v docker)" \
														--user-data-folder "$(persist)"

default: all

all: container-build template

container-%: export CONTAINER_TOP=/workdir

%: container-%

build: container-build

container-build: template
	@devcontainer build $(devcontainer_build_args)

up: container-up

container-up: template
	@devcontainer up $(devcontainer_build_args) | jq -r '.containerId'
	@touch $(makefile_path)/.envrc

start: container-start

container-start: container-up

attach: container-attach
	
container-attach: container-up
	@docker exec -it $$CONTAINER_ID bash -l

restart: container-restart

container-restart: template
	@devcontainer up $(devcontainer_build_args) --remove-existing-container | jq -r '.containerId'
	@touch $(makefile_path)/.envrc

stop: container-stop

container-stop:
	@docker ps -q --filter "id=$$CONTAINER_ID" | xargs -r docker stop

rm: container-rm

container-rm: container-stop
	@docker ps -aq --filter "id=$$CONTAINER_ID" | xargs -r docker rm

clean: container-rm
	@rm -f $(devcontainer_json)

template: $(devcontainer_json)

$(devcontainer_json): $(devcontainer_json_tmpl)

%.json: %.json.tmpl
	@mkdir -p $(@D)
	@cat $< | envsubst >$@

.PHONY: default template clean all
