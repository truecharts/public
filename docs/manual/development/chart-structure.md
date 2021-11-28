# TrueNAS SCALE Chart Structure

This is a general synopsis about the structure of a SCALE App and/or Helm Chart, it does not directly reflect TrueCharts specific settings.

The following files are generally considered to be a "normal" Helm chart:

```
charts/<train>/<chart name>/
  charts/                  # Directory containing dependency charts
  Chart.yaml               # Required Helm chart information file
  README.md                # Optional: Helm Readme file (will be rendered in TrueNAS SCALE UI as well)
  templates/               # A directory of templates that, when combined with values.yml will generate K8s YAML
  values.yaml              # The default configuration values for this chart
```


The following files are specific for TrueNAS SCALE:

```
charts/<train>/<chart name>/SCALE/
  app-readme.md            # TrueNAS SCALE Specific: Readme file for display in TrueNAS SCALE UI, automatically generated
  questions.yaml           # TrueNAS SCALE Specific: File containing questions for TrueNAS SCALE UI
  ix_values.yaml           # Hidden configuration values when installing using TrueNAS SCALE
  item.yaml                # Contains generic information about the App for the TrueNAS SCALE UI
```

*See the upstream Helm chart [developer reference](https://helm.sh/docs/chart_template_guide/) for a complete walk through of developing charts.*

To convert an upstream chart to take advantage of TrueNAS SCALE enhanced UX, first create an `item.yaml` file.
This file among other catalog item information provides a list of categories that this chart fits into. This helps users navigate and filtering when browsing the catalog UI.

```
$ cat charts/<train>/<chart name>/SCALE/item.yaml
categories:
  - generic
icon_url: "http://ix_url"
```


Then add a `questions.yaml` file to prompt the user for something.

```
groups:
  - name: "Container Images"
    description: "Image to be used for container"
questions:
  - variable: image
    description: "Docker Image Details"
    group: "Container Images"
    schema:
      type: dict
      required: true
      attrs:
        - variable: repository
          description: "Docker image repository"
          label: "Image repository"
          schema:
            type: string
            required: true
        - variable: tag
          description: "Tag to use for specified image"
          label: "Image Tag"
          schema:
            type: string
            default: "latest"
        - variable: pullPolicy
          description: "Docker Image Pull Policy"
          label: "Image Pull Policy"
          schema:
            type: string
            default: "IfNotPresent"
            enum:
              - value: "IfNotPresent"
                description: "Only pull image if not present on host"
              - value: "Always"
                description: "Always pull image even if present on host"
              - value: "Never"
                description: "Never pull image even if it's not present on host"
```

The above will prompt the user with 2 text fields and a dropdown in the UI getting details for image configuration in a helm chart.
_More information about questions.yaml is available [here](https://wiki.truecharts.org/development/questions-yaml/)_
