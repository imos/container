CPU ?= 100
MEMORY ?= 100M

SERVICE := codebrowser

start: check
	if ! docker top $(SERVICE) >/dev/null 2>/dev/null; then \
	  docker build --tag=imos/$(SERVICE) .; \
	  docker rm --force $(SERVICE) 2>/dev/null || true; \
	  docker run \
	      --name=$(SERVICE) --hostname=$(SERVICE) \
	      --publish=$(BIND_ADDRESS):$(BIND_PORT):80 \
	      --volume=/storage/code/src:/code/src:ro \
	      --volume=/storage/code/build:/code/build:rw \
	      --volume=/storage/dunsparce/www/code/html:/code/html:rw \
	      --memory=$(MEMORY) --cpu-shares=$(CPU) imos/$(SERVICE); \
	fi
.PHONY: start

stop: check
	-docker kill $(SERVICE) 2>/dev/null
	-docker rm --force $(SERVICE) 2>/dev/null
.PHONY: stop

check:
	test "$$(whoami)" = 'root'
.PHONY: check
