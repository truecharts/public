# Traefik

Traefik is a reverse proxy, this means it sits in-between your servers and the internet. Often these reverse proxies also, just like traefik, function as SSL endpoints, this means they encrypt the traffic comming from/to your servers.

Standalone without docker Traefik is quite a challenge to setup right. JailMan tries to make it as easy as possible for your, by doing most of the groundwork and tweaking for you.
This also means we don't support all features of traefik. We use traefik as a central reverse proxy and ssl termination endpoint for all our jails. Nothing more, Nothing less.

To make things as streamlined as possible we had to make choices. Hence we only support DNS-verification for certificate generation. No http(s) verification is included.

**For more information about Traefik, please checkout:**
https://containo.us/traefik/

## Configuration Parameters

Traefik requires a little more variables to setup in config.yml than other jails.
Here is the list of configuration parameters:

- dns_provider: The DNS provider you are using to verify ownership of the domain. This is required to get a letsencrypt certificate. We only support DNS-verification for certificate generation.
- domain_name: The domain name you want to use to connect to traefik. Needs to be accessable at the DNS provider (cert_provider) with the DNS credentials (cert_env) provided.
- cert_email: The email adress to link to the Lets Encrypt certificate
- dashboard: set to "true" to enable the dashboard.
- cert_env: For DNS verification we need login credentials and need to write those in a way Traefik understands. You can find the requirements for your DNS provider at the traefik website: https://docs.traefik.io/https/acme/
  You will need to use 2 spaces(!) in front and enter them below this configuration option. Like this:

```
    cert_env:
      CF_API_EMAIL: fake@email.adress
      CF_API_KEY: ftyhsfgufsgusfgjhsfghjsgfhj
```

### Advanced settings

These settings are normally not required or normally used, but might come in handy for advanced users.

- cert_staging: Set this to "true" if you want to test it out using the Lets Encrypt staging server. Set it to "false" or (preferable) just leave it out to use the production server.
- cert_wildcard_domain: If you want to generate wildcard certificates, please enter the domain name here, without `*.` (ex. `test.testdomain.com`)
- cert_strict_sni: set to "true" to enable strict SNI checking, set to false or (preferably) just leave it out to disable strict-SNI checking.
- link_influxdb: This links traefik to a influxdb jail to store metrics data (influxdb_password required)
- influxdb_password: this sets up a password to use for the influxdb database
- traefik_auth_basic: Add basic authentication to the traefik dashboard itself (if used on the traefik jail) or another jail (if used on another jail)
- traefik_forward_auth: Add forwarded authentication to the traefik dashboard itself (if used on the traefik jail) or another jail (if used on another jail)

## Installing

To make traefik as easy as possible to install, we advice to base your config.yml settings on the following example:

```
traefikjail:
  blueprint: traefik
  ip4_addr: 192.168.1.200/24
  gateway: 192.168.1.1
  dashboard: true
  traefik_auth_basic: user:password user2:pass2
  domain_name: traefik.test.placeholder.net
  dns_provider: cloudflare
  cert_staging: true
  cert_email: fake@email.net
  cert_wildcard_domain: test.placeholder.net
  # Please follow the guide here: https://docs.traefik.io/https/acme/
  # and enter your DNS providers environment variables below (2 spaces indent) of cert_env
  cert_env:
    CF_API_EMAIL: fake@email.adress
    CF_API_KEY: ftyhsfgufsgusfgjhsfghjsgfhj
  link_influxdb: influxdbjail
  influxdb_password: traefikmetricspass
```

## Usages

To add a jail to traefik, you will need a domain name (which can be accessed using the cert_env settings on traefik).
If you have the domain name configured correctly on traefik, just add the following config parameter to the other jail (not traefik), where $traefikjail is the name of your traefik-jail:

```
  domain_name: myjail.test.com
  traefik_proxy: $traefikjail
```

## Security

If you want to add security to a jail, there are two opions: basic_auth or forward_auth.
**basic_auth:**
Basic_auth uses a simpel username and passowrd prompt before it allows anyone to open the site. It can be enabled by adding the following config parameter in addition to traefik_proxy.

```
  traefik_basic_auth: user1:password1 user2:password2

```

**forward_auth:**
forward_auth checks if you already have access (http not-403) to another website. It's more advanced to setup, but it (for example) enables you to easily add central authentication to jails using organizr.
The following is an example config, using an organizr jail. It needs to be added in addition to traefik_proxy:

```
  traefik_auth_forward: https://organizr.testdomain.com/api/?v1/auth&group=1

```

Although the web interface shows port 9080 and 9443, Traefik is actually also listening on the (more common) port 80 and 443, also known as normal (without port in the URL) http and https ports.
