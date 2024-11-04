---
title: Helm Basics
---

:::caution[Charts]

We only support our own helm-charts. If you run anything outside the scope of our helm-charts, we cannot guarantee interoperability and you might run into issues we're unable to support with resolving

:::

## Installing a Chart

If you want to install a chart using helm, lookup the name of the chart in our [Chart list](/charts/description-list). Then, run this command to install it directly from our OCI repository:

```shell title="Install Chart"
   helm install mychart oci://tccr.io/truecharts/CHARTNAME
   ```

_Where `CHARTNAME` is the name of the chart you want to add and `mychart` is the name you want it to have on your system._

We highly suggest your write your customisations and user specific options in your own `values.yaml` file. After which, you can install the chart with your user-specific settings applied using:

```shell title="Install Chart With Settings"
   helm install mychart oci://tccr.io/truecharts/CHARTNAME -f values.yaml
   ```

_`values.yaml` can be replaced with a path of your choice._

We also advise users to specify separate namespaces for deployed charts using:

```shell title="Chart Namespaces"
   helm install mychart oci://tccr.io/truecharts/CHARTNAME -f values.yaml -n NAMESPACE
   ```

_Where `NAMESPACE` is the namespace you want to deploy to._

For more information, please see the [Helm install docs](https://helm.sh/docs/helm/helm_install/)

## Upgrading Charts

To upgrade either the chart version and/or the user-defined settings for an already-installed Helm chart you can use "helm upgrade".
While this does not actually update the chart version, it does update the user settings supplied via the `values.yaml` file specified above.

```shell title="Chart Upgrades"
   helm upgrade oci://tccr.io/truecharts/CHARTNAME -f values.yaml -n NAMESPACE
   ```

For more information, please see the [Helm upgrade docs](https://helm.sh/docs/helm/helm_upgrade/)

---
