---
title: Automatic Split DNS with PiHole
---

_Using Blocky in conjunction with PiHole enables seamless automated split DNS functionality._

:::danger[unrecommended configuration]

The below guide is not the recommended DNS solution for TrueCharts. We recommend running Blocky from the premium train in a standalone configuration. Setting up your DNS as outlined below adds complexity and will reduce reliability.

:::

## Deploy Blocky

:::note[Blocky]

Blocky includes k8s Gateway which automates the split DNS process. We will be using Blocky in between PiHole and your upstream DNS servers of choice to resolve your domain.

:::

- Deploy Blocky
- Make sure k8s-Gateway is enabled.
- Assuming you would like to use PiHole for Allow/Deny list, configure Blocky that those list from blocky are disabled. To disable the Blocky Deny lists this can be used in the deployment of Blocky:

```yaml
clientGroupsBlock:
    []
```


## Deploy PiHole

Deploy PiHole with the following configuration:

- Namespace needs to be `privileged`
- Set a loadBalancerIP or Ingress to the `main` service
- Set a loadBalancerIP to the `dns` service
- `FTLCONF_webserver_api_password`, here you need to pick a password for the PiHole WebGUI.
- `FTLCONF_dns_upstreams`, here you need to set your Blocky DNS address.

Example configuration:
```yaml
env:
  FTLCONF_dns_upstreams: "${BLOCKY_IP}"
  FTLCONF_webserver_api_password: "DitIsSuperGeheim"
```

## Configure Router

1. Configure your router to use your PiHole DNS when configuring DNS clients. You will need to consult your router manual for this as each router is different.
In above example, the router should be configured to use 192.168.1.221 as the DNS server.
