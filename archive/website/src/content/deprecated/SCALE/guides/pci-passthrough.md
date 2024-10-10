---
title: PCIe Device Passthrough to Apps
---

:::danger

TrueNAS SCALE Apps are considered Deprecated. We heavily recommend using a more mature Kubernetes platform such as "TalosOS" instead, and no longer offer an apps/charts catalogue for SCALE users to install. The below docs exist purely as historical references and may be removed at any time.

:::

To Passthrough your PCI(-E) cards you need to:

1. Go to Installed Applications
2. Click the menu button on the right side of the App card
3. Select Edit
4. Scroll down to "Resources and Devices" Section
5. Under Configure Mount USB devices Click the Add button on the right (This will work for PCI devices too\*)
6. In "Host Device Path" & "Container Device Path" enter the /dev/path for your card (ex: for dvb devices it will be: /dev/dvb)
7. Submit your changes

:::note

This method is not guaranteed to work, and we don't officially offer support for PCI(-E) device passthrough at the moment.

:::
