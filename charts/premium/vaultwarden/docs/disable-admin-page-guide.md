---
title: Disabling the Admin Interface
---

:::caution[Backup Reminder]

Before proceeding, ensure that you have backed up important configurations, especially when making changes to configuration files or secrets. It's also advisable to back up the Vaultwarden database to prevent potential data loss.

:::

This guide is a combination of the [upstream documentation](https://github.com/dani-garcia/vaultwarden/wiki/Enabling-admin-page#disabling-the-admin-page) and how we implemented it.

## Modify the Host Secret

To start with the deactivation, you must first modify the secret on the host's shell. Execute the following command:

```bash
k3s kubectl patch secret vaultwarden-vaultwardensecret -n ix-vaultwarden --type='json' -p='[{"op": "remove", "path": "/data/ADMIN_TOKEN"}]'
```

:::tip[Command Explanation]

The command above utilizes `kubectl`, a command-line tool for interacting with Kubernetes clusters. Here's a breakdown:

- `k3s`: This is a lightweight version of Kubernetes.
- `patch secret vaultwarden-vaultwardensecret`: This indicates that we are patching (modifying) the secret named `vaultwarden-vaultwardensecret`.
- `-n ix-vaultwarden`: This specifies the namespace (`ix-vaultwarden`) in which the secret resides.
- `--type='json'`: Specifies that the patch content is of type JSON.
- `-p='[{"op": "remove", "path": "/data/ADMIN_TOKEN"}]'`: This JSON patch instruction tells Kubernetes to remove the `ADMIN_TOKEN` field from the secret.

:::

## Update Container Config

Next, while inside the Vaultwarden container, run the command below to modify the `config.json` file:

```bash
sed -i.bak '/admin_token/d' /data/config.json
```

:::tip[Command Explanation]

- The `sed` command is used to search and delete the line containing `admin_token` from the `config.json` file.
- A backup of the original `config.json` is created with the `.bak` extension before making the change.

:::

## Adjust the App Configuration

Finally, head to the Vaultwarden app's configuration:

1. Find and disable the admin interface option (if it is still enabled).
2. Click "Save" at the bottom to apply the changes.
