#!/bin/bash

set -e -u -m

trap exit SIGCHLD

sshd -D &
wait
