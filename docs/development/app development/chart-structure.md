# TrueNAS SCALE Chart Structure

A TrueNAS SCALE chart repository differs slightly in directory structure from upstream repos in that it includes an `app version` directory.

A TrueNAS SCALE chart also has three additional files an `app-readme.md` file that provides a high level overview display in the TrueNAS SCALE UI and a `questions.yaml` file defining questions to prompt the user with and an `item.yaml` file outlining item specific details.

There are 2 directories `charts` and `test`, each representing a train. Chart releases created from catalog items in a specific train cannot be moved to another train. Currently only the `charts` train can be used inside the UI.

```
charts/<train>/<chart name>/
  charts/                  # Directory containing dependency charts
  Chart.yaml               # Required Helm chart information file
  README.md                # Optional: Helm Readme file (will be rendered in TrueNAS SCALE UI as well)
  templates/               # A directory of templates that, when combined with values.yml will generate K8s YAML
  values.yaml              # The default configuration values for this chart
```

```
charts/<train>/<chart name>/
  app-readme.md            # TrueNAS SCALE Specific: Readme file for display in TrueNAS SCALE UI
  questions.yaml           # TrueNAS SCALE Specific: File containing questions for TrueNAS SCALE UI
  ix_values.yaml           # Hidden configuration values when installing using TrueNAS SCALE
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

After that create `app-readme.md` file.

```
$ cat charts/<train>/<chart name>/SCALE/app-readme.md

iX-chart is a chart designed to let user deploy a docker image in a TrueNAS SCALE kubernetes cluster.
It provides a mechanism to specify workload type, add external host interfaces in the pods, configure volumes and allocate host resources to the workload.
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
