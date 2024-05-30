---
title: SFTPGo Plugins
---

Due to a number of different possible combinations of plugins, final configuration
must be done through manually set environmental variables. Please refer to examples below.

Note that all examples still require their env variables to be set in the proper chart
area, however without these manual additons those env variables won't add any functions to
the container.

## Examples

### LDAP Only

```yaml
SFTPGO_PLUGINS__0__TYPE: auth
SFTPGO_PLUGINS__0__AUTH_OPTIONS__SCOPE: 5
SFTPGO_PLUGINS__0__CMD: "/usr/local/bin/sftpgo-plugin-auth"
SFTPGO_PLUGINS__0__ARGS: "serve"
SFTPGO_PLUGINS__0__AUTO_MTLS: 1
```

### LDAP & Geoblocking

```yaml
SFTPGO_PLUGINS__0__TYPE: auth
SFTPGO_PLUGINS__0__AUTH_OPTIONS__SCOPE: 5
SFTPGO_PLUGINS__0__CMD: "/usr/local/bin/sftpgo-plugin-auth"
SFTPGO_PLUGINS__0__ARGS: "serve"
SFTPGO_PLUGINS__0__AUTO_MTLS: 1
SFTPGO_PLUGINS__1__TYPE: geoipfilter
SFTPGO_PLUGINS__1__CMD: "/usr/local/bin/sftpgo-plugin-geoipfilter"
SFTPGO_PLUGINS__1__ARGS: "serve"
```

### Geoblocking Only

```yaml
SFTPGO_PLUGINS__0__TYPE: geoipfilter
SFTPGO_PLUGINS__0__CMD: "/usr/local/bin/sftpgo-plugin-geoipfilter"
SFTPGO_PLUGINS__0__ARGS: "serve"
```

### Tip

There are [some variables][1] which can only be found by looking at code.

[1]: https://github.com/drakkan/sftpgo/blob/cb3bc3f6043791081d28b9b1666a053a33e2a962/internal/config/config.go#L920
