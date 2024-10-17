---
title: Talos VM on UnRaid
---

Below are the instructions for creating a Talos VM atop an UnRaid host for use with TrueCharts.

## Downloading Talos

1. Obtain the Talos ISO [here](https://github.com/siderolabs/talos/releases/download/v1.7.0/metal-amd64.iso) by pasting the link into your web browser

2. Once download copy the isos into the `shares folder`

![shares folder](./img/unraid_isos_shares.png)

## Creating the VM

1. Start by clicking the `Add VM` button under the VM Tab

![Add VM](./img/unraid_Add_VM.png)

2. Now click the `Linux` button

![Linux](./img/unraid_linux.png)

3. Supply a name for your new VM

4. Edit memory to supply at least a minimum memory value of 8192 with the recommended value being 16384 Megabytes or more

5. Select the OS install ISO by selecting the Talos ISO we download before

[Talos ISO image](./img/unraid_talos_iso_image.png)

6. Set the `disk space` to 500GB or 1000GB. Keep the remainder as the default.

![disk space](./img/unraid_disk_space.png)

7. Once the VM has been created, select the VM and then settings

![settings](./img/unraid_disk_space.png)

8. For the `Network Source` section virbr0:

![Network Source](./img/unraid_network.png)

9. Now click `Create`
