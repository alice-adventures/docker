#!/bin/bash

if [ -n "$(which code-server)" ]; then
    IP_ADDR=$(ip address show dev eth0 | tr -s [:space:] | grep inet | cut -d' ' -f3 | cut -d/ -f1)
    export PASSWORD=1234
    CODE_SERVER_DIRS="--user-data-dir  $HOME/.vscode-server/data/ \
                      --extensions-dir $HOME/.vscode-server/extensions"
    code-server $CODE_SERVER_DIRS \
                --auth none \
                --disable-telemetry \
                --bind-addr $IP_ADDR:$CODE_SERVER_PORT \
                --ignore-last-opened \
                --welcome-text 'Welcome to Alice in Dockerland' \
                $* >/dev/null 2>&1 &
    echo Please visit http://$IP_ADDR:$CODE_SERVER_PORT to access vscode
else
    echo "Error: code-server not found"
fi
