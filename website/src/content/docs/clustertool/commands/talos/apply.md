---
title: talos apply
---
## clustertool talos apply

apply

### Synopsis

The "apply" command applies your Talos System configuration to each node in the cluster, existing or new It also runs automated checking of your config file and health checks between each node it has processed, to ensure you don't accidentally take down your whole cluster.

## Bootstrapping
If the cluster has not been bootstrapped yet, Apply will automatically detect this and ask if you want to bootstrap the cluster

Bootstrapping will apply your config to the first (top) controlplane node in your "talconfig.yaml", it then "bootstraps" hence creating a new cluster with said node.

After this is done, we apply a number of helm-charts and manifests by default such as:

- Metallb
- Metallb-Config
- Cilium (CNI)
- Certificate-Approver
- Spegel
- Kubernetes-Dashboard

### Bootstrapping FluxCD

During Bootstrapping, if a "GITHUB_REPOSITORY" is set in "clusterenv.yaml", you will be asked if you also want to bootstrap FluxCD, checkout the getting-started guide for more info

## About Bootstrapping

While we load a lot of helm-charts during bootstrap, we will *never* manage them for you.
You're responsible for maintaining and configuring your cluster after bootstrapping.

Apply and *all other* commands, are just for maintaining Talos itself.
Not any contained helm-charts

```
clustertool talos apply [flags]
```

### Examples

```
clustertool apply <NodeIP>
```

### Options

```
  -h, --help   help for apply
```

### Options inherited from parent commands

```
      --cluster string   Cluster name (default "main")
```
