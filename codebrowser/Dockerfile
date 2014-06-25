FROM ubuntu:14.04
MAINTAINER Kentaro Imajo <docker@imoz.jp>
RUN apt-get update -qq && apt-get -y install nginx cmake git clang llvm-dev libclang-dev
RUN id www-data 2>/dev/null || useradd --shell=/sbin/nologin www-data
RUN mkdir -p /usr/local/codebrowser/src /usr/local/codebrowser/bin
RUN git clone -b 1.6 --depth=1 https://github.com/woboq/woboq_codebrowser.git /usr/local/codebrowser/src
RUN cd /usr/local/codebrowser/bin && cmake -DLLVM_CONFIG_EXECUTABLE=/usr/bin/llvm-config -DCMAKE_CXX_COMPILER=/usr/bin/clang++ -DCMAKE_EXPORT_COMPILE_COMMANDS=ON -DCMAKE_BUILD_TYPE=Release /usr/local/codebrowser/src && make -j 8
RUN useradd --home-dir=/home/cloud-admin --create-home --uid=20601 --user-group --shell=/bin/bash cloud-admin

RUN apt-get update -qq && apt-get -y install subversion
ADD config/nginx.conf /etc/nginx/nginx.conf
ADD config/run.sh /etc/run.sh
CMD bash /etc/run.sh
EXPOSE 80
