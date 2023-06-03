#!/bin/bash

sudo --preserve-env nginx
sudo --preserve-env php-fpm${PHP_FPM_VERSION}
[ -n "$(which code-server)" ] && start-code-server.sh
ttyd --port 8086 --cwd /home/ada/alice/ --max-clients 0 -url-arg -client-option fontSize=15 -client-option lineHeight=1.1 bash
