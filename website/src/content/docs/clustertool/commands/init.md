---
title: init
---
## clustertool init

generate Basic ClusterTool file-and-folder structure in current folder

### Synopsis

ClusterTool requires a specific directory layout to ensure smooth operators and standardised environments.

To ensure smooth deployment, the init function can pre-generate all required files in the right places.
Afterwards, you can edit talconfig.yaml and clusterenv.yaml to reflect your personal settings.

When done, please run clustertool genconfig to generate all configurations based on your personal settings.

```
clustertool init [flags]
```

### Examples

```
clustertool init
```

### Options

```
  -h, --help   help for init
```

### Options inherited from parent commands

```
      --cluster string   Cluster name (default "main")
```
