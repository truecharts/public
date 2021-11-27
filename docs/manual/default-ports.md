# Default Ports

This document documents the default ports used by Apps.
These defaults can of course be changed, but as we guarantee "sane, working defaults" they should provide no or minimal conflicts without being changed

## Core Apps

| App         | Service | Port Name | Port | Protocol | Note |
| :---------- | :-----: | :-------: | :--: | :------: | :--: |
| k8s-gateway |  main   |   main    |  53  |   UDP    |      |
| traefik     |  main   |   main    | 9000 |   HTTP   |      |
| traefik     |   tcp   |    web    | 9080 |   HTTP   |      |
| traefik     |   tcp   | websecure | 9443 |  HTTPS   |      |
| traefik     | metrics |  metrics  | 9100 |   HTTP   |      |

## Stable Apps

## Incubator Apps

## Dependecy Apps




# To be discarded when done

| App                        |  Service   | Port  | Target Port | LoadBalancer-Port |                Note                 |
| :------------------------- | :--------: | :---: | :---------: | :---------------: | :---------------------------------: |
| Airsonic                   |    main    | 36050 |             |                   |                                     |
| Apache-Musicindex          |    main    | 36113 |             |                   |                                     |
| Appdaemon                  |    main    | 36051 |             |                   |                                     |
| Aria2                      |    main    | 36111 |             |                   |                                     |
| Aria2                      |   listen   | 36110 |             |                   |                                     |
| Audacity                   |    main    | 36112 |             |                   |                                     |
| Authelia                   |    main    | 36095 |             |                   |                                     |
| Babybuddy                  |    main    | 36153 |             |                   |                                     |
| Bazarr                     |    main    | 36025 |             |                   |                                     |
| Beets                      |    main    | 36114 |             |                   |                                     |
| Booksonic-air              |    main    | 36052 |             |                   |                                     |
| Calibre                    |    main    | 36053 |             |                   |                                     |
| Calibre                    | webserver  | 36054 |             |                   |                                     |
| Calibre-Web                |    main    | 36015 |             |                   |                                     |
| Cloud9                     |    main    | 36115 |             |                   |                                     |
| Code-Server                |    main    | 36116 |             |                   |                                     |
| CodeServer                 |   ADDON    | 36107 |             |                   |                                     |
| Collabora                  |    main    | 36004 |             |                   |                                     |
| Cryptfolio                 |    main    | 36145 |             |                   |                                     |
| Davos                      |    main    | 36117 |             |                   |                                     |
| Deconz                     |    main    | 36055 |             |                   |                                     |
| Deconz                     |    vnc     | 36057 |             |                   |                                     |
| Deconz                     | websocket  | 36056 |             |                   |                                     |
| Deepstack-cpu              |    main    | 36005 |             |                   |                                     |
| Deepstack-gpu              |    main    | 36148 |             |                   |                                     |
| Deluge                     |    main    | 36026 |             |                   |                                     |
| Deluge                     |    tcp     | 51413 |             |                   |                                     |
| Deluge                     |    udp     | 51413 |             |                   |                                     |
| Digikam                    |    main    | 36118 |             |                   |                                     |
| Dizquetv                   |    main    | 36058 |             |                   |                                     |
| Doublecommander            |    main    | 36119 |             |                   |                                     |
| Dsmr-reader                |    main    | 36154 |             |                   |                                     |
| Duplicati                  |    main    | 36059 |             |                   |                                     |
| Emby                       |    main    | 36006 |             |                   |                                     |
| ESPHome                    |    main    | 36007 |             |                   |                                     |
| Etherpad                   |    main    | 36156 |             |                   |                                     |
| Filezilla                  |    main    | 36120 |             |                   |                                     |
| Fireflyiii                 |    main    | 36048 |             |                   |                                     |
| Firefox-syncserver         |    main    | 36157 |             |                   |                                     |
| Flaresolverr               |    main    | 36060 |             |                   |                                     |
| Flood                      |    main    | 36061 |             |                   |                                     |
| FocalBoard                 |    main    | 36049 |             |                   |                                     |
| Fossil                     |    main    | 36121 |             |                   |                                     |
| FreshRSS                   |    main    | 36029 |             |                   |                                     |
| GAPS                       |    main    | 36030 |             |                   |                                     |
| Gitea                      |    main    | 36108 |             |                   |                                     |
| Gitea                      |    ssh     |       |    2222     |                   |                                     |
| Golinks                    |    main    | 36122 |             |                   |                                     |
| Gonic                      |    main    | 36062 |             |                   |                                     |
| Gotify                     |    main    | 36158 |             |                   |                                     |
| Grav                       |    main    | 36123 |             |                   |                                     |
| Grocy                      |    main    | 36031 |             |                   |                                     |
| Handbrake                  |    main    | 36002 |             |                   |                                     |
| Handbrake                  |    vnc     | 36003 |             |                   |                                     |
| Headphones                 |    main    | 36124 |             |                   |                                     |
| Healthchecks               |    main    | 36063 |             |                   |                                     |
| Heimdall                   |    main    | 36032 |             |                   |                                     |
| Home Assistant             |    main    | 36008 |             |                   |                                     |
| Hyperion-ng                |    json    | 36096 |             |                   |                                     |
| Hyperion-ng                |    main    | 36064 |             |                   |                                     |
| Hyperion-ng                |  boblight  | 36098 |             |                   |                                     |
| Hyperion-ng                |  protobuf  | 36097 |             |                   |                                     |
| Icantbelieveitsnotvaketudo |    main    | 36144 |             |                   |                                     |
| Jackett                    |    main    | 36009 |             |                   |                                     |
| JDownloader2               |    main    | 36093 |             |                   |                                     |
| JDownloader2               |    myjd    | 36092 |             |                   |                                     |
| JDownloader2               |    vnc     | 36094 |             |                   |                                     |
| Jellyfin                   |    main    | 36010 |             |                   |                                     |
| Joplin-server              |    main    | 36159 |             |                   |                                     |
| k8s-gateway                |    main    |       |   53/UDP    |                   |   Potential conflict with pihole    |
| Kanboard                   |    main    | 36160 |             |                   |                                     |
| KMS                        |    main    | 36011 |             |                   |                                     |
| Komga                      |    main    | 36065 |             |                   |                                     |
| Lazy Librarian             |    main    | 36033 |             |                   |                                     |
| Librespeed                 |    main    | 36066 |             |                   |                                     |
| Librespeed                 |    main    | 36161 |             |                   |                                     |
| Lidarr                     |    main    | 36012 |             |                   |                                     |
| Lidarr                     |    main    | 36014 |             |                   |                                     |
| LittleLink                 |    main    | 36092 |             |                   |                                     |
| Lychee                     |    main    | 36034 |             |                   |                                     |
| Mealie                     |    main    | 36067 |             |                   |                                     |
| Medusa                     |    main    | 36125 |             |                   |                                     |
| Miniflux                   |    main    | 36162 |             |                   |                                     |
| Minio-console              |    main    | 36143 |             |                   |                                     |
| Mosquitto                  |    main    | 36068 |             |                   |                                     |
| Mstream                    |    main    | 36126 |             |                   |                                     |
| Muximux                    |    main    | 36127 |             |                   |                                     |
| Mylar                      |    main    | 36068 |             |                   |                                     |
| Navidrome                  |    main    | 36027 |             |                   |                                     |
| Nextcloud                  |    main    | 36091 |             |                   |                                     |
| Node-RED                   |    main    | 36028 |             |                   |                                     |
| Notes                      |    main    | 36128 |             |                   |                                     |
| NoVNC                      |    main    | 36129 |             |                   |                                     |
| Nullserv                   |    main    | 36069 |             |                   |                                     |
| Nullserv                   |   https    | 36070 |             |                   |                                     |
| NZBGet                     |    main    | 36021 |             |                   |                                     |
| NZBHydra                   |    main    | 36041 |             |                   |                                     |
| Octoprint                  |    main    | 36071 |             |                   |                                     |
| Odoo                       |    main    | 36163 |             |                   |                                     |
| Odoo                       |   odoo-1   | 36164 |             |                   |                                     |
| Odoo                       |   odoo-2   | 36165 |             |                   |                                     |
| Omada-controller           |    main    | 36072 |             |                   |                                     |
| Ombi                       |    main    | 36013 |             |                   |                                     |
| OnlyOffice-Document-Server |    main    | 36109 |             |                   |                                     |
| Openkm                     |    main    | 36166 |             |                   |                                     |
| OpenLDAP                   |    main    | 36099 |             |                   |                                     |
| OpenLDAP                   |   https    | 36100 |             |                   |                                     |
| Organizr                   |    main    | 36046 |             |                   |                                     |
| oscam                      |    main    | 36103 |             |                   |                                     |
| Overseerr                  |    main    | 36073 |             |                   |                                     |
| Owncast                    |    main    | 36074 |             |                   |                                     |
| Owncast                    |    rtmp    | 36075 |             |                   |                                     |
| Owncloud-ocis              |    main    | 36076 |             |                   |                                     |
| Photoprism                 |    main    | 36077 |             |                   |                                     |
| Photoshow                  |    main    | 36130 |             |                   |                                     |
| Piaware                    |    main    | 36078 |             |                   |                                     |
| pihole                     |    dns     |       |   53/UDP    |                   | Potential conflict with k8s-gateway |
| pihole                     |    main    | 36101 |             |                   |                                     |
| pihole                     |  dns-tcp   |       |     53      |                   |                                     |
| Piwigo                     |    main    | 36131 |             |                   |                                     |
| Pixapop                    |    main    | 36132 |             |                   |                                     |
| Plex                       |    main    | 32400 |             |                   |                                     |
| Podgrab                    |    main    | 36047 |             |                   |                                     |
| Pretend-youre-xyzzy        |    main    | 36079 |             |                   |                                     |
| Protonmail-bridge          |    main    | 36080 |             |                   |                                     |
| Prowlarr                   |    main    | 36081 |             |                   |                                     |
| Pyload                     |    main    | 36082 |             |                   |                                     |
| QBitTorrent                |    main    | 36039 |             |                   |                                     |
| QBitTorrent                |    tcp     | 36040 |             |                   |                                     |
| QBitTorrent                |    udp     | 36040 |             |                   |                                     |
| Radarr                     |    main    | 36016 |             |                   |                                     |
| Readarr                    |    main    | 36038 |             |                   |                                     |
| Recipes                    |    main    | 36167 |             |                   |                                     |
| Reg                        |    main    | 36083 |             |                   |                                     |
| Remmina                    |    main    | 36133 |             |                   |                                     |
| Resillio-sync              |    main    | 36088 |             |                   |                                     |
| Resillio-sync              |    tcp     | 36090 |             |                   |                                     |
| Resillio-sync              |    udp     | 36089 |             |                   |                                     |
| SABnzbd                    |    main    | 36045 |             |                   |                                     |
| Ser2sock                   |    main    | 36084 |             |                   |                                     |
| Shiori                     |    main    | 36168 |             |                   |                                     |
| Shorturl                   |    main    | 36134 |             |                   |                                     |
| Sickchill                  |    main    | 36135 |             |                   |                                     |
| Sickgear                   |    main    | 36136 |             |                   |                                     |
| Smokeping                  |    main    | 36137 |             |                   |                                     |
| Sogo                       |    main    | 36102 |             |                   |                                     |
| Sonarr                     |    main    | 36017 |             |                   |                                     |
| Sqlitebrowser              |    main    | 36138 |             |                   |                                     |
| Stash                      |    main    | 36085 |             |                   |                                     |
| Static                     |    main    | 36139 |             |                   |                                     |
| Statping                   |    main    | 36169 |             |                   |                                     |
| Syncthing                  |    main    | 36024 |             |                   |                                     |
| Tautulli                   |    main    | 36018 |             |                   |                                     |
| Tdarr                      |    comm    | 36152 |             |                   |                                     |
| Tdarr                      |    main    | 36151 |             |                   |                                     |
| Tdarr-node                 |    main    | 36150 |             |                   |                                     |
| teamspeak3                 |    main    | 36104 |             |                   |                                     |
| teamspeak3                 |   files    | 36106 |             |                   |                                     |
| teamspeak3                 |   query    | 36105 |             |                   |                                     |
| Teedy                      |    main    | 36170 |             |                   |                                     |
| Thelounge                  |    main    | 36086 |             |                   |                                     |
| Traccar                    |    main    | 36171 |             |                   |                                     |
| traefik                    |    main    | 9000  |             |                   |                                     |
| traefik                    |    web     |       |    9080     |                   |     Adviced to be changed to 80     |
| traefik                    |  metrics   | 9100  |             |                   |                                     |
| traefik                    | websecure  |       |    9443     |                   |    Adviced to be changed to 443     |
| Transmission               |    main    | 36019 |             |                   |                                     |
| Transmission               |    tcp     | 36020 |             |                   |                                     |
| Transmission               |    udp     | 36020 |             |                   |                                     |
| True Command               |    main    | 36044 |             |                   |                                     |
| Tt-rss                     |    main    | 36172 |             |                   |                                     |
| TVHeadend                  |    htsp    | 36043 |             |                   |                                     |
| TVHeadend                  |    main    | 36042 |             |                   |                                     |
| Twtxt                      |    main    | 36140 |             |                   |                                     |
| Unifi                      |    comm    |       |    8080     |                   |                                     |
| Unifi                      |    main    | 36035 |             |                   |                                     |
| Unifi                      |    tcp     | 36036 |             |                   |                                     |
| Unifi                      |    udp     | 36037 |             |                   |                                     |
| Uptime-Kuma                |    main    | 36149 |             |                   |                                     |
| Valheim                    |    main    | 36146 |             |                   |                                     |
| Valheim                    | supervisor | 36147 |             |                   |                                     |
| Valheim                    | valheim-1  |       |  2456/UDP   |                   |                                     |
| Whoogle                    |    main    | 36142 |             |                   |                                     |
| WIkijs                     |    main    | 36155 |             |                   |                                     |
| Xteve                      |    main    | 36087 |             |                   |                                     |
| Zigbee2mqtt                |    main    | 36141 |             |                   |                                     |
| ZwaveJS2Mqtt               |     ws     | 36023 |             |                   |                                     |
| ZwaveJS2Mqtt               |    main    | 36022 |             |                   |                                     |

##### Note: TCP and UPD ports that are the same in each App, are not by mistake.
