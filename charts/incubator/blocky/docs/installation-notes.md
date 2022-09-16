# Installation notes

## Default Configuration

The following config will be pre-configured and merged with any config you manually add to `blockyConfig` option in `values.yaml`:

Redis (always present):

```yaml
redis:
  address: $redis_host:6379
  password: $redis_pass
  database: 0
  required: true
  connectionAttempts: 10
  connectionCooldown: 3s
```

Prometheus (Only present if enabled):

```yaml
prometheus:
  enable: true
  path: /metrics
```

Upstreams (from values.yaml):

```yaml
upstream:
  default:
    -  # Content from `.Values.defaultUpstreams`
  # Additional upstream groups from `.Values.upstreams`
```

Whitelist/Blacklist (from values.yaml) :

```yaml
blocking:
  blockType: nxDomain
  blockTTL: 6h
  refreshPeriod: 4h
  downloadTimeout: 60s
  downloadAttempts: 3
  downloadCooldown: 2s
  failStartOnListError: false
  processingConcurrency: 4
  whiteLists:
    # Groupname:
      -  # Content from .Valuesblocking.whiteList
  blackLists:
    # Groupname:
      -  # Content from .Valuesblocking.blackList
  clientGroupsBlock
    # Groupname:
      -  # Content from .Values.blocking.clientGroupsBlock
```

## Configuration Instructions

### TrueNAS SCALE

For TrueNAS SCALE, we offer only a limited subset of configuration options:

- Upstream DNS servers
- Whitelists
- Blocklists

Those have special variables in `values.yaml`, so we can show them nicely in the TrueNAS SCALE GUI

### Native Helm

For anything but TrueNAS SCALE, we would advice to instead use `blockyConfig` in `Values.yaml` and NOT mount any configuration file manually.

In short:

- Add your config in `values.yaml` under `blockyConfig:`
- Add your whitelists in `values.yaml` under `blockyWhitelist` or manually using blockyConfig
- Add your blacklists in `values.yaml` under `blockyBlacklist` or manually using blockyConfig

### Adding config by mounting files

You can mount custom config files, using `persistence` or, in SCALE GUI, `Additional Storage` to the following path:
`/app/config/`
_However it cannot reference any of the pre-defined variables listed above, so it's use is severely limited._

You can also mount custom Whitelist/Blacklist files, using `persistence` or, in SCALE GUI, `Additional Storage` and enter the path in your whitelist or blacklist settings manually
