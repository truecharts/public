---
title: clustertool genconfig
---
## clustertool genconfig

generate Configuration files

### Synopsis

ClusterTool after all your settings are entered into talconfig.yaml and talenv.yaml, Clustertool generates a complete clusterconfiguration using TalHelper and various other tools.

Its important to note, that running clustertool genconfig, again after each settings change, is absolutely imperative to be able to deploy said settings to your cluster.

Powered by TalHelper (https://budimanjojo.github.io/talhelper/)

```
clustertool genconfig [flags]
```

### Examples

```
clustertool genconfig
```

### Options

```
  -h, --help   help for genconfig
```

### Options inherited from parent commands

```
      --cluster string   Cluster name (default "main")
```
