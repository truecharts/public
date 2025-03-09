---
title: How-To
---

This is a quick how-to or setup-guide to have a local Wireguard server.

:::note[routing]

The best is to have all routing done by a router, including things like VPN routing. Deploy this chart only if you don't have another option.

:::

## Requirements

Domain name (can be free using DuckDNS or any DDNS) that has your current WAN IP, WAN IP not recommended unless you have a static IP.

:::caution[Domain and Reverse Proxy]
The domain you use should not be behind a reverse proxy, such as Cloudflare Proxy (disable the proxy on the subdomain on the Cloudflare dashboard. The default is Proxied (orange cloud), set to DNS only (grey cloud)), as it won't accurately represent your real WAN IP. To address this, consider creating a subdomain dedicated to Wireguard and disabling the reverse proxy for that specific subdomain only.
:::

![wg-easy-dns-only](./img/wg-easy-dns-only.png)

## Prerequisites

### Sysctl
:::note[sysctl]

This part is not needed for Clustertool setup with TalosOS.

:::
At some OS's it is required to set two `sysctl` values for proper acces to your local network (LAN). Check your OS documentation how this needs to be done.
```
net.ipv4.ip_forward = 1
net.ipv4.conf.all.src_valid_mark = 1
```

### Firewall rules
UDP Port 51820 (if kept standard) opened on your firewall with port-forwarding to your loadBalancerIP used in your `.Values`. How to setup port-forwarding with your network equipment, please check the manual of your device.

## Chart Configuration

### Namespace Labels
This chart needs to privileged rights. Add the following label to your namespace:

```yaml
labels:
  pod-security.kubernetes.io/enforce: privileged
```
### Configure your .Values

Set an IP to your Wireguard UDP servive.
The default port for the Wireguard UDP service is `51820` and it needs to be accessible outside your network in order for the Wireguard tunnel to work. Therefore if you change this port make sure you change the port on your Firewall as well.

```yaml
service:
  vpn:
    loadBalancerIP: ${WG_EASY_IP}
    type: LoadBalancer
    externalTrafficPolicy: Local
```

Configuration can be done via the following environment variables:

- `WG_HOST`: Set WAN IP, or a Dynamic DNS hostname. A domain name cannot be proxied.
- `WG_MTU`: The MTU the clients will use. Server uses default WG MTU = 1420
- `WG_PERSISTENT_KEEPALIVE`: Value in seconds to keep the "connection" open. If this value is 0, then connections won't be kept alive.
- `WG_DEFAULT_ADDRESS`: only if it conflicts with other IP addresses on your network
- `WG_DEFAULT_DNS`: can be set to your local DNS (eg my PiHole box) or a generic one like `1.1.1.1`
- `WG_ALLOWED_IPS`: Allowed IPs clients will use.
- `PASSWORD_HASH` _required_ - Always best to have some security in front of the GUI page. Password set needs to use bcrypt. You can create a hash at https://bcrypt.online/
- `LANG`: Web UI language (Supports: en, ua, ru, tr, no, pl, fr, de, ca, es, ko, vi, nl, is, pt, chs, cht, it, th, hi).
- `UI_TRAFFIC_STATS`: Enable detailed RX / TX client stats in Web UI


```yaml
workload:
  main:
    podSpec:
      containers:
        main:
          env:
            WG_HOST: "${DOMAIN}"
            WG_MTU: 1420
            WG_PERSISTENT_KEEPALIVE: 0
            WG_DEFAULT_ADDRESS: "10.8.0.x"
            WG_DEFAULT_DNS: "191.168.1.1"
            WG_ALLOWED_IPS: "0.0.0.0/0, ::/0"
            PASSWORD_HASH: "$2y$12$iPAVrWmmVshBbr6CpJWGw.wlpaulOsVMpb.Tdo53xnNrpZt.T9odK"
            LANG: "en"
            UI_TRAFFIC_STATS: "false"
```


## Recommendations for use of WG-Easy
**Multiple Users**
If you're creating multiple users setting up Ingress for the Portal/GUI page is a secure and easy way to download your Wireguard configs or use the handy QR code scanner from your mobile device with the Wireguard app on iOS or Android.

![wg-chart-gui](./img/wg-easy-gui.png)

**More options**
There's a few options in the upstream container that aren't present by default in this chart that can be added as environment values. Please refer to the [upstream](https://github.com/weejewel/wg-easy) documentation as necessary and add those ENV VARS at your discretion without any support.

## Important note for users with Clustertool Setup and WG_Easy
:::warning[Cilium changes]

Do this changes at your own risk. Those are not covered by Truecharts Support.

:::

Access Applications running on your Talos Cluster from outside your LAN via WG_Easy, will not work with a standard Clustertool Setup.
This can be made to work with a `Cilium` modification. Add the following to your Cilium deployment `.Values`:

```yaml
socketLB:
  hostNamespaceOnly: true
```

## Support

- If you need more details or have a more custom setup the documentation on the [upstream](https://github.com/wg-easy/wg-easy) is very complete so check the descriptions of the options there.
- You can also reach us using [Discord](https://discord.gg/tVsPTHWTtr) for real-time feedback and support
- If you found a bug in our chart, open a Github [issue](https://github.com/truecharts/apps/issues/new/choose)

---

All Rights Reserved - The TrueCharts Project
