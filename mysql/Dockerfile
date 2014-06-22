FROM ubuntu:14.04
MAINTAINER Kentaro Imajo <docker@imoz.jp>
ENV DEBIAN_FRONTEND noninteractive
RUN useradd --shell=/sbin/nologin --uid=13306 mysql
RUN apt-get update -qq && apt-get -y install mysql-client mysql-server
ADD config/my.cnf /etc/mysql/my.cnf
CMD mysqld_safe
EXPOSE 3306
