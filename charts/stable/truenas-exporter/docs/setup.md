---
title: Connecting TrueNAS SCALE
---

TrueNAS Scale
Inside of TrueNAS you have to open the `Reporting` tab and then click the `Exporters` button to adjust the already present graphite exporter by hitting the edit icon.
Once in the edit view you have to adjust three fields to match your later desired metrics.

The `prefix` for the graphite metrics need to be set to `truenas` for the mapping file to work
The `hostname` field should be choosen according to your needs it will later populate the instance label of your metrics
The `update` every field should match your scrape time. This is set to `5` by default
