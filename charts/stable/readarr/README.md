# readarr

![Version: 11.0.20](https://img.shields.io/badge/Version-11.0.20-informational?style=flat-square) ![Type: application](https://img.shields.io/badge/Type-application-informational?style=flat-square) ![AppVersion: 0.1.1.1352](https://img.shields.io/badge/AppVersion-0.1.1.1352-informational?style=flat-square)

A fork of Radarr to work with Books & AudioBooks

TrueCharts can be installed as both *normal* Helm Charts or as Apps on TrueNAS SCALE.

This readme is just an automatically generated general guide on installing our Helm Charts and Apps.
For more information, please click here: [readarr](https://truecharts.org/docs/charts/stable/readarr)

**This chart is not maintained by the upstream project and any issues with the chart should be raised [here](https://github.com/truecharts/charts/issues/new/choose)**

## Source Code

* <https://github.com/Readarr/Readarr>
* <https://readarr.com>

## Requirements

Kubernetes: `>=1.16.0-0`

## Dependencies

| Repository | Name | Version |
|------------|------|---------|
| https://library-charts.truecharts.org | common | 10.4.6 |

## Installing the Chart

### TrueNAS SCALE

To install this App on TrueNAS SCALE check our [Quick-Start Guide](https://truecharts.org/docs/manual/Quick-Start%20Guides/02-Installing-an-App/).

### Helm

To install the chart with the release name `readarr`

```console
helm repo add TrueCharts https://helm.truecharts.org
helm repo update
helm install readarr TrueCharts/readarr
```

## Uninstall

### TrueNAS SCALE

**Upgrading, Rolling Back and Uninstalling the Chart**

To upgrade, rollback or delete this App from TrueNAS SCALE check our [Quick-Start Guide](https://truecharts.org/docs/manual/Quick-Start%20Guides/04-Upgrade-rollback-delete-an-App/).

### Helm

To uninstall the `readarr` deployment

```console
helm uninstall readarr
```

## Configuration

### Helm

#### Available Settings

Read through the [values.yaml](./values.yaml) file. It has several commented out suggested values.
Other values may be used from the [values.yaml](https://github.com/truecharts/library-charts/tree/main/charts/stable/common/values.yaml) from the [common library](https://github.com/k8s-at-home/library-charts/tree/main/charts/stable/common).

#### Configure using the Commandline

Specify each parameter using the `--set key=value[,key=value]` argument to `helm install`.

```console
helm install readarr \
  --set env.TZ="America/New York" \
    TrueCharts/readarr
```

#### Configure using a yaml file

Alternatively, a YAML file that specifies the values for the above parameters can be provided while installing the chart.

```console
helm install readarr TrueCharts/readarr -f values.yaml
```

#### Connecting to other apps

If you need to connect this App to other Apps on TrueNAS SCALE, please refer to our [Linking Apps Internally](https://truecharts.org/docs/manual/Quick-Start%20Guides/06-linking-apps/) quick-start guide.

## Support

- Please check our [quick-start guides for TrueNAS SCALE](https://truecharts.org/docs/manual/SCALE%20Apps/Quick-Start%20Guides/Important-MUST-READ).
- See the [Website](https://truecharts.org)
- Check our [Discord](https://discord.gg/tVsPTHWTtr)
- Open a [issue](https://github.com/truecharts/apps/issues/new/choose)

---

## Sponsor TrueCharts

TrueCharts can only exist due to the incredible effort of our staff.
Please consider making a [donation](https://truecharts.org/docs/about/sponsor) or contributing back to the project any way you can!

---

All Rights Reserved - The TrueCharts Project
