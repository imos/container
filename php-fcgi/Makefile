CPU ?= 100
MEMORY ?= 100M
BIND_ADDRESS ?= 172.17.42.1
BIND_PORT ?= 9000

SERVICE := php-fcgi

start: check
	if ! docker top $(SERVICE) >/dev/null 2>/dev/null; then \
	  docker build --tag=imos/$(SERVICE) .; \
	  mkdir -p /cloud/rw/$$(hostname --short)/www; \
	  docker rm --force $(SERVICE) 2>/dev/null || true; \
	  docker run \
	      --name=$(SERVICE) --hostname=$(SERVICE) \
	      --volume=/cloud/ro/$$(hostname --short)/www:/www:ro \
	      --publish=$(BIND_ADDRESS):$(BIND_PORT):9000 \
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
