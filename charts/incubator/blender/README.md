# blender

Blender(https://www.blender.org/) is a free and open-source 3D computer graphics software toolset used for creating animated films, visual effects, art, 3D printed models, motion graphics, interactive 3D applications, virtual reality, and computer games. **This image does not support GPU rendering out of the box only accelerated workspace experience**

TrueCharts can be installed as both *normal* Helm Charts or as Apps on TrueNAS SCALE.

This readme is just an automatically generated general guide on installing our Helm Charts and Apps.
For more information, please click here: [blender](https://truecharts.org/docs/charts/incubator/blender)

**This chart is not maintained by the upstream project and any issues with the chart should be raised [here](https://github.com/truecharts/charts/issues/new/choose)**

## Source Code

* <https://github.com/truecharts/charts/tree/master/charts/incubator/blender>
* <https://www.blender.org/>
* <https://github.com/orgs/linuxserver/packages/container/package/blender>
* <https://github.com/linuxserver/docker-blender#readme>

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

To install the chart with the release name `blender`

```console
helm repo add TrueCharts https://charts.truecharts.org
helm repo update
helm install blender TrueCharts/blender
```

## Uninstall

### TrueNAS SCALE

**Upgrading, Rolling Back and Uninstalling the Chart**

To upgrade, rollback or delete this Chart from TrueNAS SCALE check our [Quick-Start Guide](https://truecharts.org/docs/manual/SCALE%20Apps/Upgrade-rollback-delete-an-App).

### Helm

To uninstall the `blender` deployment

```console
helm uninstall blender
```

## Configuration

### Helm

#### Available Settings

Read through the values.yaml file. It has several commented out suggested values.
Other values may be used from the [values.yaml](https://github.com/truecharts/library-charts/tree/main/charts/stable/common/values.yaml) from the [common library](https://github.com/k8s-at-home/library-charts/tree/main/charts/stable/common).

#### Configure using the command line

Specify each parameter using the `--set key=value[,key=value]` argument to `helm install`.

```console
helm install blender \
  --set env.TZ="America/New York" \
    TrueCharts/blender
```

#### Configure using a yaml file

Alternatively, a YAML file that specifies the values for the above parameters can be provided while installing the chart.

```console
helm install blender TrueCharts/blender -f values.yaml
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
