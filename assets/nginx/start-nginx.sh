#!/bin/bash

IP_ADDR=$(ip address show dev eth0 | tr -s [:space:] | \
          grep inet | cut -d' ' -f3 | cut -d/ -f1)

DEFAULT=/etc/nginx/sites-available/default
if [ -f ${DEFAULT}.in ]; then
    sudo bash -c "sed -e \"s/DOCKER_IP_ADDR/$IP_ADDR/g\" ${DEFAULT}.in > $DEFAULT"
fi

CODE=/etc/nginx/sites-available/code
if [ -f ${CODE}.in ]; then
    IP_ADDR=$(ip address show dev eth0 | tr -s [:space:] | \
              grep inet | cut -d' ' -f3 | cut -d/ -f1)
    sudo sh -c "sed -e \"s/DOCKER_IP_ADDR/$IP_ADDR/g\" ${CODE}.in > $CODE"
    sudo ln -sf $CODE /etc/nginx/sites-enabled/code
fi

sudo --preserve-env php-fpm${PHP_FPM_VERSION:-8.1}
sudo --preserve-env nginx
