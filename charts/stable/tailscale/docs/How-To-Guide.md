---
title: How-To
---

This is a quick how-to or setup-guide to use Tailscale on Talos.

:::caution

This guide doesn't cover using Tailscale with individual applications. While there are methods to use Tailscale (as an app) with other individual apps this requires `Host-Networking` and beyond the scope of this guide and may not work for all apps. The suggested use in the future will be the Tailscale Add-On

:::

## Requirements

- Tailscale Account (Free accounts available at [Tailscale's Official website](https://www.tailscale.com))
- Tailscale Truecharts Chart
- Tailscale DNS setup for Talos Cluster Domain


Generate a Tailscale Auth Key for your setup, easy to generate on the page below

![tailscale-auth-key](./img/How-To-Image-1.png)

## Tailscale Chart Setup

### Application name

Ideally use `tailscale` but you can use any name here.

### App Configuration

- `Auth Key`: The key you received from tailscale in prerequisites above
- `Userspace`: Now enabled by default, as it is _required_ when using local routes and as an exit node (see below). Userspace restricts clients to only accessing the GUI and Samba. More info in the [Tailscale Userspace Guide](https://tailscale.com/kb/1112/userspace-networking/).
- `Accept DNS`: Enabling it will pass your Global Nameservers from Tailscale to your local install.
- `Routes`: Change to the routes you wish Tailscale to have access to on the devices it's connected, ie your LAN.
- `Extra Args` passes arguments/flags to the `tailscale up` command.
- `Hostname` You can specify a specific hostname for use inside Tailscale. This is recommended as otherwise it will utilise the tailscale kubernetes podname as the machine name in the console, over time when the chart is upgraded it will add additional machines into Tailscale portal. (Passes `--hostname HOSTNAME` to `Extra args`)
- `Advertise as exit node` This is used to pass traffic through tailscale like a private VPN. (Passes `--advertise-exit-node` to `Extra args`)

For more Extra Args and their usage please check the [Tailscale Knowledge Base](https://tailscale.com/kb/1080/cli/#up)
since we consider these advanced features and these may/not be compatible with everyone's exact setup.

## Namespace Privileges Required for Talos Cluster

In your namespace.yaml file add
```labels:
    pod-security.kubernetes.io/enforce: privileged
```

to allow this Chart to run with privileged permissions.

### Tailscale DNS Setup

In Tailscale Portal on DNS, Namespace section add a new custom nameserver using  the Blocky IP address and restrict to domain (SplitDNS) for the Domain used in ClusterTool for Talos.

![tailscale-nameserver](./img/tailscale-nameserver.png)

### Working Helm Release Example

```
---
# yaml-language-server: $schema=https://kubernetes-schemas.pages.dev/helm.toolkit.fluxcd.io/helmrelease_v2.json
apiVersion: helm.toolkit.fluxcd.io/v2
kind: HelmRelease
metadata:
  name: tailscale
  namespace: tailscale
spec:
  interval: 15m
  chart:
    spec:
      chart: tailscale
      version: 10.12.0 #Version will change refer to Chart.yaml file
      sourceRef:
        kind: HelmRepository
        name: truecharts
        namespace: flux-system
      interval: 15m
  timeout: 20m
  values:
    global:
      stopAll: false
    TZ: Australia/Sydney
    tailscale:
      authkey: ${TAILSCALE_AUTH_KEY}
      accept_dns: true 
      routes: 192.168.1.0/24 # LAN Example
      advertise_as_exit_node: true
      hostname: "${TAILSCALE_HOSTNAME}"
```

## Support

- You can also reach us using [Discord](https://discord.gg/tVsPTHWTtr) for real-time feedback and support
- If you found a bug in our chart, open a Github [issue](https://github.com/truecharts/apps/issues/new/choose)

---

All Rights Reserved - The TrueCharts Project
