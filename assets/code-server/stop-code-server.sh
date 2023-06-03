#!/bin/bash

ps x | grep -e '/usr/.*/code-server' | grep -v grep | \
    sed -e 's/  */ /g' | cut -d' ' -f2 | xargs -I{} kill -9 {} >/dev/null 2>&1
