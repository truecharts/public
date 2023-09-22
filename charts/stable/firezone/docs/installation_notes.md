# Installation Notes

How to setup FireZone.

## Web Configuration

- Set a `External Url` to a valid FQDN; "<https://app.mydomain.tld>".
- Set a `Trusted Proxies` a single IP for your traefik instance(s) on each box.

## Admin Configuration

- Keep `Reset Admin On Boot` true.
- Set a `Default Email` and a `Default Password` to login into the web GUI.

## Devices Configuration

Most configuration can be left default here but some you want to change.

- Set `Default Client MTU` to a size that works for _your_ network, default is 1280.
- Set `Client Endpoint` to any of the following, if using a domain it needs to resolve to your public IP so it can not be proxied on CloudFlare.

  - publicIP:WG_PORT
  - app.domain.tld:WG_PORT
  - domain.tld:WG_PORT

- Set `Client DNS` to just your local DNS server to have a working split dns within your vpn.

- Set `Client Allowed Ips` to a range of IPs.
  - `0.0.0.0/0` will resolved everything.
  - `appsIP/32` will resolve just the app domains only.
