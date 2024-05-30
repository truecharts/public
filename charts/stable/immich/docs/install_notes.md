---
title: Install Notes
---

## Warning

Immich is essentially pre-alpha, it works but its releases are extremely unrelyable while not complying to semver at all.
This means that Immich might randomly and unexpectedly stop working or loose data.

That goes for every way you deploy it: There be dragons.
You're warned. have fun!

##

This chart now requires the following hcarts to be installed before you can install:

- prometheus-operator
- cloudnative-pg

These are in the system train.

To enable this in TrueNAS scale

- Apps
- Manage Catalogs.
- Edit the TrueCharts Catalog (under the three dots).
- Enable the system train under 'Perferred Trains'.
- Install the required charts in Available Applications
