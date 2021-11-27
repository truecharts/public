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
| amcrest2mqtt               |      main       |      main       |   -   |   TCP    | Service disabled |
| airsonic                   |      main       |      main       | 4040  |   TCP    |                  |
| apache-musicindex          |      main       |      main       |  80   |   TCP    |                  |
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
| cryptofolio                |      main       |      main       |  80   |   TCP    |                  |
| davos                      |      main       |      main       | 8080  |   TCP    |                  |
| deconz                     |      main       |      main       |  80   |   TCP    |                  |
| deconz                     |    websocket    |    websocket    |  443  |   TCP    |                  |
| deconz                     |       vnc       |       vnc       | 5900  |   TCP    |                  |
| deepstack-cpu              |      main       |      main       | 5000  |   TCP    |                  |
| deepstack-gpu              |      main       |      main       | 5000  |   TCP    |                  |
| deluge                     |      main       |      main       | 8112  |   TCP    |                  |
| deluge                     |     torrent     |       tcp       | 51413 |   TCP    |                  |
| deluge                     |   torrent-udp   |       udp       | 8112  |   UDP    |                  |
| digikam                    |      main       |      main       | 3000  |   TCP    |                  |
| dizquetv                   |      main       |      main       | 8000  |   TCP    |                  |
| doublecommander            |      main       |      main       | 3000  |   TCP    |                  |
| dsmr-reader                |      main       |      main       |  80   |   TCP    |                  |
| duplicati                  |      main       |      main       | 8200  |   TCP    |                  |
| emby                       |      main       |      main       | 8096  |   TCP    |                  |
| esphome                    |      main       |      main       | 6052  |   TCP    |                  |
| etherpad                   |      main       |      main       | 9001  |   TCP    |                  |
| external-service           |      main       |      main       |  443  |  HTTPS   |                  |
| filezilla                  |      main       |      main       | 3000  |   TCP    |                  |
| fireflyiii                 |      main       |      main       | 8080  |   TCP    |                  |
| firefox-syncserver         |      main       |      main       | 5000  |   TCP    |                  |
| flaresolverr               |      main       |      main       | 8191  |   TCP    |                  |
| flood                      |      main       |      main       | 3000  |   TCP    |                  |
| focalboard                 |      main       |      main       | 8000  |   TCP    |                  |
| fossil                     |      main       |      main       | 8080  |   TCP    |                  |
| freeradius                 |      main       |      main       | 1812  |   UDP    |                  |
| freeradius                 |   accounting    |   accounting    | 1813  |   UDP    |                  |
| freshrss                   |      main       |      main       |  80   |   TCP    |                  |
| gaps                       |      main       |      main       | 8484  |   TCP    |                  |
| gitea                      |      main       |      main       | 3000  |   TCP    |                  |
| gitea                      |       ssh       |       ssh       | 2222  |   TCP    |                  |
| golinks                    |      main       |      main       | 8000  |   TCP    |                  |
| gonic                      |      main       |      main       |  80   |   TCP    |                  |
| gotify                     |      main       |      main       | 8080  |   TCP    |                  |
| grafana                    |      main       |      main       | 3000  |   HTTP   |                  |
| grav                       |      main       |      main       |  80   |   TCP    |                  |
| grocy                      |      main       |      main       |  80   |   TCP    |                  |
| handbrake                  |      main       |      main       | 5800  |   TCP    |                  |
| handbrake                  |       vnc       |       vnc       | 5900  |   TCP    |                  |
| haste-server               |      main       |      main       | 7777  |   TCP    |                  |
| headphones                 |      main       |      main       | 8181  |   TCP    |                  |
| healthchecks               |      main       |      main       | 8000  |   TCP    |                  |
| heimdall                   |      main       |      main       |  80   |   TCP    |                  |
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
| kanboard                   |      main       |      main       |  80   |   TCP    |                  |
| kms                        |      main       |      main       | 1688  |   TCP    |                  |
| komga                      |      main       |      main       | 8080  |   TCP    |                  |
| lazylibrarian              |      main       |      main       | 5299  |   TCP    |                  |
| leaf2mqtt                  |      main       |      main       |   -   |   TCP    | Service disabled |
| librespeed                 |      main       |      main       |  80   |   TCP    |                  |
| lidarr                     |      main       |      main       | 8686  |   TCP    |                  |
| littlelink                 |      main       |      main       | 3000  |   TCP    |                  |
| logitech-media-server      |      main       |      main       | 7000  |   TCP    |                  |
| logitech-media-server      |       cli       |       cli       | 9090  |   TCP    |                  |
| logitech-media-server      |    playertcp    |  slimprototcp   | 3483  |   TCP    |                  |
| logitech-media-server      |    playerudp    |  slimprotoudp   | 3483  |   UDP    |                  |
| loki                       |      main       |      main       | 3100  |   HTTP   |                  |
| lychee                     |      main       |      main       |  80   |   TCP    |                  |
| mealie                     |      main       |      main       |  80   |   TCP    |                  |
| medusa                     |      main       |      main       | 8081  |   TCP    |                  |
| miniflux                   |      main       |      main       | 8080  |   TCP    |                  |
| minio                      |      main       |      main       | 9002  |   TCP    |                  |
| minio                      |     console     |     console     | 9001  |   TCP    |                  |
| minio-console              |      main       |      main       | 9090  |   TCP    |                  |
| mosquitto                  |      main       |      main       | 1883  |   TCP    |                  |
| mstream                    |      main       |      main       | 3000  |   TCP    |                  |
| muximux                    |      main       |      main       |  80   |   TCP    |                  |
| mylar                      |      main       |      main       | 8090  |   TCP    |                  |
| navidrome                  |      main       |      main       | 4533  |   TCP    |                  |
| nextcloud                  |      main       |      main       |  80   |   TCP    |                  |
| nextcloud                  |       hpb       |       hpb       | 7867  |   TCP    |                  |
| node-red                   |      main       |      main       | 1880  |   TCP    |                  |
| novnc                      |      main       |      main       | 6080  |   TCP    |                  |
| novnc                      |      main       |      main       |  80   |   TCP    |                  |
| novnc                      |      https      |      https      |  443  |   TCP    |                  |
| nzbget                     |      main       |      main       | 6789  |   TCP    |                  |
| nzbhydra                   |      main       |      main       | 5076  |   TCP    |                  |
| octoprint                  |      main       |      main       |  80   |   TCP    |                  |
| odoo                       |      main       |      main       | 8069  |   TCP    |                  |
| odoo                       |      odoo       |     odoo-1      | 8071  |   TCP    |                  |
| odoo                       |      odoo       |     odoo-2      | 8072  |   TCP    |                  |
| ombi                       |      main       |      main       | 3579  |   TCP    |                  |
| onlyoffice-document-server |      main       |      main       |  80   |   TCP    |                  |
| openkm                     |      main       |      main       | 8080  |   TCP    |                  |
| openldap                   |      main       |      main       |  389  |   TCP    |                  |
| openldap                   |      ldaps      |      ldaps      |  636  |   TCP    |                  |
| organizr                   |      main       |      main       |  80   |   TCP    |                  |
| oscam                      |      main       |      main       | 8888  |   TCP    |                  |
| overseer                   |      main       |      main       | 5055  |   TCP    |                  |
| owncast                    |      main       |      main       | 8080  |   TCP    |                  |
| owncast                    |      rtmp       |      rtmp       | 1935  |   TCP    |                  |
| owncloud-ocis              |      main       |      main       | 9200  |   TCP    |                  |
| pgadmin                    |      main       |      main       |  80   |   TCP    |                  |
| photoprism                 |      main       |      main       | 2342  |   TCP    |                  |
| photoshow                  |      main       |      main       |  80   |   TCP    |                  |
| phpldapadmin               |      main       |      main       |  80   |   TCP    |                  |
| piaware                    |      main       |      main       | 8080  |   TCP    |                  |
| pihole                     |      main       |      main       | 9089  |   TCP    |                  |
| pihole                     |     dns-tcp     |     dns-tcp     |  53   |   TCP    |                  |
| pihole                     |       dns       |       dns       |  53   |   UDP    |                  |
| pixapop                    |      main       |      main       |  80   |   TCP    |                  |
| plex                       |      main       |      main       | 32400 |   TCP    |                  |
| podgrab                    |      main       |      main       | 8080  |   TCP    |                  |
| podgrab                    |       tcp       |       tcp       | 51080 |   TCP    |                  |
| pretend-youre-xyzzy        |      main       |      main       | 8080  |   TCP    |                  |
| promcord                   |      main       |      main       |   -   |   TCP    | Service disabled |
| promcord                   |      main       |     metrics     | 8080  |   TCP    |                  |
| promcord                   |      main       |      main       |   -   |   TCP    | Service disabled |
| promcord                   |      smtp       |      smtp       |  25   |   TCP    |                  |
| prowlarr                   |      main       |      main       | 9696  |   TCP    |                  |
| pyload                     |      main       |      main       | 8000  |   TCP    |                  |

## Incubator Apps

## Dependency Apps

##### Note: TCP and UPD ports that are the same in some Apps, are not by mistake.

##### If you notice a port conflict, please notify us so we can resolve it.
