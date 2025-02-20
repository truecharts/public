---
title: How-To
---

This is a quick setup-guide to run Docusaurus on your own server.

## Requirements

None necessary, a domain name is recommended for usage but not required.

## Docusaurus Chart Setup

### Environment variables

- WEBSITE_NAME: Your website name
- TEMPLATE: Docusaurus Default Template is generally `classic` unless you've manually installed another
- RUN_MODE: Choose between `production` and `development` mode

```yaml
workload:
  main:
    podSpec:
      containers:
        main:
          env:
            WEBSITE_NAME: "Docusaurus HomeLab Website"
            TEMPLATE: classic
            RUN_MODE: development
```

### Storage and Persistance

This chart uses PVC for storage, as do most of our charts. However, some users may need to frequently edit certain files or directories.
A simple way to edit files inside the container is by using our [CodeServer](/guides/addons/code-server) Add-on. It provides a web-based file editor and is intended for temporary use, allowing you to add or remove it at any time.

While it is possible to mount a specific folder to an external storage location, such as an NFS share, this approach is not recommended as it adds complexity. By default, the PVC mounts **/docusaurus**, meaning all files in **/docusaurus/website/docs** are stored within the PVC. If you choose to mount an external share, you must ensure that the required files are manually placed in the new location, as they will not be copied over automatically.

```yaml
persistence:
  docs:
    enabled: true
    type: nfs
    path: ${NFS_PATH}
    server: ${SERVER_IP}
    mountPath: /docusaurus/website/docs
```

## Support

If you need more details or have a more customized setup, the documentation on the [upstream](https://github.com/facebook/docusaurus) repository is very comprehensive. Check the descriptions of the available options there for further guidance.
