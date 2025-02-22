---
title: Installation Notes
---

This document will provide information on the successful setup of qBitrr.

## qBitrr config.toml

Upon first run qBbitrr will download a config.toml file from the upstream developer. This file is just a template and will need to be modified before qBitrr begins operating. It is recommended that when configuring initial install to also enable the codeserver addon so that you can modify the config.toml file.

### Settings

This section has basic qBitrr settings. You may modify any as you choose but the `CompletedDownloadFolder` option should be set to `"/completed_downloads"` as that is what the `values.yaml` is mapped to.

```yaml
// values.yaml
persistence:
  downloads:
    enabled: true
    type: nfs
    path: /mnt/data/media/downloads
    mountPath: /completed_downloads
    server: 192.168.0.100
```

:::caution[Completed Download Folder]

If `CompletedDownloadFolder` option is not set for the download directory of qbittorrent then qbitrr will not work. We recommend sticking with the setup as described above.

:::

### qBit

This section has qBittorrent specific settings. Ensure that `Host`, `Port`, `UserName`, and `Password` all match your qBittorrent installation. We recommend using internal URL's (e.g.: `http://qbittorrent.qbittorrent.svc.cluster.local`).

### Sonarr/Radarr

The following sections have Sonarr/Radarr specific settings. The template configuration file populates two instances for both Sonarr and Radarr by default. These can be renamed/deleted/duplicated as needed to match your setup (any number os Sonarr/Radarr instances are supported). Ensure that `URI`, `API` and `Category` are set correctly so that qBitrr can communicate with your Sonarr and Radarr installation. You should use the internal URL again (e.g.: `URI = "http://sonarr.sonarr.svc.cluster.local:8989/"`). The `Category` is what you have set in Sonarr/Radarr to use in qBittorrent (ie. movies, tv).

### Remaining Sonarr/Radarr Configurations

All of the following sections can be configured based on personal preference. If you chose to rename or delete any of the predefined templates ensure you follow the same schema for the remaining sections.
