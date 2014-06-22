CPU ?= 100
MEMORY ?= 100M
DISK ?= 10G
BIND_ADDRESS ?= 0.0.0.0
BIND_PORT ?= 3306

SERVICE := mysql

start: check
	if ! mountpoint -q /storage/$(SERVICE); then \
	  if [ ! -f /storage/$(SERVICE)/image.dmg ]; then \
	    mkdir -p /storage/$(SERVICE); \
	    truncate --size=1g /storage/$(SERVICE)/image.dmg; \
	    yes | mkfs -t ext4 /storage/$(SERVICE)/image.dmg; \
	  fi; \
	  resize2fs /storage/$(SERVICE)/image.dmg $(DISK); \
	  mount --types=auto --options=loop \
	      /storage/$(SERVICE)/image.dmg /storage/$(SERVICE); \
	fi
	if mountpoint -q /storage/$(SERVICE); then \
	  mkdir -p /storage/$(SERVICE)/data; \
	  chown 13306 /storage/$(SERVICE)/data; \
	fi
	if ! docker top $(SERVICE) >/dev/null 2>/dev/null; then \
	  docker build --tag=imos/$(SERVICE) .; \
	  docker rm --force $(SERVICE) 2>/dev/null || true; \
	  docker run \
	      --name=$(SERVICE) --hostname=$(SERVICE) \
	      --volume=/storage/mysql/data:/var/lib/mysql \
	      --publish=$(BIND_ADDRESS):$(BIND_PORT):3306 \
	      --memory=$(MEMORY) --cpu-shares=$(CPU) --detach imos/$(SERVICE); \
	fi
.PHONY: start

stop: check
	-docker kill $(SERVICE) 2>/dev/null
	-docker rm --force $(SERVICE) 2>/dev/null
	-fuser --kill /storage/$(SERVICE)
	-umount -f /storage/$(SERVICE)
.PHONY: stop

check:
	test "$$(whoami)" = 'root'
.PHONY: check
