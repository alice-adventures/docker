#!/bin/bash

RELEASES_URL="https://api.github.com/repos/alire-project/alire/releases"

# check latest release
LATEST_RELEASE_URL=$( \
      curl -L $RELEASES_URL 2>/dev/null \
    | grep 'browser_download_url.*\.zip' \
    | grep -v 'nightly' \
    | head -1 \
    | sed -e 's_.*\(http.*\.zip\).*_\1_')
LATEST_RELEASE_FILE=$(basename $LATEST_RELEASE_URL)

cd /tmp

# download latest release
if [ ! -f $LATEST_RELEASE_FILE ]; then
    sudo rm -f alr-*.zip
    curl -fOL $LATEST_RELEASE_URL
    if [ ! $? -eq 0 ]; then
        echo "Error: could not download $LATEST_RELEASE_URL"
    fi
fi

# install latest release
if [ -f $LATEST_RELEASE_FILE ]; then
    unzip $LATEST_RELEASE_FILE
    rm -f $LATEST_RELEASE_FILE
    sudo mv bin/alr /usr/local/bin/alr
fi
