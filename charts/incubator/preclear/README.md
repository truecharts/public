# preclear

A utility to "burn-in" a new disk, before adding it to your array has been requested several times.  Also requested is a process to "pre-clear" a hard disk before adding it to your array.  When a special "signature" is detected, the lengthy "clearing" step otherwise performed by TrueNAS is skipped.

TrueCharts can be installed as both *normal* Helm Charts or as Apps on TrueNAS SCALE.

This readme is just an automatically generated general guide on installing our Helm Charts and Apps.
For more information, please click here: [preclear](https://truecharts.org/docs/charts/incubator/preclear)

**This chart is not maintained by the upstream project and any issues with the chart should be raised [here](https://github.com/truecharts/charts/issues/new/choose)**

## Source Code

* <https://github.com/truecharts/charts/tree/master/charts/incubator/preclear>
* <https://forums.TrueNAS.net/topic/2732-preclear_disksh-a-new-utility-to-burn-in-and-pre-clear-disks-for-quick-add/>
* <https://registry.hub.docker.com/r/binhex/arch-preclear/>
* <https://github.com/binhex/documentation>

## Requirements

Kubernetes: `>=1.16.0-0`

## Dependencies

| Repository | Name | Version |
|------------|------|---------|
| https://library-charts.truecharts.org | common | 10.7.1 |

## Installing the Chart

### TrueNAS SCALE

To install this Chart on TrueNAS SCALE check our [Quick-Start Guide](https://truecharts.org/docs/manual/SCALE%20Apps/Installing-an-App).

### Helm

To install the chart with the release name `preclear`

```console
helm repo add TrueCharts https://charts.truecharts.org
helm repo update
helm install preclear TrueCharts/preclear
```

## Uninstall

### TrueNAS SCALE

**Upgrading, Rolling Back and Uninstalling the Chart**

To upgrade, rollback or delete this Chart from TrueNAS SCALE check our [Quick-Start Guide](https://truecharts.org/docs/manual/SCALE%20Apps/Upgrade-rollback-delete-an-App).

### Helm

To uninstall the `preclear` deployment

```console
helm uninstall preclear
```

## Configuration

### Helm

#### Available Settings

Read through the values.yaml file. It has several commented out suggested values.
Other values may be used from the [values.yaml](https://github.com/truecharts/library-charts/tree/main/charts/stable/common/values.yaml) from the [common library](https://github.com/k8s-at-home/library-charts/tree/main/charts/stable/common).

#### Configure using the command line

Specify each parameter using the `--set key=value[,key=value]` argument to `helm install`.

```console
helm install preclear \
  --set env.TZ="America/New York" \
    TrueCharts/preclear
```

#### Configure using a yaml file

Alternatively, a YAML file that specifies the values for the above parameters can be provided while installing the chart.

```console
helm install preclear TrueCharts/preclear -f values.yaml
```

#### Connecting to other charts

If you need to connect this Chart to other Charts on TrueNAS SCALE, please refer to our [Linking Charts Internally](https://truecharts.org/docs/manual/SCALE%20Apps/linking-apps) quick-start guide.

## Support

- Please check our [quick-start guides for TrueNAS SCALE](https://truecharts.org/docs/manual/SCALE%20Apps/Important-MUST-READ).
- See the [Website](https://truecharts.org)
- Check our [Discord](https://discord.gg/tVsPTHWTtr)
- Open a [issue](https://github.com/truecharts/apps/issues/new/choose)

---

## Sponsor TrueCharts

TrueCharts can only exist due to the incredible effort of our staff.
Please consider making a [donation](https://truecharts.org/sponsor) or contributing back to the project any way you can!

---

All Rights Reserved - The TrueCharts Project
