# Installation notes

## Configuration

This app pre-defines the following configuration:

Redis (always):

```yaml
redis:
  address: $redis_host:6379
  password: $redis_pass
  database: 0
  required: true
  connectionAttempts: 10
  connectionCooldown: 3s
```

Prometheus (Only if enabled):

```yaml
prometheus:
  enable: true
  path: /metrics
```

Whitelist/Blacklist (Only if hostPath or on values.yaml is defined):

```yaml
blocking:
  whiteLists:
    ads:
      - whitelist.txt
      - |
        # inline definition with YAML literal block scalar style
  blackLists:
    ads:
      - blackist.txt
      - |
        # inline definition with YAML literal block scalar style
```

## TrueNAS Scale

- `Config File Host Path`: Define your host config file path
- `Whitelist File Host Path`: Define your host whitelist file path
- `Blacklist File Host Path`: Define your host whitelist file path

## Helm Native

- Add your config in `values.yaml` under `blockyConfig:`
- Add your whitelist in `values.yaml` under `blockyWhitelist:`
- Add your blacklist in `values.yaml` under `blockyBlacklist:`
