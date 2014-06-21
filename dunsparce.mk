SERVICES := dunsparce dropbox nginx sslh

start: check $(addsuffix -poststart, $(SERVICES))
.PHONY: start

stop: check $(addsuffix -poststop, $(SERVICES))
.PHONY: stop

check:
	test "$$(whoami)" = 'root'
.PHONY: check

dropbox-poststart: dropbox-start dunsparce-start
	for year in 2013 2014; do for mode in rw ro; do \
	  mkdir -p /cloud/$$mode/dropbox/icfpc/$$year; \
	  { sshfs \
	      -o "IdentityFile=/root/.ssh/Dunsparce.pem,nonempty" \
	      -o "default_permissions,allow_other" \
	      -o "uid=$$(id -u cloud-family),gid=$$(id -g cloud-family)" \
	      -o "umask=007,$$mode" \
	      cloud-admin@localhost:/storage/dropbox/Dropbox/icfpc/$$year \
	      /cloud/$$mode/dropbox/icfpc/$$year & } ; \
	done; done; wait
.PHONY: dropbox-poststart

dropbox-prestop:
	-for year in 2014 2013; do for mode in ro rw; do \
	   { fuser --kill /cloud/$$mode/dropbox/icfpc/$$year & } ; \
	done; done; wait
	-for year in 2014 2013; do for mode in ro rw; do \
	   { umount -f /cloud/$$mode/dropbox/icfpc/$$year & } ; \
	done; done; wait
.PHONY: dropbox-prestop

dunsparce-prestop: dropbox-prestop
.PHONY: dunsparce-prestop

%-prestart:
	-@:
.PHONY: %-prestart

%-start: %-prestart
	cd $*; make start
.PHONY: %-start

%-poststart: %-start
	-@:
.PHONY: %-poststart

%-prestop:
	-@:
.PHONY: %-prestop

%-stop: %-prestop
	cd $*; make stop
.PHONY: %-stop

%-poststop: %-stop
	-@:
.PHONY: %-poststop
