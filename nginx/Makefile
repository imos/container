CPU ?= 100
MEMORY ?= 100M
BIND_ADDRESS1 ?= 0.0.0.0
BIND_PORT1 ?= 80
BIND_ADDRESS2 ?= 0.0.0.0
BIND_PORT2 ?= 10443

SERVICE := nginx

start: check
	if ! docker top $(SERVICE) >/dev/null 2>/dev/null; then \
	  docker build --tag=imos/$(SERVICE) .; \
	  mkdir -p /cloud/rw/$$(hostname --short)/www; \
	  docker rm --force $(SERVICE) 2>/dev/null || true; \
	  docker run \
	      --name=$(SERVICE) --hostname=$(SERVICE) \
	      --volume=/cloud/ro/$$(hostname --short)/www:/www:ro \
	      --volume=/storage/secret/imoz.jp:/secret:ro \
	      --publish=$(BIND_ADDRESS1):$(BIND_PORT1):80 \
	      --publish=$(BIND_ADDRESS2):$(BIND_PORT2):443 \
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
