---
title: Values.yaml
---

Values.yaml files generally always contain configuration setting for Helm charts, TrueCharts is no different.
However, we have multiple different values.yaml files, with different goals. Because TrueNAS SCALE just works slightly differently from standard Helm Charts

## The Files

### values.yaml

This file contains the default config when running the App using stock helm (not SCALE). It also gets used for the testing suite.

A minimal example values.yaml would be:

```yaml
##
# This file contains Values.yaml content that gets added to the output of questions.yaml
# It's ONLY meant for content that the user is NOT expected to change.
# Example: Everything under "image" is not included in questions.yaml but is included here.
##

image:
  repository: docker.io/jacobalberty/unifi
  tag: 6.0.45
  pullPolicy: IfNotPresent

```
