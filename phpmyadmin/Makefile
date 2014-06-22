CPU ?= 100
MEMORY ?= 100M
BIND_ADDRESS ?= 0.0.0.0
BIND_PORT ?= 8001

SERVICE := phpmyadmin

start: check
	if ! docker top $(SERVICE) >/dev/null 2>/dev/null; then \
	  docker build --tag=imos/$(SERVICE) .; \
	  docker rm --force $(SERVICE) 2>/dev/null || true; \
	  docker run \
	      --name=$(SERVICE) --hostname=$(SERVICE) \
	      --publish=$(BIND_ADDRESS):$(BIND_PORT):80 \
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
