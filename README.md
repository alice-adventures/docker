[![GitHub release](https://img.shields.io/github/release/alice-adventures/docker.svg)](https://github.com/alice-adventures/docker/releases/latest)
[![License](https://img.shields.io/github/license/alice-adventures/docker.svg?color=blue)](https://github.com/alice-adventures/docker/blob/master/LICENSE)

<img src="https://raw.githubusercontent.com/wiki/alice-adventures/Alice/Alice_Adventures.png" width="250" />

# Alice Docker

> Alice : _Adventures for Learning and Inspiring Coding Excellence_


### Repository components

Each branch of this repository contains a component used during the build stage
of the Alice docker image:

  * `main` branch contains the `Dockerfile`

  * `html` branch contains few web pages to be installed in the docker


### Docker build

Build your own image with the command

```sh
docker build --tag alice-adventures:0.1.1 https://raw.githubusercontent.com/alice-adventures/docker/main/Dockerfile
```

#### Build arguments

You can pass several arguments to the docker builder to customize your
installation. All these variables can be assigned a value with

```sh
docker build --build-arg VARIABLE=VALUE --build-arg FOO=BAR  ...
```

  * If you plan to share docker volumes with your host, these variables will
    help you with the integration

    | variable     | default value / notes                        |
    |--------------|----------------------------------------------|
    | `user_name`  | `guest`                                      |
    | `group_name` | `${user_name}` / also member of group `sudo` |
    | `uid`        | `1000`                                       |
    | `gid`        | `1000`                                       |
    | `timezone`   | `UTC` / e.g. `CET`, `UTC+2`, `GMT-5`         |

  * This docker installs by default  a copy of
    [code-server](https://code.visualstudio.com/docs/remote/vscode-server), a
    tailored version of [vscode](https://code.visualstudio.com/) to enable
    remote development. These variables will hel you with the installation:

    | variable               | default value / notes                   |
    |------------------------|-----------------------------------------|
    | `code_server`          | `true` / `false` skips installation     |
    | `code_server_auth`     | `none` / can be set to `password`       |
    | `code_server_password` | `1234` / only numbers, letters, and '_' |

    Notes:

      + Please read these
        [notes](https://code.visualstudio.com/docs/remote/vscode-server#_common-questions)
        about its usage and license.

      * If you do not install code-server, you will still be able to access all
        Alice docker content by other means, such as sharing a docker volume
        with your host, using vscode in your host and connecting to a remote
        docker, or even entering the Alice docker container and installing Emacs
        or vi.

      * Additional parameters passed when code-server is started:

        + `--disable-telemetry`
        + `--bind-addr <DOCKER_IP_ADDR>:$CODE_SERVER_PORT`
        + `--ignore-last-opened`
        + `--welcome-text ...` only visible with password


### Docker run

Run an instance of your docker image with

```sh
docker run --detach --tty --name alice --hostname wland -p 47800:47800 alice-adventures:0.1.1
```


### Enter Wonderland

Open your preferred browser in your host and connect to `http://IP_address`
of the container, for example: `http://172.17.0.1` (do not use `https`). If
unsure, inspect the IP address the alice container:

```sh
docker inspect --format {{.NetworkSettings.IPAddress}} alice
```


### Docker management

Some reminders:

  * Stop / restart Alice docker:

    ```sh
    docker stop alice
    docker restart alice
    ```

  * Enter Wonderland to see what's inside:

    ```sh
    docker exec -it alice bash
    ```


### Current version

Current Alice docker version is `0.1.1`.


### Planned for future releases

  * Optionally include GNAT Studio community release

  * Optionally skip automatic setup of Alire and Alice and explain step by step
    all required work once the docker starts.

  * Better support for exploring problem sources and provided solutions.

---
### License
MIT (c) 2023 Francesc Rocher
