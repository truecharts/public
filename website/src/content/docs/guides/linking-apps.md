---
title: Linking Charts Internally
---

You'll often need to connect individual charts to each other to exchange data, for example: Sonarr to SABnzbd to allow Sonarr to control downloads within SABnzbd.

As you can't point directly to other Kubernetes charts using their IP address you need to use their internal domain name instead.

Please be aware: this name is only available between Charts and cannot be reached from the host/node or your own PC.

## Main Service

For most charts, you'll want to contact the main service (usually the web interface or primary way you interact with the chart)

Please replace `$NAME` below with the name you gave your Chart when installing it, `$NAMESPACE` with the namespace the chart is installed in and `CHARTNAME` with the name from our helm repository.

**If your chart name is the same as the name of the chart as in the helm repository, the format is as follows:**

`$NAME.$NAMESPACE.svc.cluster.local`

**If your chart name is _NOT_ the same as the name of the chart as in the helm repository, the format is as follows:**

`$NAME-$CHARTNAME.$NAMESPACE.svc.cluster.local`

### Multiple Services

If you need to reach a different service of your chart (which is not often the case), you need a slightly different format.

As well as the above naming, replace `$SVCNAME` with the name of the service you want to reach:

**If your chart name _contains_ the name of the chart as in the helm repository, the format is as follows:**

`$NAME-$SVCNAME.$NAMESPACE.svc.cluster.local`

**If your chart name _does NOT contain_ the name of the chart as in the helm repository, the format is as follows:**

`$NAME-$CHARTNAME-$SVCNAME.$NAMESPACE.svc.cluster.local`

Be aware: you'll only be able to reach ports published on the service they are published to - see the Multiple Services example below for a
demonstration of this.


## Naming Examples

### Main Service

To reach a chart named "sabnzbd" in this example (note: the name contains the helm repository chart name "sabnzbd") you can use the following internal domain name:

`sabnzbd.sabnzbd.svc.cluster.local`

To reach a chart named "sab" (note: the name does NOT contain helm repository chart name "sabnzbd") you can use the following internal domain name:

`sab-sabnzbd.sab.svc.cluster.local`

To reach a chart named "sabnzbd-23" (note: the name contains the helm repository chart name "sabnzbd" as well as extra name information "-23") you can use the following internal domain name:

`sabnzbd-23.sabnzbd-23.svc.cluster.local`

### Multiple Services

This is an example of where a chart has more than one service, in this case, Traefik.

Its main service (note it follows the examples above) is located at

`traefik.traefik.svc.cluster.local`

Then, its extra services, one for metrics, and one for TCP, are located at

`traefik-metrics.traefik.svc.cluster.local`
and
`traefik-tcp.traefik.svc.cluster.local`

When you install a chart with multiple services, you'll be able to see which ports are published to which service - if you aren't sure of this check your values.yaml.

This is example of the above services for traefik:

`traefik.traefik.svc.cluster.local                        9000/TCP`
`traefik-metrics.traefik.svc.cluster.local                9180/TCP`
`traefik-tcp.traefik.svc.cluster.local                    80/TCP,443/TCP`

So, if you wanted to reach the metrics port, you should use `traefik-metrics.traefik.svc.cluster.local` as the name as that port would not be available on other services.
