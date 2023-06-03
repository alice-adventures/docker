#!/bin/bash

RELEASES_URL="https://api.github.com/repos/coder/code-server/releases"

# check latest version
LATEST_RELEASE_URL=$( \
      curl -L $RELEASES_URL 2>/dev/null \
    | grep 'browser_download_url.*_amd64\.deb' \
    | grep -v '\-rc\.[0-9]*/' \
    | head -1 \
    | sed -e 's_.*\(http.*\.deb\).*_\1_')
LATEST_RELEASE_FILE=$(basename $LATEST_RELEASE_URL)

cd /tmp

# download latest version
if [ ! -f $LATEST_RELEASE_FILE ]; then
    sudo rm -f code-server*
    curl -fOL $LATEST_RELEASE_URL
    if [ ! $? -eq 0 ]; then
        echo "Error: could not download $LATEST_RELEASE_URL"
    fi
fi

# install latest version
if [ -f $LATEST_RELEASE_FILE ]; then
    sudo apt install -y ./$LATEST_RELEASE_FILE

    code-server --install-extension Adacore.ada
    code-server --install-extension yzhang.markdown-all-in-one
    code-server --install-extension bungcip.better-toml
    code-server --install-extension mhutchie.git-graph
else
    echo "Error: could not find $LATEST_RELEASE_FILE"
fi
