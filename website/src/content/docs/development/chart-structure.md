---
title: Chart Structure
---

This is a general synopsis about the structure of Helm Chart, it does not directly reflect TrueCharts specific settings.

The following files are generally considered to be a "normal" Helm chart:

```text
charts/<train>/<chart name>/
  charts/                  # Directory containing dependency charts
  Chart.yaml               # Required Helm chart information file
  README.md                # Optional: Helm Readme file (will be rendered in TrueNAS SCALE UI as well)
  templates/               # A directory of templates that, when combined with values.yml will generate K8s YAML
  values.yaml              # The default configuration values for this chart
```

_See the upstream Helm chart [developer reference](https://helm.sh/docs/chart_template_guide/) for a complete walk through of developing charts._
