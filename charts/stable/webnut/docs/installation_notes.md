---
title: Installation Notes
---

:::tip

This chart requires ingress without it you will NOT be able to access the webGUI.

:::

## Prerequisite

In order to get started, plug in your UPS via USB to the `server` node and before modifying the `UPS service` section.

Go to your system shell on your node and run the following command to get the basic info for your UPS.

```shell
nut-scanner -U
```

![nut-scanner](./img/nut-scanner.png)

My UPS uses the `usbhid-ups` driver from `driver = "usbhid-ups"`.

For me though _my_ UPS is _not_ listed in the list, however NUT states you can use others devices of similar models from the same manufacturer as long as its uses the same driver.

![ups-server](./img/ups-server.png)

You can change the `Monitor User` to whatever you want, I kept it default for simplicity.

I highly recommend securing the `Monitor Password` with a lengthy password. Special characters do work, but only tested a few.

The `UPS Mode` should be set to `Master` which means its the server and _not_ the client.

The `port or hosthame` can be just left at `auto`.

![ups-shutdown](./img/ups-shutdown.png)

Please set an actual shutdown command, all this will do is echo `shutdown` in the console.

![ups-other](./img/ups-other.png)

For `Auxiliary Parameters` this is what I used:

```text
LISTEN 127.0.0.1 3493
LISTEN 0.0.0.0 3493
```

## WebNUT Deployment of the Chart

Configure via environment variables
- Set `UPS_HOST` to the local IP of your server.
- Set `UPS_PORT` to `3493` which is typically the default port.
- Set `UPS_USER` to the username defined for the `Monitor User`.
- Set `UPS_PASSWORD` to the password defined for the `Monitor Password`.

In order to access the webGUI, you will **need** to add `ingress` otherwise it will refuse to connect.

```yaml
workload:
  main:
    podSpec:
      containers:
        main:
          env:
            UPS_HOST: "127.0.0.1"
            UPS_PORT: 3493
            UPS_USER: monuser
            UPS_PASSWORD: secret
```

In order to access the webGUI, you will **need** to add `ingress` otherwise it will refuse to connect.

:::tip

You can also reach us using Discord for real-time feedback and support
If you found a bug in our chart, open a Github issue but generally it's advised to contact us on Discord first in most cases.

:::
