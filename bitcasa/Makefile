CPU ?= 100
MEMORY ?= 100M
DISK ?= 20G

SERVICE := bitcasa

start: check
	if ! mountpoint -q /storage/$(SERVICE); then \
	  e2fsck -y -f /storage/$(SERVICE)/image.dmg; \
	  resize2fs /storage/$(SERVICE)/image.dmg $(DISK); \
	  mount -t auto -o loop /storage/$(SERVICE)/image.dmg /storage/$(SERVICE); \
	fi
	if ! docker top $(SERVICE) >/dev/null 2>/dev/null; then \
	  docker build --tag=imos/$(SERVICE) .; \
	  docker run \
	      --name=$(SERVICE) --hostname=$(SERVICE) --privileged \
	      --volume=/storage/$(SERVICE):/bitcasa \
	      --memory=$(MEMORY) --cpu-shares=$(CPU) --detach imos/$(SERVICE); \
	fi
.PHONY: start

stop: check
	-docker kill $(SERVICE) 2>/dev/null
	-docker rm $(SERVICE) 2>/dev/null
	-fuser --kill /storage/$(SERVICE) 2>/dev/null
	-umount -f /storage/$(SERVICE) 2>/dev/null
.PHONY: stop

defrag: check
	-e4defrag -c /storage/$(SERVICE)/image.dmg
	-e2fsck -y -f /storage/$(SERVICE)/image.dmg
	-resize2fs -M /storage/$(SERVICE)/image.dmg
.PHONY: defrag

backup: check
	xz --stdout --compress /storage/$(SERVICE)/image.dmg \
	    > /storage/$(SERVICE).dmg.xz
.PHONY: backup

check:
	test "$$(whoami)" = 'root'
.PHONY: check
