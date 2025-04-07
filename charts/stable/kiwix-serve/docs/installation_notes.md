---
title: Installation Notes
---

You need to have at least one `.zim` file.

You can download a `.zim` file from [here](https://wiki.kiwix.org/wiki/Content)

## ZIM Files

### For 1 `.zim` file:

- Add a download link with an env. `DOWNLOAD`. You have to remove the link afterwards, otherwise it will keep re-downloading the file on each deployment.

```yaml
workload:
  main:
    podSpec:
      containers:
        main:
          env:
            DOWNLOAD: http://download.kiwix.org/zim/wikipedia_en_chemistry_nopic.zim
```

### For 1 or more `.zim` files:

- `/Data` is included in the chart as persistence storage, connect this for example to a NFS share and place your `.zim` files there. More information about persistence storage can be found in the common documentation.
