CPU ?= 100
MEMORY ?= 100M
BIND_ADDRESS ?= 0.0.0.0
BIND_PORT ?= 80

SERVICE := nginx

start: check
	docker build --tag=imos/$(SERVICE) .
	docker run --env=MASTER_HOST=$$(hostname) \
	    --name=$(SERVICE) --hostname=$(SERVICE) \
	    --publish=$(BIND_ADDRESS):$(BIND_PORT):80 \
	    --memory=$(MEMORY) --cpu-shares=$(CPU) --detach imos/$(SERVICE)
.PHONY: start

stop: check
	-docker kill $(SERVICE) 2>/dev/null
	-docker rm $(SERVICE) 2>/dev/null
.PHONY: stop

check:
	test "$$(whoami)" = 'root'
.PHONY: check
