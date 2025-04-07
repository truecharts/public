---
title: How To
---

## Use of XUID

The Bedrock Dedicated Server requires permissions be defined with XUIDs. There are various tools to look these up online and they are also printed to the log when a player joins.

```bash
[2025-03-01 08:49:08:469 INFO] Player connected: Truecharts, xuid: 2345678909876543
```

To add multiple XUIDs, you can do so by separating each `xuid` by a comma:

```yaml
workload:
  main:
    podSpec:
      containers:
        main:
          env:
            OPS: "XUID,XUID"        # is used to define operators on the server.
            MEMBERS: "XUID,XUID"    # is used to define the members on the server.
            VISITORS: "XUID,XUID"   # is used to define visitors on the server.
```

Example of a 3rd party service [here](https://www.cxkes.me/xbox/xuid) to grab the XUID of the username instead.

:::caution

We have no control over the 3rd service at all. Use it at your own risk.

:::

The `/data/permissions.json` should look something like this:

```json
[
  {
    "permission": "operator",
    "xuid": "XUID"
  },
  {
    "permission": "operator",
    "xuid": "XUID"
  },
  {
    "permission": "operator",
    "xuid": "XUID"
  }
]
```

:::tip

- You can also reach us using [Discord](https://discord.gg/tVsPTHWTtr) for real-time feedback and support
- If you found a bug in our chart, open a Github [issue](https://github.com/truecharts/apps/issues/new/choose) but generally it's advised to contact us on Discord first in most cases.

:::

## Executing server commands

This image comes bundled with a script called send-command that will send a Bedrock command and argument to the Bedrock server console. The output of the command only be visible in the container logs.

Shell into the container and run whatever command you want for example:

```shell
send-command gamerule dofiretick false
```
