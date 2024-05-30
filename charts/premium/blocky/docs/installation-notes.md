---
title: Installation notes
---

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

## Configuration Instructions

We offer two styles of configuration, both can be directly applied in values.yaml, without the need of persistence or editing configmaps.
Besides this, the TrueNAS SCALE App exposes all config options directly in the GUI, except the Redis and Prometheus settings which are automatically configured.

### TrueNAS SCALE

All configuration options are directly reflected in the TrueNAS SCALE App GUI and can be edited as you see fit.
The App is, by default, configured to be high available so editing and updates should not cause needless downtime.

### Native Helm

There are two ways of editing configuration, we will call them `List Style` and `Blocky Style`.

- `List Style` configuration has been developed by us to optimise for display in the TrueNAS SCALE WebUI. However: It can also be completely edited in `values.yaml`. In this case each setting has been pre-configured and is documented in `values.yaml` (available on github)
- `Blocky Style` configuration, can be directly added below the `blockyConfig` object in `values.yaml`, please make sure the config is correctly indented

We would advice using `List Style` when possible as that is the most tested configuration style. But for things like migration some users might prefer to use `Blocky Style` instead

### Adding config by mounting files

Adding additional configuration files is not possible, as this feature has not been released yet.

However: We have verified if this would work and we will have to conclude that when 0.20 is released, we will not support multiple config files, as those will inherently conflict with our design. Due to duplicate keys breaking blocky.
With all the config already available in values.yaml, we do not really see a usecase for this on kubernetes. Apart from this, manually mounting configfiles might negatively affect High Availability and Rollback on kubernetes.

You can also mount custom Whitelist/Blacklist files, using `persistence` or, in SCALE GUI, `Additional Storage` and enter the path in your whitelist or blacklist settings manually
However: this negatively affects rollback and high availability, so we _highly_ advice against doing this.

## k8s-gateway

Our blocky Chart/App includes build-in compatibility for [k8s_gateway](https://github.com/ori-edge/k8s_gateway).
This tool can be used to achieve [Split DNS](https://en.wikipedia.org/wiki/Split-horizon_DNS) to ensure devices on your local network connect directly to the LAN IP of any Charts/Apps using Ingress, instead of via the outside world or, in a lot of cases, having a bunch of connectivity issues.

To setup k8s_gateway add **your** root domain(s) to the `k8s_gateway` section domains list, e.g. `mydomain.com`.
From that point onwards we will take care to automatically apply the required `conditional` settings in `blocky` as well.
This will automatically include all your app subdomains exposed via Ingress, e.g. `jellyfin.mydomain.com`.

Please be mindfull that using `Blocky Style` configuration, using the `blockyConfig` object in `values.yaml`, might override this automatic setup.
