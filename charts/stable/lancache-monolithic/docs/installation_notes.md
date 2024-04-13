---
title: Installation Notes
---

Clients like Steam, Battle.net, etc sends requests to port 80/443.
In case you don't want to use traefik in front of this app, you need to change the ports.

- `Service` -> `Main` -> `Port`: **80**
- `Service` -> `https` -> `Port`: **443**

:::danger

Doing this will break Traefik and we do NOT recommend it.
Also, you have to make sure that you do NOT have any other service on these ports.
Like TrueNAS Scale WebUI.

:::

## Lancache-dns

- It's highly recommended to also install the [lancache-dns](/charts/stable/lancache-dns/) chart along side the monolithic chart.

## Lancache-Prefill

How to use lancache-prefill sidecar

:::info

Shell into the main pod, not the _prefill_ pod.

:::

### BattleNet

```shell
cd /data/prefill/BattleNetPrefill/ && ./BattleNetPrefill -h
```

cron param options [list](https://tpill90.github.io/battlenet-lancache-prefill/detailed-command-usage/Prefill/#options).

### Epic

```shell
cd /data/prefill/EpicPrefill/ && ./EpicPrefill -h
```

cron param options [list](https://tpill90.github.io/epic-lancache-prefill/Detailed-Command-Usage/#prefill).

### Steam

```shell
cd /data/prefill/SteamPrefill/ && ./SteamPrefill -h
```

cron param options [list](https://tpill90.github.io/steam-lancache-prefill/detailed-command-usage/Prefill/#options).
