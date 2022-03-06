# 13 - Docker-Compose on SCALE

While Docker-Compose is not officially supported by iX Systems, we have designed a special "Docker-Compose" App, that is available in the "core" train.
This App can be used to easily deploy a compose file in a completely isolated docker-compose environment.

Our Docker-Compose app has the following features:

- Binding ports to the host, directly from docker-compose

- Internal Docker-Compose networks

- `/mnt`, `/root` and `/mnt` are directly accessable inside the Docker-Compose container by default

- The docker-images and docker volumes, are saved in a special PVC inside the Apps system of TrueNAS SCALE

- Compose files can be automatically loaded on the start of our Docker-Compose App

- Will fully survive updates of TrueNAS SCALE

- Will not alter the Host OS

- Can be combined with SCALE App, to enable users to slowly migrate from docker-compose to native SCALE Apps


A few things to be aware of:

- To issue commands to docker or docker compose, you need to be inside the Docker-Compose App shell (not the host Shell)

- Please ensure your Docker-Compose networks do not conflict with the Kubernetes networks listed in the settings of the SCALE Apps system.

- Please be aware that Docker-Compose containers, by cannot reach inside the kubernetes network. So you cannot combine a "Launch Docker" container with a Docker-Compose hosted database for example.

Simply put:
Our docker-compose solution works almost like using it on the host, but without compromising the Appliance OS that is TrueNAS SCALE.

#### Video Guide

TBD

##### Additional Documentation
