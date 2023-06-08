FROM ubuntu:22.04

ARG user_name=guest
ARG group_name=${user_name}
ARG uid=1000
ARG gid=1000
ARG code_server=true
ARG code_server_auth=none
ARG code_server_password=1234

ENV ALICE_DOCKER_VERSION=0.1.1
ENV ALICE_HOME=/home/${user_name}/alice
ENV CODE_SERVER_PORT=47801
ENV LC_ALL=C.UTF8
ENV PHP_FPM_SOCKET=/run/php/php8.1-fpm.sock
ENV PHP_FPM_VERSION=8.1


### Install required packages

RUN apt update
RUN DEBIAN_FRONTEND=noninteractive \
    apt install -y --no-install-recommends \
    apt-utils \
    bash-completion \
    btop \
    build-essential \
    ca-certificates \
    curl \
    dialog \
    gdb \
    git \
    iproute2 \
    less \
    libsecret-1-0 \
    media-types \
    nginx-light \
    php-fpm \
    ssh \
    sudo \
    unzip \
    websocketd \
    wget


### Add user and group

RUN groupadd --force --gid ${gid} ${group_name} &&\
    useradd --create-home --home-dir /home/${user_name} --gid ${gid} --groups sudo --shell /bin/bash --uid ${uid} ${user_name} &&\
    echo "${user_name}:${user_name}" | chpasswd &&\
    echo "root:root" | chpasswd &&\
    echo '%sudo ALL=(ALL) NOPASSWD:ALL' >> /etc/sudoers


### Download assets; change nginx & php configurations

USER root
WORKDIR /usr/local/bin
RUN curl -fOL https://raw.githubusercontent.com/alice-adventures/docker/main/assets/entrypoint.sh && \
    curl -fOL https://raw.githubusercontent.com/alice-adventures/docker/main/assets/alire/update-alire.sh && \
    curl -fOL https://raw.githubusercontent.com/alice-adventures/docker/main/assets/code-server/start-code-server.sh && \
    curl -fOL https://raw.githubusercontent.com/alice-adventures/docker/main/assets/code-server/stop-code-server.sh && \
    curl -fOL https://raw.githubusercontent.com/alice-adventures/docker/main/assets/code-server/update-code-server.sh && \
    curl -fOL https://raw.githubusercontent.com/alice-adventures/docker/main/assets/nginx/start-nginx.sh && \
    curl -fOL https://raw.githubusercontent.com/alice-adventures/docker/main/assets/nginx/stop-nginx.sh && \
    curl -fOL https://raw.githubusercontent.com/alice-adventures/docker/main/assets/ttyd/start-ttyd.sh && \
    curl -fOL https://raw.githubusercontent.com/alice-adventures/docker/main/assets/ttyd/stop-ttyd.sh && \
    curl -fOL https://raw.githubusercontent.com/alice-adventures/docker/main/assets/ttyd/update-ttyd.sh && \
    chmod a+x *.sh

WORKDIR /etc/nginx
RUN curl -fOL https://raw.githubusercontent.com/alice-adventures/docker/main/assets/nginx/nginx.conf

WORKDIR /etc/nginx/sites-available
RUN curl -fOL https://raw.githubusercontent.com/alice-adventures/docker/main/assets/nginx/default

WORKDIR /etc/php/${PHP_FPM_VERSION}/fpm/pool.d
RUN curl -fOL https://raw.githubusercontent.com/alice-adventures/docker/main/assets/php/www.conf


### Install & setup Alire

USER ${user_name}
WORKDIR /home/${user_name}
RUN /usr/local/bin/update-alire.sh
RUN alr --no-color index --reset-community
RUN alr --no-color index --add=git+https://github.com/alice-adventures/alice-index --name=alice
RUN alr --no-color index --update-all


### Install & setup Alice

USER ${user_name}
WORKDIR /home/${user_name}
RUN alr --no-color --non-interactive get alice
RUN mv alice_*/ alice

WORKDIR /home/${user_name}/alice
RUN git clone https://github.com/alice-adventures/project_euler.git

WORKDIR /home/${user_name}/alice/project_euler
RUN ./action/usr-setup.sh

WORKDIR /home/${user_name}/alice/project_euler/usr/rocher
RUN alr --non-interactive toolchain --select

USER root
WORKDIR /var/www
RUN rm -rf html && \
    git clone https://github.com/alice-adventures/docker.git -b html html


### Install ttyd

USER ${user_name}
WORKDIR /home/${user_name}
RUN /usr/local/bin/update-ttyd.sh


### Setup & update code-server

USER root
WORKDIR /usr/local/bin
RUN sed --in-place \
    -e "s:auth none:auth ${code_server_auth}:" \
    -e "s:export PASSWORD=1234:export PASSWORD=\"${code_server_password}\":" \
    start-code-server.sh

USER ${user_name}
WORKDIR /home/${user_name}
RUN [ "${code_server}" = "false" ] || /usr/local/bin/update-code-server.sh


### Entrypoint

USER ${user_name}
WORKDIR /home/${user_name}
ENTRYPOINT ["/usr/local/bin/entrypoint.sh"]
