---
title: Configure password authentication
---

## Edit chart config

Change the chart's config to disable `allow_anonymous` by setting authentication to `enabled`.

```yaml title="values.yaml"
auth:
  # -- By enabling this, `allow_anonymous` gets set to `false` in the mosquitto config.
  # highlight-next-line
  enabled: true
```

## Create password and config files

Open the Mosquitto container shell and execute the following commands, _one by one_, in order:

```sh
cd /mosquitto/configinc
mosquitto_passwd -c passwordfile username
echo "password_file /mosquitto/configinc/passwordfile" > passwordconfig.conf
```

:::tip[These commands explained]

- Navigate to `/mosquitto/configinc`, the persistent storage location inside the container where the password files go
- Create a password file. This is interactive. Change `username` to your username. It will ask you to input the password twice
- Create a config file that points to the password file

:::

:::caution[Restart chart]

Restart the chart so Mosquitto loads the new configuration file.

:::
