FROM ubuntu:14.04
MAINTAINER Kentaro Imajo <docker@imoz.jp>
RUN useradd --home-dir=/home/cloud-guest --create-home --uid=20604 --user-group --shell=/sbin/nologin cloud-guest
RUN apt-get update -qq && apt-get -y install php5-fpm
ADD config/php-fpm.conf /etc/php-fpm.conf
ENTRYPOINT php5-fpm --fpm-config=/etc/php-fpm.conf --nodaemonize
EXPOSE 9000
