FROM ubuntu:14.04
MAINTAINER Kentaro Imajo <docker@imoz.jp>
RUN apt-get update -qq && apt-get -y install nginx
RUN id www-data 2>/dev/null || useradd --shell=/sbin/nologin www-data
ADD config/nginx.conf /etc/nginx/nginx.conf
EXPOSE 80
ENTRYPOINT nginx
