IPFS
=====

[IPFS](https://ipfs.io) is a global, versioned, peer-to-peer filesystem. It combines good ideas from previous systems such Git, BitTorrent, Kademlia, SFS, and the Web. It is like a single bittorrent swarm, exchanging git objects. IPFS provides an interface as simple as the HTTP web, but with permanence built in. You can also mount the world at /ipfs.

Introduction
------------

This chart bootstraps IPFS deployment on a [Kubernetes](http://kubernetes.io) cluster using the [Helm](https://helm.sh) package manager.


Configuration
-------------

The following table lists the configurable parameters of the IPFS chart and their default values.

| Parameter                                        | Description                                                                                                                             | Default                          |
|:-------------------------------------------------|:----------------------------------------------------------------------------------------------------------------------------------------|:---------------------------------|
| `image.repository`                               | Image repository                                                                                                                        | `ipfs/go-ipfs`                    |
| `image.tag`                                      | IPFS image tag. Possible values listed [here](https://hub.docker.com/r/ipfs/go-ipfs/tags).                                              | `v0.8.0-rc1`   |
| `image.pullPolicy`                               | Image pull policy                                                                                                                       | `IfNotPresent`                   |
| `extraArgs`                                      | Additional command line arguments to pass to the IPFS server                                                                            | `[]`                             |
