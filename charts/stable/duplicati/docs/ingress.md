---
title: Ingress
---

This chart requires Ingress to be enabled after initial install due to the configuration of the application upstream (see [Duplicati forum post](https://forum.duplicati.com/t/error-message-in-browser-the-host-header-sent-by-the-client-is-not-allowed/5806)). Please install the application without Ingress, access settings of the application and add your hostname inside the settings of the app.

![image](https://user-images.githubusercontent.com/89483932/174445638-bac32cc8-375f-4fdb-a99f-f8b75a4613e1.png)

Once this is done you can successful add Ingress using the steps outlined inside our [Quick-Start Guide](/manual/SCALE/options/ingress). If you require more help or details please refer to our Discord for help from our Support Staff.
