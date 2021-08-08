# Values.yaml Files

Values.yaml files generally always contain configuration setting for Helm charts, TrueCharts is no different.
However, we have multiple different values.yaml files, with different goals. Because TrueNAS SCALE just works slightly differently from standard Helm Charts

### The Files

##### values.yaml

This file contains the default config when running the App using stock helm (not SCALE). It also gets used for the testingsuite.

##### ix_values.yaml

This file contains config values that are not included in questions.yaml, but should be copied into the resulting configuration anyway. It's mostly used to ensure setting can be changed by the maintainer with every update, such as versions, which is not possible when setting things as defaults inside questions.yaml

This file is, however, not very well checked by validation and CI. Use it when you absolutely have to.

One important setting in ix_values.yaml is the optional setting: `startAsRoot: true`
This setting is a compatibility toggle for containers that need to be started by root, often these containers use PUID and PGID to descalate (lower) away from root but require it to start.

A minimal example ix_values.yaml would be:

```
##
# This file contains Values.yaml content that gets added to the output of questions.yaml
# It's ONLY meant for content that the user is NOT expected to change.
# Example: Everything under "image" is not included in questions.yaml but is included here.
##

image:
  repository: jacobalberty/unifi
  tag: 6.0.45
  pullPolicy: IfNotPresent


##
# Most other defaults are set in questions.yaml
# For other options please refer to the wiki, default_values.yaml or the common library chart
##

```
