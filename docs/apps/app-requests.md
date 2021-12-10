# App Request List

_This list is to track `App Requests` from one place._

 -> New app request should be made by creating a new issue. The issue will be checked if it's viable, linked here and closed. <-

 *Note that the order of the list is not the order that each app will be added! For an app to be added, it would need someone to make a PR for it*

- [ ] Still to be added to TrueCharts
- [x] Already added to TrueCharts

❌ Not likely to be added to TrueCharts (Please add reason)

### Apps

- [ ] Flexget #726
- [ ] Seafile #725
- [ ] dnsmasq #711
- [ ] Deemix #628
- [ ] Trackarr #602
- [ ] Locast2Plex #473
- [ ] n8n #27
- [ ] InfluxDB #5
- [ ] External-Auth-Server #28
- [ ] Borg Backup #782
- [ ] Krusader #794
- [ ] WeblateOrg #817
- [ ] ElectrumX #881
- [ ] Restic #897
- [ ] External-DNS #905
- [ ] Shoko #917
- [ ] kodbox #965
- [ ] Zabbix-Agent
- [ ] Zabbix-Server
- [ ] Filestash #1000
- [ ] UISP #1007
- [ ] Openspeedtest #1018
- [ ] LinkAce #1020
- [ ] Zoneminder #1021
- [ ] OpenHAB #1043
- [ ] Suricata #1063
- [ ] Jitsi Meet #1064
- [ ] Mumble Server #1065
- [ ] KodBox #1079
- [ ] oauth2-proxy
- [ ] Storj Node #1086
- [ ] PiGallery2 #1116
- [ ] LANraragi #1159
- [ ] ArchiSteamFarm #1164
- [ ] Docker Registry #1165
- [ ] Trilium Notes #1261
- [ ] Monero #1228
- [ ] AriaNG #1224
- [ ] FileBrowser #1278
- [ ] Unmanic #1279
- [ ] powerdns
- [ ] Self Service Password  #1482
- [ ] MakeMKV #1469
- [ ] rTorrent #1485
- [ ] MediaElch #1456
- [ ] Tiny Media Manager #1455
- [ ] Mysterium #1436
- [ ] urBackup #1408
- [ ] HyperHDR #1389
- [ ] Channels DVR #1377
- [ ] Gerbera UPnP #1357
- [ ] LibrePhotos #1349
- [ ] Geth #1348
- [ ] Spotify Connect #1319
- [ ] Machinaris #1304
- [ ] Ghost #1282

##### TODO: Requires More-Than-Average effort
- [ ] Taiga #438 (Clusterfuck of containers and already depricated)
- [ ] Netdata #280
- [ ] Appwrite/Parse Framework #278
- [ ] GitLab #227
- [ ] Wordpress #437
- [ ] Steamcmd & 7 Days to die #599
- [ ] Synapse (Matrix Server) #410
- [ ] MovieNight #139 (not a good docker container available)
- [ ] LanCache #138


##### TODO: LSIO containers with known complications

- [ ] codimd ( Viable, but not via LSIO)
- [ ] diskover ( Requires: elasticsearch )
- [ ] jenkins-builder ( Internal LSIO only, we should learn from this )
- [ ] musicbrainz ( Use metabrainz/musicbrainz-docker instead )
- [ ] nano ( Setup rather complex )
- [ ] netbox ( Needs some more viability verification )
- [ ] nginx ( Should be called "nginx-webserver" to prevent ingress-provider confusion )
- [ ] openssh-server ( Maybe call this "openssh-sandbox?" )
- [ ] rutorrent ( needs another container source and has config complications )

- [ ] snapdrop ( Not sure about networking requirements/design )
- [ ] serviio ( very niche, no good containers )


##### TODO: Require custom care to handle their configuration

- [ ] adguard-home ( example helm-chart available from [ k8s-at-home ](https://github.com/k8s-at-home/charts) )
- [ ] blocky ( example helm-chart available from [ k8s-at-home ](https://github.com/k8s-at-home/charts) )
- [ ] comcast ( example helm-chart available from [ k8s-at-home ](https://github.com/k8s-at-home/charts) )
- [ ] Frigate #871 ( example helm-chart available from [ k8s-at-home ](https://github.com/k8s-at-home/charts) )
- [ ] games-on-whales ( example helm-chart available from [ k8s-at-home ](https://github.com/k8s-at-home/charts) )
- [ ] gollum ( example helm-chart available from [ k8s-at-home ](https://github.com/k8s-at-home/charts) )
- [ ] homer ( example helm-chart available from [ k8s-at-home ](https://github.com/k8s-at-home/charts) )
- [ ] magic-mirror ( example helm-chart available from [ k8s-at-home ](https://github.com/k8s-at-home/charts) )
- [ ] modem-stats ( example helm-chart available from [ k8s-at-home ](https://github.com/k8s-at-home/charts) )
- [ ] neolink ( example helm-chart available from [ k8s-at-home ](https://github.com/k8s-at-home/charts) )
- [ ] network-ups-tools ( example helm-chart available from [ k8s-at-home ](https://github.com/k8s-at-home/charts) )
- [ ] onedrive ( example helm-chart available from [ k8s-at-home ](https://github.com/k8s-at-home/charts) )
- [ ] rtorrent-flood ( example helm-chart available from [ k8s-at-home ](https://github.com/k8s-at-home/charts) )
- [ ] searx ( example helm-chart available from [ k8s-at-home ](https://github.com/k8s-at-home/charts) )
- [ ] sharry ( example helm-chart available from [ k8s-at-home ](https://github.com/k8s-at-home/charts) )
- [ ] olivetin ( example helm-chart available from [ nicholaswilde ](https://github.com/nicholaswilde/helm-charts) )
- [ ] writefreely ( example helm-chart available from [ nicholaswilde ](https://github.com/nicholaswilde/helm-charts) )
- [ ] baikal ( example helm-chart available from [ k8s-at-home ](https://github.com/k8s-at-home/charts) )
- [ ] formalms ( example helm-chart available from [ nicholaswilde ](https://github.com/nicholaswilde/helm-charts) )
- [ ] projectsend ( example helm-chart available from [ nicholaswilde ](https://github.com/nicholaswilde/helm-charts) )
- [ ] chyrp-lite
- [ ] limnoria

##### TODO: Requires Postgresql customisation
- [ ] Keycloack #1106

##### TODO: Requires Postgresql+redis customisation

- [ ] shlink ( example helm-chart available from [ k8s-at-home ](https://github.com/k8s-at-home/charts) )
- [ ] wallabag ( example helm-chart available from [ k8s-at-home ](https://github.com/k8s-at-home/charts) )
- [ ] papermerge ( example helm-chart available from [ nicholaswilde ](https://github.com/nicholaswilde/helm-charts) )

##### TODO: Requires MariaDB to be added first
- [ ] FreePBX #1111


##### TODO: Requires Prometheus to be added first

- [ ] alertmanager-bot ( example helm-chart available from [ k8s-at-home ](https://github.com/k8s-at-home/charts) )
- [ ] prometheus-nut-exporter ( example helm-chart available from [ k8s-at-home ](https://github.com/k8s-at-home/charts) )
- [ ] traefik-forward-auth ( example helm-chart available from [ k8s-at-home ](https://github.com/k8s-at-home/charts) )
- [ ] uptimerobot ( example helm-chart available from [ k8s-at-home ](https://github.com/k8s-at-home/charts) )
- [ ] vikunja ( example helm-chart available from [ k8s-at-home ](https://github.com/k8s-at-home/charts) )
- [ ] youtubedl-material ( example helm-chart available from [ k8s-at-home ](https://github.com/k8s-at-home/charts) )

##### TODO: Requires MongoDB to be added first

- [ ] overleaf ( example helm-chart available from [ k8s-at-home ](https://github.com/k8s-at-home/charts) )
- [ ] WeKan #1225

##### TODO: Other Complications

_These Apps have specific requirements or need specific customisation and care_

- [ ] foundryvtt ( example helm-chart available from [ k8s-at-home ](https://github.com/k8s-at-home/charts) )
- [ ] homebridge ( example helm-chart available from [ k8s-at-home ](https://github.com/k8s-at-home/charts) )
- [ ] jetbrains-projector ( example helm-chart available from [ k8s-at-home ](https://github.com/k8s-at-home/charts) )
- [ ] paperless ( example helm-chart available from [ k8s-at-home ](https://github.com/k8s-at-home/charts) )
- [ ] boinc-client ( example helm-chart available from [ nicholaswilde ](https://github.com/nicholaswilde/helm-charts) )
- [ ] hedgedoc ( example helm-chart available from [ nicholaswilde ](https://github.com/nicholaswilde/helm-charts) )
- [ ] cryptpad ( example helm-chart available from [ nicholaswilde ](https://github.com/nicholaswilde/helm-charts) )
- [ ] netbootxyz

### Apps that not have a specific candidate yet.

- [ ] Mail Server #274
- [ ] Log Manager #509
- [ ] FTP Client #615
- [ ] Web Server #273
- [ ] Minecraft Server #314
- [ ] Printer/Scanner server (CUPS for example) #1024
- [ ] Private torrent tracker (OpenTracker for example) #1025


### Not Likely to be added

:x: pod-gateway (while a one-vpn-app app sounds nice, it would be extremely complicated to give it an acceptable user experience)

:x: dnsmadeeasy-webhook (We do not support the underlaying cert-manager system as we use TrueNAS SCALE Certs)

:x: intel-gpu-plugin (Already Integrated in TrueNAS SCALE)

:x: multus (We use the CNI supplied by TrueNAS SCALE)

:x: samba (Already Integrated into TrueNAS SCALE)

:x: smarter-device-manager (preferably iX finds a way of implementing something like this)

:x: zalando-postgres-cluster (We need to deploy the actual operator as an app instead)

:x: Nginx Proxy Manager #1019 (Doesn't fit very well in the kubernetes ecosystem, might cause confusion and or support issues)

:x: diun ( The general feature is already integrated into SCALE)

:x: pterodactyl (Not natively compatible with k8s, would most likely go totally haywire when clustering launches)

:x: booksonic (is *depricated* by upstream )

:x: installer (an installer-ecosystem, within an installer ecosystem (scale) seems a bit weird)

:x: static (Upstream project disapeared)

:x: todo (Upstream project disapeared)

:x: wg-easy #1414 ( VPN servers inside the k8s subnet is not great)

:x: Umbrel #404 (not going to be added, not a docker container)


### LSIO containers not viable for Apps

:x: adguardhome-sync ( Addon to Adguard-home )

:x: apprise-api ( Addon to Apprise  )

:x: booksonic ( Replaced by Booksonic-Air )

:x: cardigann ( Deprecated ages ago )

:x: codiad ( Deprecated ages ago )

:x: cops ( Companion to calibre )

:x: daapd ( Might require mdns )

:x: docker-compose ( Not a fit for SCALE )

:x: ffmpeg ( CLI Only )

:x: gazee ( Depricated: use codex instead )

:x: hydra ( Use Hydra2 instead )

:x: hydra2 ( Replaced by NZB-Hydra2 )

:x: kanzi ( Requires complicated post-install setup )

:x: ldap-auth ( Deprecated years ago )

:x: letsencrypt ( We integrate certs with SCALE )

:x: libresonic ( Project is gone, use airsonic instead )

:x: mods ( Not something we currently support )

:x: openvpn-as ( Should be integrated in either SCALE or a router )

:x: pydio ( use pydio/cells instead )

:x: raneto ( Convoluted setup )

:x: rdesktop ( Not suited for SCALE )

:x: swag ( Reverse proxying should be done using ingress and certs using SCALE )

:x: taisun ( Most likely does not work with kubernetes )

:x: webtop ( Going to cause issues when running in k8s )

:x: wireguard ( A VPN server inside the k8s subnet is not the best idea, leave this to SCALE host or a router )

:x: yq ( yq is nice and all, but not interesting for a SCALE App )

:x: arch ( basecontainers are not applications )

:x: fedora ( basecontainers are not applications )

:x: ffmpeg ( basecontainers are not applications )

:x: guacgui ( basecontainers are not applications )

:x: gui ( basecontainers are not applications )

:x: java ( basecontainers are not applications )

:x: mono ( basecontainers are not applications )

:x: nginx ( basecontainers are not applications )

:x: python ( basecontainers are not applications )

:x: rdesktop ( basecontainers are not applications )

:x: rdesktop-web ( basecontainers are not applications )

:x: pixapop ( moved to lsio )

:x: polipo ( upstream depricated )

:x: shout-irc ( succeeded by THELOUNGE  )

:x: sickbeard ( upstream depricated )

:x: Phabricator #122


### Completed App Requests

- [x] JDownloader2 #613
- [x] Gitea #291
- [x] OnlyOffice Document Server #192
- [x] Pihole #12
- [x] Authelia #1
- [x] Photo Manager #293
- [x] airsonic
- [x] appdaemon
- [x] bazarr
- [x] calibre
- [x] calibre-web
- [x] deconz
- [x] deluge
- [x] dizquetv
- [x] duplicati
- [x] emby
- [x] esphome
- [x] flaresolverr
- [x] flood
- [x] focalboard
- [x] freshrss
- [x] gaps
- [x] gonic
- [x] grocy
- [x] haste-server
- [x] healthchecks
- [x] heimdall
- [x] home-assistant
- [x] hyperion-ng
- [x] jackett
- [x] jellyfin
- [x] komga
- [x] lazylibrarian
- [x] lidarr
- [x] lychee
- [x] mealie
- [x] mosquitto
- [x] mylar
- [x] navidrome
- [x] node-red
- [x] nullserv
- [x] nzbget
- [x] nzbhydra2
- [x] octoprint
- [x] omada-controller
- [x] ombi
- [x] organizr
- [x] overseerr
- [x] owncast
- [x] owncloud-ocis
- [x] photoprism
- [x] piaware
- [x] plex
- [x] pretend-youre-xyzzy
- [x] protonmail-bridge
- [x] prowlarr
- [x] pyload
- [x] qbittorrent
- [x] radarr
- [x] readarr
- [x] reg
- [x] resilio-sync
- [x] sabnzbd
- [x] ser2sock
- [x] sonarr
- [x] stash
- [x] syncthing
- [x] tautulli
- [x] thelounge
- [x] transmission
- [x] truecommand
- [x] tvheadend
- [x] unifi
- [x] unpackerr
- [x] vaultwarden
- [x] xteve
- [x] zwavejs2mqtt
- [x] haste
- [x] postgres
- [x] syncthing
- [x] transmission
- [x] apache-musicindex
- [x] aria2
- [x] booksonic-air
- [x] cryptofolio
- [x] icantbelieveitsnotvaletudo
- [x] minio-console
- [x] valheim
- [x] whoogle
- [x] amcrest2mqtt
- [x] audacity
- [x] beets
- [x] cloud9
- [x] code-server
- [x] davos
- [x] digikam
- [x] doublecommander
- [x] filezilla
- [x] fossil
- [x] golinks
- [x] grav
- [x] headphones
- [x] leaf2mqtt
- [x] medusa
- [x] mstream
- [x] muximux
- [x] notes
- [x] novnc
- [x] photoshow
- [x] piwigo
- [x] pixapop
- [x] remmina
- [x] shorturl
- [x] sickchill
- [x] sickgear
- [x] smokeping
- [x] sqlitebrowser
- [x] twtxt
- [x] wiki
- [x] zigbee2mqtt
- [x] podgrab
- [x] Uptime Kuma #1097
- [x] tdarr / tdarr-node
- [x] dsmr-reader
- [x] joplin-server
- [x] kanboard
- [x] librespeed
- [x] miniflux
- [x] openkm
- [x] statping
- [x] teedy
- [x] teslamate
- [x] traccar
- [x] tt-rss
- [x] wikijs
- [x] recipes
- [x] babybuddy
- [x] etherpad
- [x] odoo
- [x] shiori
- [x] firefox-syncserver
- [x] gotify
- [x] mariadb ( example helm-chart available from [ nicholaswilde ](https://github.com/nicholaswilde/helm-charts) )
- [x] promcord ( example helm-chart available from [ k8s-at-home ](https://github.com/k8s-at-home/charts) )
- [x] speedtest-exporter ( example helm-chart available from [ k8s-at-home ](https://github.com/k8s-at-home/charts) )
- [x] unifi-poller ( example helm-chart available from [ k8s-at-home ](https://github.com/k8s-at-home/charts) )
- [x] uptimerobot-prometheus ( example helm-chart available from [ k8s-at-home ](https://github.com/k8s-at-home/charts) )
- [x] Logitech Media Server #1062
- [x] Grafana #4
- [x] Prometheus #275
- [x] anonaddy ( example helm-chart available from [ k8s-at-home ](https://github.com/k8s-at-home/charts) )
- [x] bookstack ( example helm-chart available from [ k8s-at-home ](https://github.com/k8s-at-home/charts) )
- [x] icinga2 ( example helm-chart available from [ k8s-at-home ](https://github.com/k8s-at-home/charts) )
- [x] monica ( example helm-chart available from [ k8s-at-home ](https://github.com/k8s-at-home/charts) )
- [x] openemr ( example helm-chart available from [ k8s-at-home ](https://github.com/k8s-at-home/charts) )
- [x] xbackbone ( example helm-chart available from [ k8s-at-home ](https://github.com/k8s-at-home/charts) )
- [x] clarkson ( example helm-chart available from [ nicholaswilde ](https://github.com/nicholaswilde/helm-charts) )
- [x] friendica ( example helm-chart available from [ nicholaswilde ](https://github.com/nicholaswilde/helm-charts) )
- [x] snipe-it ( example helm-chart available from [ nicholaswilde ](https://github.com/nicholaswilde/helm-charts) )
- [x] leantime ( example helm-chart available from [ nicholaswilde ](https://github.com/nicholaswilde/helm-charts) )
- [x] blog ( example helm-chart available from [ nicholaswilde ](https://github.com/nicholaswilde/helm-charts) )
- [x] bookstack ( example helm-chart available from [ nicholaswilde ](https://github.com/nicholaswilde/helm-charts) )
- [x] pixapop
- [x] grav
- [x] boinc
- [x] chevereto
- [x] couchpotato
- [x] darktable
- [x] ddclient
- [x] dillinger
- [x] dokuwiki
- [x] domoticz
- [x] duckdns
- [x] embystat
- [x] emulatorjs
- [x] endlessh
- [x] firefox
- [x] fleet
- [x] foldingathome
- [x] guacd
- [x] habridge
- [x] hedgedoc
- [x] htpcmanager
- [x] ipfs
- [x] kodi-headless
- [x] libreoffice
- [x] minetest
- [x] minisatip
- [x] mysql-workbench
- [x] nano-wallet
- [x] ngircd
- [x] nntp2nntp
- [x] openvscode-server
- [x] paperless-ng
- [x] papermerge
- [x] pidgin
- [x] projectsend
- [x] pwndrop
- [x] pydio-cells
- [x] pylon
- [x] quassel-core
- [x] quassel-web
- [x] requestrr
- [x] rsnapshot
- [x] synclounge
- [x] syslog-ng
- [x] ubooquity
- [x] webgrabplus
- [x] wireshark
- [x] znc #1343
- [x] Quassel IRC #1070
- [x] DokuWiki #1115
- [x] ApacheGuacamole #103
- [x] Requestrr #237
- [x] DMS (Document Manage System) #810
- [x] scrutiny ( Needs customised solution for direct disk access )
