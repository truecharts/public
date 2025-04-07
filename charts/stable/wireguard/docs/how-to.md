---
title: How-To
---

## Chart Configuration

Wireguard config can be added directly in your `.Values`.

Example:

```yaml
wg:
  # Set to true if you want to enable killswitch
  killswitch: false
  # If you want to exclude networks, do like so
  excludedIP4networks:
    - "10.10.10.0/24"
    - "192.168.1.0/24"
  excludedIP6networks: []
  # Leave empty if you going to use the paste your config bellow
  configFileHostPath: ""
  # Paste your config bellow.
  # Indentation matters!
  config:
    enabled: false
    # Your wg config here eg:
    data: |
      [Interface]
      Address = 10.0.0.1/24
      ListenPort = 51820
      PrivateKey = PRIVATE_KEY

      [Peer]
      PublicKey = PUBLIC_KEY
      AllowedIPs = 0.0.0.0/0
      Endpoint = wg.example:51820
```
<br>

## External config file example
Example `/mnt/pool/vpn.conf` (Name can be any name. eg `wg0.conf`, `x-site.conf`, etc)
Example config content:

```toml
[Interface]
Address = 10.0.0.1/24
ListenPort = 51820
PrivateKey = PRIVATE_KEY

[Peer]
PublicKey = PUBLIC_KEY
AllowedIPs = 0.0.0.0/0
Endpoint = wg.example:51820
```
