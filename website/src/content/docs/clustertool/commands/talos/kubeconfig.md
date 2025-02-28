---
title: talos kubeconfig
---
## clustertool talos kubeconfig

The `kubeconfig` command downloads the admin kubeconfig file from the Talos node in order to manage the Kubernetes cluster with the `kubectl` command.

### Usage

```
clustertool talos kubeconfig <NodeIP> [flags]
```

`<NodeIP>` is an optional argument that specifies the Talos node from which to download the configuration file. You can use `all` to select all nodes. By default, this is set to `all`.

### Examples

```
clustertool talos kubeconfig all
```

### Options

```
  -h, --help   help for talos kubeconfig
```

### Options inherited from parent commands

```
  --cluster string   Cluster name (default "main")
```
