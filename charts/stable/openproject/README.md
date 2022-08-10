# openproject

![Version: 0.0.17](https://img.shields.io/badge/Version-0.0.17-informational?style=flat-square) ![Type: application](https://img.shields.io/badge/Type-application-informational?style=flat-square) ![AppVersion: 12](https://img.shields.io/badge/AppVersion-12-informational?style=flat-square)

OpenProject is a web-based project management system for location-independent team collaboration.

TrueCharts can be installed as both *normal* Helm Charts or as Apps on TrueNAS SCALE.

This readme is just an automatically generated general guide on installing our Helm Charts and Apps.
For more information, please click here: [openproject](https://truecharts.org/docs/charts/stable/openproject)

**This chart is not maintained by the upstream project and any issues with the chart should be raised [here](https://github.com/truecharts/charts/issues/new/choose)**

## Source Code

* <https://github.com/truecharts/charts/tree/master/charts/incubator/openproject>
* <http://openproject.org>
* <https://hub.docker.com/u/openproject>

## Requirements

Kubernetes: `>=1.16.0-0`

## Dependencies

| Repository | Name | Version |
|------------|------|---------|
| https://charts.truecharts.org/ | postgresql | 8.0.52 |
| https://library-charts.truecharts.org | common | 10.4.9 |

## Installing the Chart

### TrueNAS SCALE

To install this Chart on TrueNAS SCALE check our [Quick-Start Guide](https://truecharts.org/docs/manual/SCALE%20Apps/Quick-Start%20Guides/Installing-an-App).

### Helm

To install the chart with the release name `openproject`

```console
helm repo add TrueCharts https://charts.truecharts.org
helm repo update
helm install openproject TrueCharts/openproject
