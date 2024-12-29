---
title: MetalLB Basic Setup
---

The guide walks through a basic configuration of MetalLB for a single address pool on a layer 2 network. This will allow assigning different IP addresses by app.

## Set Address Pool & L2 Advertisement in MetalLB-Config

Configure `metallb-config` `values.yaml` as shown below.

```yaml
// values.yaml
ipAddressPools:
  # Enter a general name for this IP range. Something like _main_ for this field is fine.
  - name: main
    # If you want MetalLB Services to auto-assign IPs from the configured address pool without needing to specify per chart.
    autoAssign: false
    avoidBuggyIPs: true
    # Specify an IP range for MetalLB to assign IPs that is **OUTSIDE** your current DHCP range on your LAN. For example, if your DHCP range is `192.168.1.100-192.168.1.255`, then your entry can be any range below `192.168.1.100`. This entry can also be specified in CIDR format.
    # For users with VLANs or multiple subnets, you may create create additional address pool objects as needed.
    addresses:
      - 192.168.1.1-192.168.1.100
L2Advertisements:
  # Enter a basic name for your layer 2 advertisement.
  - name: main
    # Use the same name as defined above.
    addressPools:
      - main
```

## 3. Optional: Specify IP Address per Chart or Service

```yaml
// values.yaml
service:
  main:
    loadBalancerIP: 192.168.1.10
```

## 5. Verify IP Addresses Are Assigned

Run the command `kubectl get svc -A` to verify the IP addresses assigned for each of your charts. The IPs will be listed under the `EXTERNAL-IP` column.

If you have an IP conflict with a previously assigned address it will show as `<pending>`.

For details on other configuration options, please reference the [MetaLB documentation](https://metallb.io/configuration/).
