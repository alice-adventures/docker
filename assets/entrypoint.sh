#!/bin/bash

[ -n "$(which code-server)" ] && start-code-server.sh
start-nginx.sh
start-ttyd.sh
