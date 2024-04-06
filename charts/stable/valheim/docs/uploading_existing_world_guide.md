---
title: Upload Existing Valheim World Guide for TrueNAS SCALE
---

:::info This is a SCALE-specific guide

Please note that this guide is written for SCALE specifically, and instructions may different for alternate platforms.

:::

This is a quick guide using on using CodeServer to upload your existing Valheim world files without having to start / stop the app or mount the apps PVC storage.

:::note[CodeServer Addon Setup]

- Setup Codeserver either during installation or after installation, by editing the app

  - Go to the Add-on section
  - Enable Coderserver
  - Set service type to LoadBalancer
  - Set default port of 36107
  - Save the changes

:::note

  Optionally, setup ingress for the codeserver addon.

:::

- Open Valheim supervisor page. This can be accessed by using {Scale/App IP}:9011 e.g. `192.168.0.2:9011`

- Stop all services, but don’t refresh the page as this may restart all services again

- Locate the world files on your computer, e.g. on Windows they can be found here: `C:\Users\{profileName}\AppData\LocalLow\IronGate\Valheim\worlds_local`

- Open CodeServer using the same Scale / App IP as used above this time with port 3610, {Scale/Apps IP}:36107 e.g. `192.168.0.2:36107`

- Inside CodeServer, go to "config > worlds_local" in the explorer section and drag the files located above into this folder. The files here can be deleted and replaced or overwritten
**NOTE: The names of the files uploaded must match the name of the world that was supplied installing the app**

- Go back to Valheim's supervisor page and start all services again

- Give the server a couple of minutes to restart all services, but once complete your world files should be picked up ready next time you load your server.

With the above instructions, you can also upload more than one world providing they have unique names and you can switch between them just by changing the name of the world when you edit the app. Simply update the value for `Server Name`, this saves having to repeat the above process every time you want to change worlds.
