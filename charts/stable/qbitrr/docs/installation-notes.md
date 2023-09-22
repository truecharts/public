# Installation Notes
This document will provide information on the successful setup of qBitrr.

## qBitrr config.toml
Upon first run qBbitrr will download a config.toml file from the upstream developer. This file is just a template and will need to be modified before qBitrr begins operating. It is recommended that when configuring initial install to also enable the codeserver addon so that you can modify the config.toml file.

## qBitrr Application Configurations
Most of the configurations can remain the default. You will need to map your qBittorrent root download directory to App Completed Download Storage as shown below.

![qbit-downloads](./img/qbit-downloads.png)

You should also enable the codeserver addon as previously discussed.

![qbitrr-codeserver](./img/qbitrr-codeserver.png)

## config.toml
Once qBitrr has started access the config.toml file using the previously configured `http://<ip address>:<port>` that was setup for the codeserver addon.

### Settings
This section has basic qBitrr settings. You may modify any as you choose but the `CompletedDownloadFolder` option must be set to `"/completed_downloads"` as that is what the App Completed Download Storage is mapped to.

:::warning Completed Download Folder

If `CompletedDownloadFolder` option is not set to  `"/completed_downloads"` qBitrr will not be able to find any downloads.

:::

### qBit
This section has qBittorrent specific settings. Ensure that `Host`, `Port`, `UserName`, and `Password` all match your qBittorrent installation. The host and port can be located using the Heavyscript `heavyscript dns -a` command.

### Sonarr/Radarr
The following sections have Sonarr/Radarr specific settings. The template configuration file populates two instances for both Sonarr and Radarr by default. These can be renamed/deleted as needed to match your setup. Ensure that `URI`, `API` and `Category` are set correctly so that qBitrr can communicate with your Sonarr and Radarr installations. The `Category` is what you have set in Sonarr/Radarr to use in qBittorrent (ie. movies, tv).

### Remaining Sonarr/Radarr Configurations
All of the following sections can be configured based on personal preference. If you chose to rename or delete any of the predefined templates ensure you follow the same schema for the remaining sections. It is recommended that `SearchMissing` be set to false. qBitrr will not have access to your Sonarr/Radarr database file unless they are configured in an unsupported manner. This will disable that functionality.

