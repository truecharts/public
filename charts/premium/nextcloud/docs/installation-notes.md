---
title: Installation Notes
---

## Requirements

Ingress is required to be configured. The preferred and supported method for ingress is Traefik. More information can be found on our [getting started guide](/.

## Nextcloud Configurations

### Required

The following configurations must be set during initial setup in order for Nextcloud to deploy.

```yaml
// values.yaml
nextcloud:
  credentials:
    # An admin username needs to be set
    initialAdminUser: admin
    # An admin password needs to be set.
    initialAdminPassword: somepassword
  general:
    # The default phone region needs to be set (if you are unsure about your region, you can find your code for your region in this [wiki](https://en.wikipedia.org/wiki/ISO_3166-1_alpha-2#Officially_assigned_code_elements))
    default_phone_region: US
    # You must set `accessIP` to the ip address used by _Traefik_
    accessIP: 192.168.0.10
```

:::caution[Password Requirements]

Due to limitations when converting YAML to JSON, the passwords used with Nextcloud for admin and Postgres must **only** start with a letter or number. If you attempt to use a password that starts with a symbol, e.g. '%', Nextcloud will fail to install as it will be unable to convert the YAML to JSON.

:::

### Optional Addons

```yaml
// values.yaml
nextcloud:
# ClamAV (Anti-virus for Nextcloud, keep in mind that only scans files that Nextcloud posts to its endpoint. A Clam AV container will be deployed automatically.
  clamav:
    enabled: true
    stream_max_length: 26214400
    file_max_size: -1
    infected_action: only_log
# Notify Push (Allows Nextcloud to notify clients of changes, instead of clients having to poll. A Notify Push container will be deployed automatically). This is highly recommended to keep enabled.
  notify_push:
    enabled: true
# Collabora (document editor for Nextcloud. A Collabora container will be deployed automatically.
  collabora:
    enabled: true
    # default|compact|tabbed
    interface_mode: default
    username: admin
    password: changeme
    dictionaries:
      - de_DE
      - en_GB
      - en_US
      - el_GR
      - es_ES
      - fr_FR
      - pt_BR
      - pt_PT
      - it
      - nl
      - ru
# Only Office (document editor for Nextcloud, this does **NOT** deploy the Only Office container. You will need to have a separate installation.
  onlyoffice:
    enabled: false
    url: ""
    internal_url: ""
    verify_ssl: true
    jwt: ""
    jwt_header: Authorization
```

### Storage

You can change the User Data Storage option to your preference here. All other Storage should remain the default of PVC.

```yaml
// values.yaml
persistence:
  data:
    enabled: true
    type: nfs
    path: /mnt/data/nextcloud
    server: 192.168.1.100
    targetSelector:
      main:
        main:
          mountPath: /var/www/html/data
        init-perms:
          mountPath: /var/www/html/data
      nextcloud-cron:
        nextcloud-cron:
          mountPath: /var/www/html/data
      preview-cron:
        preview-cron:
          mountPath: /var/www/html/data
      nginx:
        nginx:
          mountPath: /var/www/html/data
          readOnly: true
```
