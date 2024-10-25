---
title: decrypt
---
## clustertool decrypt

Decrypt all high-risk data using sops

### Synopsis

The decryption feature of ClusterTool goes over all config files and, if encrypted, checks if ".sops.yaml" specifies that they should be decrypted.
If so, they are decrypted using your "age.agekey" file as specified in ".sops.yaml".

```
clustertool decrypt [flags]
```

### Examples

```
clustertool decrypt
```

### Options

```
  -h, --help   help for decrypt
```

### Options inherited from parent commands

```
      --cluster string   Cluster name (default "main")
```
