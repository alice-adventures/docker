#!/bin/bash

if [ -n "$(which code-server)" ]; then
    export PASSWORD=1234
    CODE_SERVER_DIRS="--user-data-dir  $HOME/.vscode-server/data/ \
                      --extensions-dir $HOME/.vscode-server/extensions"
    code-server $CODE_SERVER_DIRS \
                --auth none \
                --disable-telemetry \
                --bind-addr localhost:$CODE_SERVER_PORT \
                --ignore-last-opened \
                --welcome-text 'Welcome to Alice in Dockerland' \
                $* >/dev/null 2>&1 &
else
    echo "Error: code-server not found"
fi
