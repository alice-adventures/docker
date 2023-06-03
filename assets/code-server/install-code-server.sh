#!/bin/bash

if [ -z "$(which code-server)" ]; then
    cd /tmp
    RELEASE=$(curl -L https://api.github.com/repos/coder/code-server/releases 2>/dev/null \
                  | grep 'browser_download_url.*_amd64\.deb' \
                  | grep -v '\-rc\.[0-9]*/' \
                  | head -1 \
                  | sed -e 's_.*\(http.*\.deb\).*_\1_')
    curl -fOL https://github.com/coder/code-server/releases/download/v${RELEASE}/code-server_${RELEASE}_amd64.deb
    dpkg -i code-server_${RELEASE}_amd64.deb

    code-server --install-extension Adacore.ada
    code-server --install-extension yzhang.markdown-all-in-one
    code-server --install-extension bungcip.better-toml
    code-server --install-extension mhutchie.git-graph
else
    echo "Error: code-server not found"
fi
