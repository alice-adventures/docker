#!/bin/bash

RELEASES_URL="https://api.github.com/repos/coder/code-server/releases"

# check latest release
LATEST_RELEASE_URL=$( \
      curl -L $RELEASES_URL 2>/dev/null \
    | grep 'browser_download_url.*_amd64\.deb' \
    | grep -v '\-rc\.[0-9]*/' \
    | head -1 \
    | sed -e 's_.*\(http.*\.deb\).*_\1_')
LATEST_RELEASE_FILE=$(basename $LATEST_RELEASE_URL)

cd /tmp

# download latest release
if [ ! -f $LATEST_RELEASE_FILE ]; then
    sudo rm -f code-server*
    curl -fOL $LATEST_RELEASE_URL
    if [ ! $? -eq 0 ]; then
        echo "Error: could not download $LATEST_RELEASE_URL"
    fi
fi

# install latest release
if [ -f $LATEST_RELEASE_FILE ]; then
    sudo apt install -y ./$LATEST_RELEASE_FILE
    rm -f $LATEST_RELEASE_FILE

    mkdir -p $HOME/.vscode-server/data/
    mkdir -p $HOME/.vscode-server/extensions/
    CODE_SERVER_DIRS="--user-data-dir  $HOME/.vscode-server/data/ \
                      --extensions-dir $HOME/.vscode-server/extensions/"

    code-server ${CODE_SERVER_DIRS} --install-extension Adacore.ada
    code-server ${CODE_SERVER_DIRS} --install-extension bungcip.better-toml
    code-server ${CODE_SERVER_DIRS} --install-extension webfreak.debug
    code-server ${CODE_SERVER_DIRS} --install-extension yzhang.markdown-all-in-one
else
    echo "Error: could not find $LATEST_RELEASE_FILE"
fi
