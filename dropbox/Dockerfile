FROM ubuntu:14.04
MAINTAINER Kentaro Imajo <docker@imoz.jp>
RUN useradd --home-dir=/home/cloud-admin --create-home --uid=20601 --user-group --shell=/bin/bash cloud-admin
ENTRYPOINT sudo --user=cloud-admin --login -- bash -c "~/.dropbox-dist/dropboxd"
