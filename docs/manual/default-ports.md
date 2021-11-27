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

| App                        |     Service     |    Port Name    | Port  | Protocol | Note |
| :------------------------- | :-------------: | :-------------: | :---: | :------: | :--: |
| airsonic                   |      main       |      main       | 4040  |   TCP    |      |
| apache-musicindex          |      main       |      main       |  80   |   TCP    |      |
| appdaemon                  |      main       |      main       | 5050  |   TCP    |      |
| appdaemon                  |       tcp       |       tcp       | 51050 |   TCP    |      |
| aria2                      |      main       |      main       | 6800  |   TCP    |      |
| aria2                      |     listen      |     listen      | 6888  |   TCP    |      |
| audacity                   |      main       |      main       | 3000  |   TCP    |      |
| authelia                   |      main       |      main       | 9091  |   TCP    |      |
| babybuddy                  |      main       |      main       | 8000  |   TCP    |      |
| bazarr                     |      main       |      main       | 6767  |   TCP    |      |
| beets                      |      main       |      main       | 8337  |   TCP    |      |
| booksonic-air              |      main       |      main       | 4040  |   TCP    |      |
| calibre                    |      main       |      main       | 8080  |   TCP    |      |
| calibre                    |    webserver    |    webserver    | 8081  |   TCP    |      |
| calibre                    |      main       |      main       | 8083  |   TCP    |      |
| cloud9                     |      main       |      main       | 8000  |   TCP    |      |
| code-server                |      main       |      main       | 8443  |   TCP    |      |
| collabora-online           |      main       |      main       | 9980  |   TCP    |      |
| cryptofolio                |      main       |      main       |  80   |   TCP    |      |
| davos                      |      main       |      main       | 8080  |   TCP    |      |
| deconz                     |      main       |      main       |  80   |   TCP    |      |
| deconz                     |    websocket    |    websocket    |  443  |   TCP    |      |
| deconz                     |       vnc       |       vnc       | 5900  |   TCP    |      |
| deepstack-cpu              |      main       |      main       | 5000  |   TCP    |      |
| deepstack-gpu              |      main       |      main       | 5000  |   TCP    |      |
| deluge                     |      main       |      main       | 8112  |   TCP    |      |
| deluge                     |     torrent     |       tcp       | 51413 |   TCP    |      |
| deluge                     |   torrent-udp   |       udp       | 8112  |   UDP    |      |
| digikam                    |      main       |      main       | 3000  |   TCP    |      |
| dizquetv                   |      main       |      main       | 8000  |   TCP    |      |
| doublecommander            |      main       |      main       | 3000  |   TCP    |      |
| dsmr-reader                |      main       |      main       |  80   |   TCP    |      |
| duplicati                  |      main       |      main       | 8200  |   TCP    |      |
| emby                       |      main       |      main       | 8096  |   TCP    |      |
| esphome                    |      main       |      main       | 6052  |   TCP    |      |
| etherpad                   |      main       |      main       | 9001  |   TCP    |      |
| external-service           |      main       |      main       |  443  |  HTTPS   |      |
| filezilla                  |      main       |      main       | 3000  |   TCP    |      |
| fireflyiii                 |      main       |      main       | 8080  |   TCP    |      |
| firefox-syncserver         |      main       |      main       | 5000  |   TCP    |      |
| flaresolverr               |      main       |      main       | 8191  |   TCP    |      |
| flood                      |      main       |      main       | 3000  |   TCP    |      |
| focalboard                 |      main       |      main       | 8000  |   TCP    |      |
| fossil                     |      main       |      main       | 8080  |   TCP    |      |
| freeradius                 |      main       |      main       | 1812  |   UDP    |      |
| freeradius                 |   accounting    |   accounting    | 1813  |   UDP    |      |
| freshrss                   |      main       |      main       |  80   |   TCP    |      |
| gaps                       |      main       |      main       | 8484  |   TCP    |      |
| gitea                      |      main       |      main       | 3000  |   TCP    |      |
| gitea                      |       ssh       |       ssh       | 2222  |   TCP    |      |
| golinks                    |      main       |      main       | 8000  |   TCP    |      |
| gonic                      |      main       |      main       |  80   |   TCP    |      |
| gotify                     |      main       |      main       | 8080  |   TCP    |      |
| grafana                    |      main       |      main       | 3000  |   HTTP   |      |
| grav                       |      main       |      main       |  80   |   TCP    |      |
| grocy                      |      main       |      main       |  80   |   TCP    |      |
| handbrake                  |      main       |      main       | 5800  |   TCP    |      |
| handbrake                  |       vnc       |       vnc       | 5900  |   TCP    |      |
| haste-server               |      main       |      main       | 7777  |   TCP    |      |
| headphones                 |      main       |      main       | 8181  |   TCP    |      |
| healthchecks               |      main       |      main       | 8000  |   TCP    |      |
| heimdall                   |      main       |      main       |  80   |   TCP    |      |
| home-assistant             |      main       |      main       | 8123  |   TCP    |      |
| hyperion-ng                |      main       |      main       | 8090  |   TCP    |      |
| hyperion-ng                |   jsonservice   |   jsonservice   | 19444 |   TCP    |      |
| hyperion-ng                | protobufservice | protobufservice | 19445 |   TCP    |      |
| hyperion-ng                | boblightservice | boblightservice | 19333 |   TCP    |      |
| icantbelieveitsnotvaletudo |      main       |      main       | 3000  |   TCP    |      |
| jacket                     |      main       |      main       | 9117  |   HTTP   |      |
| jdownloader2               |      main       |      main       | 5800  |   TCP    |      |
| jdownloader2               |      myjd       |      myjd       | 3129  |   TCP    |      |
| jdownloader2               |       vnc       |       vnc       | 5900  |   TCP    |      |
| jellyfin                   |      main       |      main       | 8096  |   TCP    |      |
| joplin-server              |      main       |      main       | 22300 |   TCP    |      |
| kanboard                   |      main       |      main       |  80   |   TCP    |      |
| kms                        |      main       |      main       | 1688  |   TCP    |      |
| komga                      |      main       |      main       | 8080  |   TCP    |      |
| lazylibrarian              |      main       |      main       | 5299  |   TCP    |      |
| librespeed                 |      main       |      main       |  80   |   TCP    |      |
| lidarr                     |      main       |      main       | 8686  |   TCP    |      |
| littlelink                 |      main       |      main       | 3000  |   TCP    |      |
| logitech-media-server      |      main       |      main       | 7000  |   TCP    |      |
| logitech-media-server      |       cli       |       cli       | 9090  |   TCP    |      |
| logitech-media-server      |    playertcp    |  slimprototcp   | 3483  |   TCP    |      |
| logitech-media-server      |    playerudp    |  slimprotoudp   | 3483  |   UDP    |      |
| loki                       |      main       |      main       | 3100  |   HTTP   |      |
| lychee                     |      main       |      main       |  80   |   TCP    |      |

## Incubator Apps

## Dependency Apps

##### Note: TCP and UPD ports that are the same in some Apps, are not by mistake.
##### If you notice a port conflict, please notify us so we can resolve it.
