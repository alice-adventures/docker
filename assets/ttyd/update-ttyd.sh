#!/bin/bash

RELEASES_URL="https://api.github.com/repos/tsl0922/ttyd/releases"

# check latest release
LATEST_RELEASE_URL=$( \
      curl -L $RELEASES_URL 2> /dev/null \
    | grep browser_download_url.*$(arch) \
    | head -1 \
    | sed -e "s:.*\(http.*\.$(arch)\).*:\1:")
LATEST_RELEASE_FILE=$(basename $LATEST_RELEASE_URL)

cd /tmp

# download latest release
if [ ! -f $LATEST_RELEASE_FILE ]; then
    sudo rm -f ttyd*
    curl -fOL $LATEST_RELEASE_URL
    if [ ! $? -eq 0 ]; then
        echo "Error: could not download $LATEST_RELEASE_URL"
    fi
fi

# install latest release
if [ -f $LATEST_RELEASE_FILE ]; then
    sudo chmod a+x ttyd*
    sudo mv ttyd* /usr/local/bin/ttyd
fi
