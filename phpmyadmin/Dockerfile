FROM ubuntu:14.04
MAINTAINER Kentaro Imajo <docker@imoz.jp>
ENV DEBIAN_FRONTEND noninteractive
RUN apt-get update -qq && apt-get -y install nginx phpmyadmin php5-fpm
RUN id www-data 2>/dev/null || useradd --shell=/sbin/nologin www-data
ADD config/nginx.conf /etc/nginx/nginx.conf
ADD config/php-fpm.conf /etc/php-fpm.conf
ADD config/phpmyadmin-config.sh /var/tmp/phpmyadmin-config.sh
RUN bash /var/tmp/phpmyadmin-config.sh > /etc/phpmyadmin/config.inc.php
RUN rm /var/tmp/phpmyadmin-config.sh
ENTRYPOINT php5-fpm --fpm-config=/etc/php-fpm.conf && nginx
EXPOSE 80
