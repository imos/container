FROM ubuntu:14.04
MAINTAINER Kentaro Imajo <docker@imoz.jp>
RUN useradd --home-dir=/home/cloud-admin --create-home --uid=20601 --user-group --shell=/bin/bash cloud-admin

# Install Open SSH Server
RUN apt-get update -qq && apt-get -y install openssh-server

# Install Bitcasa
RUN apt-get update -qq && apt-get -y install wget uuid-runtime fakeroot
RUN echo "deb http://dist.bitcasa.com/release/apt debian main" > /etc/apt/sources.list.d/bitcasa-release.list
RUN wget -O- http://dist.bitcasa.com/release/bitcasa-releases.gpg.key | apt-key add -
RUN apt-get update -qq && fakeroot apt-get -y install bitcasa

ADD config/run.sh /etc/run.sh
EXPOSE 22
CMD bash /etc/run.sh
