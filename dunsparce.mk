SERVICES := dunsparce dropbox nginx sslh php-fcgi phpmyadmin mysql

start: check $(addsuffix -poststart, $(SERVICES))
.PHONY: start

stop: check $(addsuffix -poststop, $(SERVICES))
.PHONY: stop

check:
	test "$$(whoami)" = 'root'
.PHONY: check

# Kill services using /cloud.
dunsparce-prestop: dropbox-poststop nginx-poststop php-fcgi-poststop
.PHONY: dunsparce-prestop

dropbox-poststart: dropbox-start dunsparce-poststart
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

# /cloud/ro/dunsparce/www must be mounted beforehand.
nginx-prestart: dunsparce-poststart
.PHONY: nginx-prestart

# /cloud/ro/dunsparce/www must be mounted beforehand.
php-fcgi-prestart: dunsparce-poststart
.PHONY: php-fcgi-prestart

%-prestart: %/Makefile
	-@:
.PHONY: %-prestart

%-start: %-prestart
	cd $*; make start
.PHONY: %-start

%-poststart: %-start
	-@:
.PHONY: %-poststart

%-prestop: %/Makefile
	-@:
.PHONY: %-prestop

%-stop: %-prestop
	cd $*; make stop
.PHONY: %-stop

%-poststop: %-stop
	-@:
.PHONY: %-poststop
