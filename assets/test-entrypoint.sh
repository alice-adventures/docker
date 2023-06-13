#!/bin/bash

EPRD="$(dirname $0)"  # Entry point root directory
TEST_ENV="${EPRD}/test-env.sh"

echo "Loading test environment $TEST_ENV"
for v in $(env | sed -e 's:^\([^=]*\)=.*$:\1:'); do
    unset ${v};
done
source $TEST_ENV

cd $HOME/alice

[ -n "$(which code-server)" ] && ${EPRD}/code-server/start-code-server.sh
${EPRD}/nginx/start-nginx.sh
${EPRD}/ttyd/start-ttyd.sh
