---
title: talos upgrade
---
## clustertool talos upgrade

Upgrade Talos Nodes and Kubernetes

### Synopsis

The "upgrade" command updates Talos to the latest version specified in talconfig.yaml for all nodes.
It also applies any changed "extentions" and/or "overlays" specified there.

On top of this, after upgrading Talos on all nodes, it also executes kubernetes-upgrades for the whole cluster as well.

```
clustertool talos upgrade [flags]
```

### Examples

```
clustertool upgrade <NodeIP>
```

### Options

```
  -h, --help   help for upgrade
```

### Options inherited from parent commands

```
      --cluster string   Cluster name (default "main")
```
