FROM ubuntu:14.04
MAINTAINER Kentaro Imajo <docker@imoz.jp>
RUN apt-get update -qq && apt-get -y install sslh
ENTRYPOINT sslh -f -u root -p 0.0.0.0:443 --ssh 172.17.42.1:22 --ssl 172.17.42.1:10443
EXPOSE 443
