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
- Type `https://charts.truecharts.org` under the `Additional Repositories`
- Click `Add repository`

![add_repo](./img/add_repo.png)

## Replacing default Helm repository with TrueCharts Helm repository

Navigate to `Settings` on the sidebar

- Under `Helm Repository` replace `URL` with `https://charts.truecharts.org`
- Click `Save settings`

![replace_repo](./img/replace_repo.png)
