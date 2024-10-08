## Config Options

There are a lot of possibly configuration options in config.yml.
For jail specific config options, please see the wiki documentation for your specific jail. This page only list general and global config options, that are the same for every jail.

## Global config options

Global options apply to every jail. Use and change with caution.

### dataset

All config options under "dataset" change dataset creation and linking. The indentation and "dataset" flag are not optional.
All Datasets are auto-created if they do not exist already, no need to worry about creating them!

- config: The dataset that is going to contain the persistant data for every jail. For example: Nextcloud user files for nextcloud or the actual database for mariadb.
- iocage: The dataset containing the iocage config. In FreeNAS often `poolname/iocage`
- media: The dataset that is going to contain all media files for plex, Sonarr, Radarr etc. Such as movies and music. Music, Movie etc. sub-datasets are auto-created.
- downloads: The dataset containging temporary download files. These are moved to media when finished. complete, incomplete etc. sub-datasets are auto-created.

## jails

All config options under "jails" change default jail settings that are the same for every created jail. The indentation and "jails" flag are not optional.

- version: the current to-be-installed version for jails
- pkgs: packages that are installed to all created jails

## (hidden) Auto created datasets

Some datasets are auto created and can not be changed from the config file. This is done to ease troubleshooting.

- `media/music` created as a sub-dataset of media, contains music
- `media/movies` created as a sub-dataset of media, contains movies
- `media/shows` created as a sub-dataset of media, contains tv-shows
- `downloads/complete` created as a sub-dataset of downloads, contains completed downloads
- `downloads/incomplete` created as a sub-dataset of downloads, contains not-yet-completed downloads

## General config options

### Networking

Please be aware that dhcp is not actively supported, many of the jails depend on having a fixed IP-adress in the config file.
Some also depend on other jails having a fixed IP in the config file. Use of DHCP is on your own risk and might not work.

- ip4_addr: To set a static IP (recommended), enter the desired ip address here. Leave blank (or remove the line) for DHCP.
- gateway: Set the gateway IP for static IP setup. Leave blank (or remove the line) for DHCP.

### Advanced

- interfaces: Set the "interfaces" flag for iocage. Example: `vnet0:bridge0` (optional)
- dhcp: Set to "on" to force DHCP (not required for DHCP, see above)
- pkgs: Override the to-be-install packages for this jail (might break now or break updates)
