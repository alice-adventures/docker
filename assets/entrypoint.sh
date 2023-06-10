#!/bin/bash

if [ -f /usr/local/bin/alice-test.sh ]; then
    echo "Loading alice-test environment"
    for v in $(env | sed -e 's:^\([^=]*\)=.*$:\1:'); do unset ${v}; done
    source /usr/local/bin/alice-test.sh
    env
    cd /home/ada/alice
fi

[ -n "$(which code-server)" ] && start-code-server.sh

start-nginx.sh
start-ttyd.sh
