---
title: checkcrypt
---
## clustertool checkcrypt

Checks if all files are encrypted correctly in accordance with .sops.yaml

### Synopsis

It's imperative that you always ensure the config you send to the internet is thoroughly encrypted. Using "clustertool checkcrypt" you can easily check if all files that are due to being encrypted, as specified in ".sops.yaml", will actually be encrypted.

This tool can, for example, be used as a pre-commit check and will fail with a non-zero exit code if unencrypted files are detected that should've been encrypted in accordance with ".sops.yaml" configuration.

```
clustertool checkcrypt [flags]
```

### Examples

```
clustertool checkcrypt
```

### Options

```
  -h, --help   help for checkcrypt
```

### Options inherited from parent commands

```
      --cluster string   Cluster name (default "main")
```
