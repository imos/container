#!/bin/bash

set -e -u

find /code/src/ /code/build/flame-binary/ -name *.cpp -or -name *.cc | \
    while read path; do
  sudo --user=cloud-admin -- \
      /usr/local/codebrowser/bin/generator/codebrowser_generator \
          -o /code/html -b /code/build \
          -p code:/code/src -p code:/code/build/flame-binary \
          -p include:/code/build/flame-library-binary/include "${path}"
done
sudo --user=cloud-admin -- \
    /usr/local/codebrowser/bin/indexgenerator/codebrowser_indexgenerator \
        /code/html -d /code/data
