DISK ?= 100G

SERVICE := dunsparce

start: check
	if ! mountpoint -q /storage/$(SERVICE); then \
	  resize2fs /storage/$(SERVICE)/image.dmg $(DISK); \
	  mount --types=auto --options=loop \
	      /storage/$(SERVICE)/image.dmg /storage/$(SERVICE); \
	fi
	if ! mountpoint -q /cloud/rw/$(SERVICE); then \
	  mkdir -p /cloud/rw/$(SERVICE); \
	  mount --bind /storage/$(SERVICE) /cloud/rw/$(SERVICE); \
	fi
	if ! mountpoint -q /cloud/ro/$(SERVICE); then \
	  mkdir -p /cloud/ro/$(SERVICE); \
	  mount --bind /storage/$(SERVICE) /cloud/ro/$(SERVICE); \
	  mount -o remount,ro /cloud/ro/$(SERVICE); \
	fi
.PHONY: start

stop: check
	-for mode in ro rw; do \
	  fuser --kill /cloud/$$mode/$(SERVICE); \
	  umount -f /cloud/$$mode/$(SERVICE); \
	done
	-fuser --kill /storage/$(SERVICE)
	-umount -f /storage/$(SERVICE)
	# rm -rf /cloud
.PHONY: stop

check:
	test "$$(whoami)" = 'root'
.PHONY: check
