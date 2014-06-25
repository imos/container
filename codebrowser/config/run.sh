#!/bin/bash

set -e -u

Run() {
  "$@"
  kill -TERM "${ppid}"
  sleep 1
  kill -KILL "${ppid}"
}

ppid="$$"
Run nginx &

if [ ! -d /codebrowser/src ]; then
  mkdir -p /codebrowser/src
  cp -R /usr/local/codebrowser/src/* /codebrowser/src
fi

apt-get update -qq && apt-get install -y zlib1g-dev

cd /codebrowser/build
sudo --user=cloud-admin -- cmake /codebrowser/src \
    -DLLVM_CONFIG_EXECUTABLE=/usr/bin/llvm-config \
    -DCMAKE_CXX_COMPILER=/usr/bin/clang++ \
    -DCMAKE_EXPORT_COMPILE_COMMANDS=ON

find /codebrowser/src/ -name *.cpp -or -name *.cc | \
    while read path; do
  sudo --user=cloud-admin -- \
      /usr/local/codebrowser/bin/generator/codebrowser_generator \
          -o /codebrowser/html -b /codebrowser/build \
          -p code:/codebrowser/src "${path}"
done
sudo --user=cloud-admin -- \
    /usr/local/codebrowser/bin/indexgenerator/codebrowser_indexgenerator \
        /codebrowser/html -d /codebrowser/data

wait
