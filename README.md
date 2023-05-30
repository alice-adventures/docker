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


### Docker run

Run an instance of your docker image with

```sh
docker run --detach --tty --name alice --hostname wland alice-adventures:0.1.1
```


### Enter Wonderland

Open your preferred browser in your host and connect to `http://IP_address`
of the container, for example: `http://172.17.0.1` (do not use `https`). If
unsure, inspect the IP address the alice container:

```sh
docker inspect --format {{.NetworkSettings.IPAddress}} alice
```



### Current version

Current Alice docker version is `0.1.1`.


---
### License
MIT (c) 2023 Francesc Rocher
