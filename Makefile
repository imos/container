USERS := cloud-admin cloud-user cloud-family cloud-guest

start:
	make --file=$$(hostname --short).mk start
.PHONY: start

stop:
	make --file=$$(hostname --short).mk stop
.PHONY: stop

restart: stop
	make --file=$$(hostname --short).mk start
.PHONY: restart

%-start:
	make --file=$$(hostname --short).mk $*-poststart
.PHONY: %-start

%-stop:
	make --file=$$(hostname --short).mk $*-poststop
.PHONY: %-stop

%-restart: %-stop
	make --file=$$(hostname --short).mk $*-poststart
.PHONY: %-restart

install:
	id cloud-admin || useradd --home-dir=/home/cloud-admin --create-home \
	    --uid=20601 --user-group --shell=/bin/bash cloud-admin
	id cloud-user || useradd --home-dir=/home/cloud-user --create-home \
	    --uid=20602 --user-group --shell=/sbin/nologin cloud-user
	id cloud-family || useradd --home-dir=/home/cloud-family --create-home \
	    --uid=20603 --user-group --shell=/sbin/nologin cloud-family
	id cloud-guest || useradd --home-dir=/home/cloud-guest --create-home \
	    --uid=20604 --user-group --shell=/sbin/nologin cloud-guest
	usermod --groups=cloud-family,cloud-user,cloud-guest cloud-user
	usermod --groups=cloud-guest,cloud-family cloud-family
	for user in $(USERS); do \
	  mkdir -p /home/$${user}/.ssh; \
	  cp authorized_keys/$${user} \
	      /home/$${user}/.ssh/authorized_keys 2>/dev/null || true; \
	done
.PHONY: install

uninstall:
	for user in $(USERS); do \
	  userdel --force --remove $${user}; \
	  groupdel $${user}; \
	done
.PHONY: uninstall
