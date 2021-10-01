# Default Ports

This document documents the default ports used by Apps.
These defaults can ofcoarse be changed, but as we guarantee "sane, working defaults" they should provide no or minimal conflicts without being changed


| App                 |  Service  | NodePort | LoadBalancer-Port |  Note                                |
| :------------------ | :-------: | :------: | :---------------: | :----------------------------------: |
| k8s-gateway         |  main     |          |   53/UDP          |   Potenial conflict with pihole      |
| pihole              |  dns      |          |   53/UDP          | Potenial conflict with k8s-gateway   |
| pihole              |  dns-tcp  |          |   53              |                                      |
| Gitea               |  ssh      |          |    2222           |                                      |
| Unifi               |   comm    |          |   8080            |                                      |
| traefik             |   main    |   9000   |                   |                                      |
| traefik             |   web     |          |       9080        |  Adviced to be changed to 80         |
| traefik             | metrics   |   9100   |                   |                                      |
| traefik             | websecure |          |       9443        |  Adviced to be changed to 443        |
| JDownloader2        |   myjd    |  36092   |                   |                                      |
| Plex                |   Main    |  32400   |                   |                                      |
| Handbrake           |   Main    |  36002   |                   |                                      |
| Handbrake           |    VNC    |  36003   |                   |                                      |
| Collabora           |   Main    |  36004   |                   |                                      |
| Deepstack           |   Main    |  36005   |                   |                                      |
| Emby                |   Main    |  36006   |                   |                                      |
| ESPHome             |   Main    |  36007   |                   |                                      |
| Home Assistant      |   Main    |  36008   |                   |                                      |
| Jackett             |   Main    |  36009   |                   |                                      |
| Jellyfin            |   Main    |  36010   |                   |                                      |
| KMS                 |   Main    |  36011   |                   |                                      |
| Lidarr              |   Main    |  36012   |                   |                                      |
| Ombi                |   Main    |  36013   |                   |                                      |
| Lidarr              |   Main    |  36014   |                   |                                      |
| Calibre-Web         |   Main    |  36015   |                   |                                      |
| Radarr              |   Main    |  36016   |                   |                                      |
| Sonarr              |   Main    |  36017   |                   |                                      |
| Tautulli            |   Main    |  36018   |                   |                                      |
| Transmission        |   Main    |  36019   |                   |                                      |
| Transmission        |    TCP    |  36020   |                   |                                      |
| Transmission        |    UDP    |  36020   |                   |                                      |
| NZBGet              |   Main    |  36021   |                   |                                      |
| ZwaveJS2Mqtt        |   Main    |  36022   |                   |                                      |
| ZwaveJS2Mqtt        | Websocket |  36023   |                   |                                      |
| Syncthing           |   Main    |  36024   |                   |                                      |
| Bazarr              |   Main    |  36025   |                   |                                      |
| Deluge              |   Main    |  36026   |                   |                                      |
| Deluge              |    TCP    |  51413   |                   |                                      |
| Deluge              |    UPD    |  51413   |                   |                                      |
| Navidrome           |   Main    |  36027   |                   |                                      |
| Node-RED            |   Main    |  36028   |                   |                                      |
| FreshRSS            |   Main    |  36029   |                   |                                      |
| GAPS                |   Main    |  36030   |                   |                                      |
| Grocy               |   Main    |  36031   |                   |                                      |
| Heimdall            |   Main    |  36032   |                   |                                      |
| Lazy Librarian      |   Main    |  36033   |                   |                                      |
| Lychee              |   Main    |  36034   |                   |                                      |
| Unifi               |   Main    |  36035   |                   |                                      |
| Unifi               |    TCP    |  36036   |                   |                                      |
| Unifi               |    UDP    |  36037   |                   |                                      |
| Readarr             |   Main    |  36038   |                   |                                      |
| QBitTorrent         |   Main    |  36039   |                   |                                      |
| QBitTorrent         |    TCP    |  36040   |                   |                                      |
| QBitTorrent         |    UDP    |  36040   |                   |                                      |
| NZBHydra            |   Main    |  36041   |                   |                                      |
| TVHeadend           |   Main    |  36042   |                   |                                      |
| TVHeadend           |   HTSP    |  36043   |                   |                                      |
| True Command        |   Main    |  36044   |                   |                                      |
| SABnzbd             |   Main    |  36045   |                   |                                      |
| Organizr            |   Main    |  36046   |                   |                                      |
| Podgrab             |   Main    |  36047   |                   |                                      |
| Fireflyiii          |   Main    |  36048   |                   |                                      |
| FocalBoard          |   Main    |  36049   |                   |                                      |
| Airsonic            |   Main    |  36050   |                   |                                      |
| Appdaemon           |   Main    |  36051   |                   |                                      |
| Booksonic-air       |   Main    |  36052   |                   |                                      |
| Calibre             |   Main    |  36053   |                   |                                      |
| Calibre             | WebServer |  36054   |                   |                                      |
| Deconz              |   Main    |  36055   |                   |                                      |
| Deconz              | Websocket |  36056   |                   |                                      |
| Deconz              |    VNC    |  36057   |                   |                                      |
| Dizquetv            |   Main    |  36058   |                   |                                      |
| Duplicati           |   Main    |  36059   |                   |                                      |
| Flaresolverr        |   Main    |  36060   |                   |                                      |
| Flood               |   Main    |  36061   |                   |                                      |
| Gonic               |   Main    |  36062   |                   |                                      |
| Healthchecks        |   Main    |  36063   |                   |                                      |
| Hyperion-ng         |   Main    |  36064   |                   |                                      |
| Komga               |   Main    |  36065   |                   |                                      |
| Librespeed          |   Main    |  36066   |                   |                                      |
| Mealie              |   Main    |  36067   |                   |                                      |
| Mosquitto           |   Main    |  36068   |                   |                                      |
| Mylar               |   Main    |  36068   |                   |                                      |
| Nullserv            |   Main    |  36069   |                   |                                      |
| Nullserv            |   Https   |  36070   |                   |                                      |
| Octoprint           |   Main    |  36071   |                   |                                      |
| Omada-controller    |   Main    |  36072   |                   |                                      |
| Overseerr           |   Main    |  36073   |                   |                                      |
| Owncast             |   Main    |  36074   |                   |                                      |
| Owncast             |   Rtmp    |  36075   |                   |                                      |
| Owncloud-ocis       |   Main    |  36076   |                   |                                      |
| Photoprism          |   Main    |  36077   |                   |                                      |
| Piaware             |   Main    |  36078   |                   |                                      |
| Pretend-youre-xyzzy |   Main    |  36079   |                   |                                      |
| Protonmail-bridge   |   Main    |  36080   |                   |                                      |
| Prowlarr            |   Main    |  36081   |                   |                                      |
| Pyload              |   Main    |  36082   |                   |                                      |
| Reg                 |   Main    |  36083   |                   |                                      |
| Ser2sock            |   Main    |  36084   |                   |                                      |
| Stash               |   Main    |  36085   |                   |                                      |
| Thelounge           |   Main    |  36086   |                   |                                      |
| Xteve               |   Main    |  36087   |                   |                                      |
| Resillio-sync       |   Main    |  36088   |                   |                                      |
| Resillio-sync       |    UDP    |  36089   |                   |                                      |
| Resillio-sync       |    TCP    |  36090   |                   |                                      |
| Nextcloud           |   Main    |  36091   |                   |                                      |
| LittleLink          |   Main    |  36092   |                   |                                      |
| JDownloader2        |   Main    |  36093   |                   |                                      |
| JDownloader2        |    VNC    |  36094   |                   |                                      |
| Authelia            |   Main    |  36095   |                   |                                      |
| Hyperion-ng         |   json    |  36096   |                   |                                      |
| Hyperion-ng         |  protobuf |  36097   |                   |                                      |
| Hyperion-ng         |  boblight |  36098   |                   |                                      |
| OpenLDAP            |  main     |  36099   |                   |                                      |
| OpenLDAP            |  https    |  36100   |                   |                                      |
| pihole              |  main     |  36101   |                   |                                      |
| Sogo                |  main     |  36102   |                   |                                      |
| oscam               |  main     |  36103   |                   |                                      |
| teamspeak3          |  main     |  36104   |                   |                                      |
| teamspeak3          |  query    |  36105   |                   |                                      |
| teamspeak3          |  files    |  36106   |                   |                                      |
| CodeServer          |  ADDON    |  36107   |                   |                                      |
| Gitea               |  main     |  36108   |                   |                                      |

##### Note: TCP and UPD ports that are the same in each App, are not by mistake.
