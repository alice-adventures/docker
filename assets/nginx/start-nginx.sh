#!/bin/bash

sudo --preserve-env php-fpm${PHP_FPM_VERSION:-8.1}
sudo --preserve-env nginx
