FROM ubuntu:14.04
MAINTAINER Kentaro Imajo <docker@imoz.jp>
RUN apt-get update -qq && apt-get -y install subversion curl xz-utils cmake git clang llvm-dev libclang-dev zlib1g-dev
RUN useradd --home-dir=/home/cloud-admin --create-home --uid=20601 --user-group --shell=/bin/bash cloud-admin
ADD config/run.sh /etc/run.sh
CMD bash /etc/run.sh
EXPOSE 80
