CPU ?= 100
MEMORY ?= 100M
BIND_ADDRESS ?= 0.0.0.0
BIND_PORT ?= 8002

SERVICE := codebrowser

start: check
	if ! docker top $(SERVICE) >/dev/null 2>/dev/null; then \
	  docker build --tag=imos/$(SERVICE) .; \
	  docker rm --force $(SERVICE) 2>/dev/null || true; \
	  docker run \
	      --name=$(SERVICE) --hostname=$(SERVICE) \
	      --publish=$(BIND_ADDRESS):$(BIND_PORT):80 \
	      --volume=/storage/code/src:/codebrowser/src:ro \
	      --volume=/storage/code/build:/codebrowser/build:rw \
	      --volume=/storage/code/html:/codebrowser/html:rw \
	      --memory=$(MEMORY) --cpu-shares=$(CPU) --detach imos/$(SERVICE); \
	fi
.PHONY: start

stop: check
	-docker kill $(SERVICE) 2>/dev/null
	-docker rm --force $(SERVICE) 2>/dev/null
.PHONY: stop

check:
	test "$$(whoami)" = 'root'
.PHONY: check
