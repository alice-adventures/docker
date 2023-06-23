#!/bin/bash

CERT=alice-docker.crt
if [ -f /tmp/$CERT ]; then
    echo -n "Installing $CERT .. "
    SSL_CERT=/etc/ssl/certs/$CERT
    sudo mv /tmp/$CERT $SSL_CERT
    sudo chown root.root $SSL_CERT
    sudo chmod 644 $SSL_CERT
    echo "Ok"
fi

PEM=alice-docker.pem
if [ -f /tmp/$PEM ]; then
    echo -n "Installing $PEM .. "
    SSL_PEM=/etc/ssl/private/$PEM
    sudo mv /tmp/$PEM $SSL_PEM
    sudo chown root.root $SSL_PEM
    sudo chmod 640 $SSL_PEM
    echo "Ok"
fi
