# Default Ports

This document documents the default ports used by Apps.
These defaults can of course be changed, but as we guarantee "sane, working defaults" they should provide no or minimal conflicts without being changed

## Core Apps

| App         |   Service    |  Port Name   | Port  | Protocol | Note |
| :---------- | :----------: | :----------: | :---: | :------: | :--: |
| k8s-gateway |     main     |     main     |  53   |   UDP    |      |
| prometheus  |     main     |     main     | 10086 |   HTTP   |      |
| prometheus  |    promop    |    promop    | 10089 |   HTTP   |      |
| prometheus  | alertmanager | alertmanager | 10087 |   HTTP   |      |
| prometheus  |    thanos    |    thanos    | 10901 |   HTTP   |      |
| traefik     |     main     |     main     | 9000  |   HTTP   |      |
| traefik     |     tcp      |     web      | 9080  |   HTTP   |      |
| traefik     |     tcp      |  websecure   | 9443  |  HTTPS   |      |
| traefik     |   metrics    |   metrics    | 9100  |   HTTP   |      |

## Stable Apps

| App                        |     Service     |    Port Name    | Port  | Protocol |       Note       |
| :------------------------- | :-------------: | :-------------: | :---: | :------: | :--------------: |
| amcrest2mqtt               |      main       |      main       |   -   |    -     | Service disabled |
| airsonic                   |      main       |      main       | 4040  |   TCP    |                  |
| apache-musicindex          |      main       |      main       |  10006   |   TCP    |                  |
| appdaemon                  |      main       |      main       | 5050  |   TCP    |                  |
| appdaemon                  |       tcp       |       tcp       | 51050 |   TCP    |                  |
| aria2                      |      main       |      main       | 6800  |   TCP    |                  |
| aria2                      |     listen      |     listen      | 6888  |   TCP    |                  |
| audacity                   |      main       |      main       | 3000  |   TCP    |                  |
| authelia                   |      main       |      main       | 9091  |   TCP    |                  |
| babybuddy                  |      main       |      main       | 8000  |   TCP    |                  |
| bazarr                     |      main       |      main       | 6767  |   TCP    |                  |
| beets                      |      main       |      main       | 8337  |   TCP    |                  |
| booksonic-air              |      main       |      main       | 4040  |   TCP    |                  |
| calibre                    |      main       |      main       | 8080  |   TCP    |                  |
| calibre                    |    webserver    |    webserver    | 8081  |   TCP    |                  |
| calibre                    |      main       |      main       | 8083  |   TCP    |                  |
| cloud9                     |      main       |      main       | 8000  |   TCP    |                  |
| code-server                |      main       |      main       | 8443  |   TCP    |                  |
| collabora-online           |      main       |      main       | 9980  |   TCP    |                  |
| cryptofolio                |      main       |      main       |  10007   |   TCP    |                  |
| davos                      |      main       |      main       | 8080  |   TCP    |                  |
| deconz                     |      main       |      main       |  10008   |   TCP    |                  |
| deconz                     |    websocket    |    websocket    |  10001  |   TCP    |                  |
| deconz                     |       vnc       |       vnc       | 10002  |   TCP    |                  |
| deepstack-cpu              |      main       |      main       | 5000  |   TCP    |                  |
| deepstack-gpu              |      main       |      main       | 5000  |   TCP    |                  |
| deluge                     |      main       |      main       | 8112  |   TCP    |                  |
| deluge                     |     torrent     |       tcp       | 51413 |   TCP    |                  |
| deluge                     |   torrent-udp   |       udp       | 8112  |   UDP    |                  |
| digikam                    |      main       |      main       | 3000  |   TCP    |                  |
| dizquetv                   |      main       |      main       | 8000  |   TCP    |                  |
| doublecommander            |      main       |      main       | 3000  |   TCP    |                  |
| dsmr-reader                |      main       |      main       |  10009   |   TCP    |                  |
| duplicati                  |      main       |      main       | 8200  |   TCP    |                  |
| emby                       |      main       |      main       | 8096  |   TCP    |                  |
| esphome                    |      main       |      main       | 6052  |   TCP    |                  |
| etherpad                   |      main       |      main       | 9001  |   TCP    |                  |
| external-service           |      main       |      main       |  10003  |  HTTPS   |                  |
| filezilla                  |      main       |      main       | 3000  |   TCP    |                  |
| fireflyiii                 |      main       |      main       | 8080  |   TCP    |                  |
| firefox-syncserver         |      main       |      main       | 5000  |   TCP    |                  |
| flaresolverr               |      main       |      main       | 8191  |   TCP    |                  |
| flood                      |      main       |      main       | 3000  |   TCP    |                  |
| focalboard                 |      main       |      main       | 8000  |   TCP    |                  |
| fossil                     |      main       |      main       | 8080  |   TCP    |                  |
| freeradius                 |      main       |      main       | 1812  |   UDP    |                  |
| freeradius                 |   accounting    |   accounting    | 1813  |   UDP    |                  |
| freshrss                   |      main       |      main       |  10010   |   TCP    |                  |
| gaps                       |      main       |      main       | 8484  |   TCP    |                  |
| gitea                      |      main       |      main       | 3000  |   TCP    |                  |
| gitea                      |       ssh       |       ssh       | 2222  |   TCP    |                  |
| golinks                    |      main       |      main       | 8000  |   TCP    |                  |
| gonic                      |      main       |      main       |  10023   |   TCP    |                  |
| gotify                     |      main       |      main       | 8080  |   TCP    |                  |
| grafana                    |      main       |      main       | 3000  |   HTTP   |                  |
| grav                       |      main       |      main       |  10012   |   TCP    |                  |
| grocy                      |      main       |      main       |  10013   |   TCP    |                  |
| handbrake                  |      main       |      main       | 5800  |   TCP    |                  |
| handbrake                  |       vnc       |       vnc       | 5900  |   TCP    |                  |
| haste-server               |      main       |      main       | 7777  |   TCP    |                  |
| headphones                 |      main       |      main       | 8181  |   TCP    |                  |
| healthchecks               |      main       |      main       | 8000  |   TCP    |                  |
| heimdall                   |      main       |      main       |  10014   |   TCP    |                  |
| home-assistant             |      main       |      main       | 8123  |   TCP    |                  |
| hyperion-ng                |      main       |      main       | 8090  |   TCP    |                  |
| hyperion-ng                |   jsonservice   |   jsonservice   | 19444 |   TCP    |                  |
| hyperion-ng                | protobufservice | protobufservice | 19445 |   TCP    |                  |
| hyperion-ng                | boblightservice | boblightservice | 19333 |   TCP    |                  |
| icantbelieveitsnotvaletudo |      main       |      main       | 3000  |   TCP    |                  |
| jacket                     |      main       |      main       | 9117  |   HTTP   |                  |
| jdownloader2               |      main       |      main       | 5800  |   TCP    |                  |
| jdownloader2               |      myjd       |      myjd       | 3129  |   TCP    |                  |
| jdownloader2               |       vnc       |       vnc       | 5900  |   TCP    |                  |
| jellyfin                   |      main       |      main       | 8096  |   TCP    |                  |
| joplin-server              |      main       |      main       | 22300 |   TCP    |                  |
| kanboard                   |      main       |      main       |  10015   |   TCP    |                  |
| kms                        |      main       |      main       | 1688  |   TCP    |                  |
| komga                      |      main       |      main       | 8080  |   TCP    |                  |
| lazylibrarian              |      main       |      main       | 5299  |   TCP    |                  |
| leaf2mqtt                  |      main       |      main       |   -   |    -     | Service disabled |
| librespeed                 |      main       |      main       |  10016   |   TCP    |                  |
| lidarr                     |      main       |      main       | 8686  |   TCP    |                  |
| littlelink                 |      main       |      main       | 3000  |   TCP    |                  |
| logitech-media-server      |      main       |      main       | 7000  |   TCP    |                  |
| logitech-media-server      |       cli       |       cli       | 9090  |   TCP    |                  |
| logitech-media-server      |    playertcp    |  slimprototcp   | 3483  |   TCP    |                  |
| logitech-media-server      |    playerudp    |  slimprotoudp   | 3483  |   UDP    |                  |
| loki                       |      main       |      main       | 3100  |   HTTP   |                  |
| lychee                     |      main       |      main       |  10017   |   TCP    |                  |
| mealie                     |      main       |      main       |  10018   |   TCP    |                  |
| medusa                     |      main       |      main       | 8081  |   TCP    |                  |
| miniflux                   |      main       |      main       | 8080  |   TCP    |                  |
| minio                      |      main       |      main       | 9002  |   TCP    |                  |
| minio                      |     console     |     console     | 9001  |   TCP    |                  |
| minio-console              |      main       |      main       | 9090  |   TCP    |                  |
| mosquitto                  |      main       |      main       | 1883  |   TCP    |                  |
| mstream                    |      main       |      main       | 3000  |   TCP    |                  |
| muximux                    |      main       |      main       |  10019   |   TCP    |                  |
| mylar                      |      main       |      main       | 8090  |   TCP    |                  |
| navidrome                  |      main       |      main       | 4533  |   TCP    |                  |
| nextcloud                  |      main       |      main       |  10020   |   TCP    |                  |
| nextcloud                  |       hpb       |       hpb       | 7867  |   TCP    |                  |
| node-red                   |      main       |      main       | 1880  |   TCP    |                  |
| novnc                      |      main       |      main       | 6080  |   TCP    |                  |
| nullserv                      |      main       |      main       |  10004   |   TCP    |                  |
| nullserv                      |      https      |      https      |  10005  |   TCP    |                  |
| nzbget                     |      main       |      main       | 6789  |   TCP    |                  |
| nzbhydra                   |      main       |      main       | 5076  |   TCP    |                  |
| octoprint                  |      main       |      main       |  10021   |   TCP    |                  |
| odoo                       |      main       |      main       | 8069  |   TCP    |                  |
| odoo                       |      odoo       |     odoo-1      | 8071  |   TCP    |                  |
| odoo                       |      odoo       |     odoo-2      | 8072  |   TCP    |                  |
| ombi                       |      main       |      main       | 3579  |   TCP    |                  |
| onlyoffice-document-server |      main       |      main       |  10021   |   TCP    |                  |
| openkm                     |      main       |      main       | 8080  |   TCP    |                  |
| openldap                   |      main       |      main       |  389  |   TCP    |                  |
| openldap                   |      ldaps      |      ldaps      |  636  |   TCP    |                  |
| organizr                   |      main       |      main       |  10022   |   TCP    |                  |
| oscam                      |      main       |      main       | 8888  |   TCP    |                  |
| overseer                   |      main       |      main       | 5055  |   TCP    |                  |
| owncast                    |      main       |      main       | 8080  |   TCP    |                  |
| owncast                    |      rtmp       |      rtmp       | 1935  |   TCP    |                  |
| owncloud-ocis              |      main       |      main       | 9200  |   TCP    |                  |
| pgadmin                    |      main       |      main       |  10024   |   TCP    |                  |
| photoprism                 |      main       |      main       | 2342  |   TCP    |                  |
| photoshow                  |      main       |      main       |  10025   |   TCP    |                  |
| phpldapadmin               |      main       |      main       |  10026   |   TCP    |                  |
| piaware                    |      main       |      main       | 8080  |   TCP    |                  |
| pihole                     |      main       |      main       | 9089  |   TCP    |                  |
| pihole                     |     dns-tcp     |     dns-tcp     |  53   |   TCP    |                  |
| pihole                     |       dns       |       dns       |  53   |   UDP    |                  |
| pixapop                    |      main       |      main       |  10028   |   TCP    |                  |
| plex                       |      main       |      main       | 32400 |   TCP    |                  |
| podgrab                    |      main       |      main       | 8080  |   TCP    |                  |
| podgrab                    |       tcp       |       tcp       | 51080 |   TCP    |                  |
| pretend-youre-xyzzy        |      main       |      main       | 8080  |   TCP    |                  |
| promcord                   |      main       |      main       |   -   |    -     | Service disabled |
| promcord                   |      main       |     metrics     | 8080  |   TCP    |                  |
| promcord                   |      main       |      main       |   -   |    -     | Service disabled |
| promcord                   |      smtp       |      smtp       |  25   |   TCP    |                  |
| prowlarr                   |      main       |      main       | 9696  |   TCP    |                  |
| pyload                     |      main       |      main       | 8000  |   TCP    |                  |
| qbittorrent                |      main       |      main       | 8080  |   TCP    |                  |
| qbittorrent                |     torrent     |     torrent     | 6881  |   TCP    |                  |
| qbittorrent                |   torrentudp    |   torrentudp    | 6881  |   UDP    |                  |
| radarr                     |      main       |      main       | 7878  |   TCP    |                  |
| readarr                    |      main       |      main       | 8787  |   TCP    |                  |
| recipes                    |      main       |      main       |  10029   |   TCP    |                  |
| reg                        |      main       |      main       | 8080  |   TCP    |                  |
| remmina                    |      main       |      main       | 3000  |   TCP    |                  |
| resilio-sync               |      main       |      main       | 8888  |   TCP    |                  |
| resilio-sync               |     bt-tcp      |     bt-tcp      | 55555 |   TCP    |                  |
| resilio-sync               |     bt-udp      |     bt-udp      | 55555 |   UDP    |                  |
| sabnzbd                    |      main       |      main       | 8080  |   TCP    |                  |
| ser2sock                   |      main       |      main       | 10000 |   TCP    |                  |
| shiori                     |      main       |      main       | 8080  |   TCP    |                  |
| shorturl                   |      main       |      main       | 8000  |   TCP    |                  |
| sickchill                  |      main       |      main       | 8081  |   TCP    |                  |
| sickgear                   |      main       |      main       | 8081  |   TCP    |                  |
| smokeping                  |      main       |      main       |  10030   |   TCP    |                  |
| sonarr                     |      main       |      main       | 8989  |   TCP    |                  |
| speedtest-exporter         |      main       |      main       |   -   |    -     | Service disabled |
| speedtest-exporter         |      main       |     metrics     | 9798  |   TCP    |                  |
| sqlitebrowser              |      main       |      main       | 3000  |   TCP    |                  |
| stash                      |      main       |      main       | 9999  |   TCP    |                  |
| static                     |      main       |      main       | 8000  |   TCP    |                  |
| statping                   |      main       |      main       | 8080  |   TCP    |                  |
| syncthing                  |      main       |      main       | 8384  |   TCP    |                  |
| syncthing                  |    listeners    |       tcp       | 22000 |   TCP    |                  |
| syncthing                  |  listeners-udp  |       udp       | 22000 |   UDP    |                  |
| syncthing                  |    discovery    |    discovery    | 21027 |   UDP    |                  |
| tautulli                   |      main       |      main       | 8181  |   TCP    |                  |
| teamspeak3                 |      main       |      main       | 10011 |   TCP    |                  |
| teamspeak3                 |      voice      |      voice      | 9987  |   UDP    |                  |
| teamspeak3                 |      files      |      files      | 30033 |   TCP    |                  |
| teedy                      |      main       |      main       | 8080  |   TCP    |                  |
| thelounge                  |      main       |      main       | 9000  |   TCP    |                  |
| traccar                    |      main       |      main       | 8082  |   TCP    |                  |
| transmission               |      main       |      main       | 9091  |   TCP    |                  |
| transmission               |     torrent     |     torrent     | 51413 |   TCP    |                  |
| transmission               |   torrentudp    |   torrentudp    | 51413 |   UDP    |                  |
| truecommand                |      main       |      main       |  10031   |   TCP    |                  |
| tt-rss                     |      main       |      main       | 8080  |   TCP    |                  |
| tvheadend                  |      main       |      main       | 9981  |   TCP    |                  |
| tvheadend                  |      htsp       |      htsp       | 9982  |   TCP    |                  |
| twtxt                      |      main       |      main       | 8000  |   TCP    |                  |
| unifi                      |      main       |      main       | 8443  |  HTTPS   |                  |
| unifi                      |      comm       |      comm       | 8080  |   TCP    |                  |
| unifi                      |      stun       |    mstunain     | 3478  |   UDP    |                  |
| unifi                      |    speedtest    |    speedtest    | 6789  |   TCP    |                  |
| unifi                      |   guestportal   |       web       | 8800  |   HTTP   |                  |
| unifi                      |   guestportal   |    websecure    | 8843  |  HTTPS   |                  |
| unpackerr                  |      main       |      main       |   -   |    -     | Service disabled |
| unpoller                   |      main       |      main       |   -   |    -     | Service disabled |
| unpoller                   |      main       |     metrics     | 9130  |   TCP    |                  |
| uptime-kuma                |      main       |      main       | 3001  |   TCP    |                  |
| uptimerobot-prometheus     |      main       |      main       |   -   |    -     | Service disabled |
| uptimerobot-prometheus     |      main       |     metrics     | 9705  |   TCP    |                  |
| valheim                    |      main       |      main       | 9010  |   TCP    |                  |
| valheim                    |   supervisor    |   supervisor    | 9011  |   TCP    |                  |
| valheim                    |     valheim     |    valheim-1    | 2456  |   UDP    |                  |
| valheim                    |     valheim     |    valheim-2    | 2457  |   UDP    |                  |
| valheim                    |     valheim     |    valheim-3    | 2458  |   UDP    |                  |
| vaultwarden                |      main       |      main       | 8080  |   TCP    |                  |
| vaultwarden                |       ws        |       ws        | 3012  |   TCP    |                  |
| whoogle                    |      main       |      main       | 5000  |   TCP    |                  |
| wiki                       |      main       |      main       | 8000  |   TCP    |                  |
| wikijs                     |      main       |      main       | 3000  |   TCP    |                  |
| xteve                      |      main       |      main       | 34400 |   TCP    |                  |
| zigbee2mqtt                |      main       |      main       | 8080  |   TCP    |                  |
| zwavejs2mqtt               |      main       |      main       | 8091  |   TCP    |                  |
| zwavejs2mqtt               |       ws        |       ws        | 3000  |   TCP    |                  |

## Dependency Apps

| App        | Service | Port Name | Port  | Protocol | Note |
| :--------- | :-----: | :-------: | :---: | :------: | :--: |
| mariadb    |  main   |   main    | 3306  |   TCP    |      |
| memcached  |  main   |   main    | 11211 |   TCP    |      |
| postgresql |  main   |   main    | 5432  |   TCP    |      |
| promtail   |  main   |   main    | 3101  |   TCP    |      |
| redis      |  main   |   main    | 6379  |   TCP    |      |

## Incubator Apps

| App              |  Service  | Port Name  | Port  | Protocol | Note |
| :--------------- | :-------: | :--------: | :---: | :------: | :--: |
| omada-controller |   main    |    main    | 8043  |   TCP    |      |
| omada-controller | omada-tcp | omada-tcp1 | 29810 |   TCP    |      |
| omada-controller | omada-tcp | omada-tcp2 | 29811 |   TCP    |      |
| omada-controller | omada-tcp | omada-tcp3 | 29812 |   TCP    |      |
| omada-controller | omada-tcp | omada-tcp4 | 29813 |   TCP    |      |
| omada-controller | omada-udp | omada-udp1 | 29810 |   UDP    |      |
| omada-controller | omada-udp | omada-udp2 | 29811 |   UDP    |      |
| omada-controller | omada-udp | omada-udp3 | 29812 |   UDP    |      |
| omada-controller | omada-udp | omada-udp4 | 29813 |   UDP    |      |
| piwigo           |   main    |    main    |  10027   |   TCP    |      |
| tdarr            |   main    |    main    | 8265  |   TCP    |      |
| tdarr            |   comm    |    comm    | 8266  |   TCP    |      |
| tdarr-node       |   main    |    main    | 8267  |   TCP    |      |

##### Note: TCP and UPD ports that are the same in some Apps, are not by mistake.

##### If you notice a port conflict, please notify us so we can resolve it.
