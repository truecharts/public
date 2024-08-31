---
title: Installation Notes
---

:::danger

Actions done within `Portainer-CE` can be destructive
for your apps/charts and your data, if you don't know what
are you doing.

:::

:::caution

`Portainer-CE` is designed to work only with Helm Charts / Kubernetes.
You **CANNOT** use it to run docker, docker stacks or docker compose

:::

## Adding TrueCharts Helm repository

Navigate to `Home` -> `local`

- Click `Helm` on the sidebar
- Type `oci://tccr.io/truecharts` under the `Additional Repositories`
- Click `Add repository`

## Replacing default Helm repository with TrueCharts Helm repository

Navigate to `Settings` on the sidebar

- Under `Helm Repository` replace `URL` with `oci://tccr.io/truecharts`
- Click `Save settings`
