---
title: Recovering CNPG Apps after Reboot
---

:::danger

TrueNAS SCALE Apps are considered Deprecated. We heavily recommend using a more mature Kubernetes platform such as "TalosOS" instead, and no longer offer an apps/charts catalogue for SCALE users to install. The below docs exist purely as historical references and may be removed at any time.

:::

Apps with a PostgreSQL database that were updated to the new CNPG common sometimes don't survive a reboot of TrueNAS Scale. The App then hangs on _DEPLOYING_ and pods are in state _Completed_ or _TaintToleration_.

:::caution[Best Effort Policy]

This guide has been written with the best efforts of the staff and tested as best possible. We are not responsible if it doesn't work for every scenario or user situation or if you suffer data loss as a result.
This guide has been tested with TrueNAS SCALE Bluefin 22.12.4.2, Cobia 23.10, CNPG 1.20.2_2.0.3 and HomeAssistant 2023.10.3_20.0.12.

:::

## Symptoms

If you have rebooted and your Apps are hanging on _DEPLOYING_, check if you see pods in state _Completed_ or _TaintToleration_ and the apps main pod in state _Init_ with the
command `k3s kubectl get all -n ix-<app-name>`.

```bash
Examples:

k3s kubectl get all -n ix-home-assistant
NAME                                  READY   STATUS            RESTARTS   AGE
pod/home-assistant-cnpg-main-1        0/1     TaintToleration   0          12h
pod/home-assistant-cnpg-main-2        0/1     TaintToleration   0          12h
pod/home-assistant-85865456d5-tc8h4   0/1     TaintToleration   0          12h
pod/home-assistant-85865456d5-kl96x   0/1     Init:0/2          0          12h

k3s kubectl get all -n ix-home-assistant
NAME                                               READY   STATUS      RESTARTS   AGE
pod/home-assistant-cnpg-main-2                    0/1     Completed   0          22m
pod/home-assistant-cnpg-main-rw-df9bcbccc-s8z2n   0/1     Completed   0          23m
pod/home-assistant-cnpg-main-rw-df9bcbccc-ptltn   0/1     Completed   0          23m
pod/home-assistant-cnpg-main-rw-df9bcbccc-jbbcj   1/1     Running     0          12m
pod/home-assistant-5867d984d9-gfznd               0/1     Completed   0          23m
pod/home-assistant-cnpg-main-1                    0/1     Completed   0          23m
pod/home-assistant-cnpg-main-rw-df9bcbccc-q2w2d   1/1     Running     0          12m
pod/home-assistant-5867d984d9-vcp6x               0/1     Init:0/2    0          12m
```

Logs from the cnpg-wait container in the main app pod show something like this:

```bash
Testing database on url:  home-assistant-cnpg-main-rw
home-assistant-cnpg-main-rw:5432 - no response
```

## Recovery Steps

To recover your app, you need to first stop it ([do not click the _Stop_ button!](/general/faq#how-do-i-stop-a-truecharts-app-truenas-scale-only)), delete the hanging pods and then restart the app.

1. Stop the app either by checking "Stop All" in the app settings or with HeavyScript via the SCALE GUI Shell as below

```bash
heavyscript app --stop <app-name>`
```

2. Wait 2-3min

3. Delete any still hanging pods with the below command

```bash
k3s kubectl delete pods -n ix-<app-name> <pod name>`
e.g. k3s kubectl delete pods -n ix-home-assistant home-assistant-85865456d5-tc8h4
```

4. Start the app either by unchecking "Stop All" in the app settings or with HeavyScript as below

```bash
heavyscript app --start <app-name>
```

5. If you unchecked "Stop All" you might have to click the `Start` button on the GUI (Start is safe, Stop is NOT). There also might be a task that gets stuck in TrueNAS under Jobs (top right). You can get rid of those by restarting the TrueNAS GUI with the below command

```bash
systemctl restart middlewared
```

6. Wait 2-3 minutes

7. Check that the app and all of its pods are running. In the third paragraph there should be no _deployment.apps_ with 0 _AVAILABLE_

```bash
Example:
k3s kubectl get all -n ix-home-assistant`
NAME                                          READY   UP-TO-DATE   AVAILABLE   AGE
deployment.apps/home-assistant-cnpg-main-rw   0/0     0            0           14h
deployment.apps/home-assistant                1/1     1            1           14h
```

8. You can scale them up manually to 1 replica or if it's a cnpg-main-rw pod you might want 2 replicas

```bash
k3s kubectl scale deploy <deployment.apps-name> -n ix-<app-name> --replicas=1
e.g. k3s kubectl scale deploy home-assistant-cnpg-main-rw -n ix-home-assistant --replicas=2
```

**Credit**

Thanks to [Zasx](https://github.com/ZasX) from the [TrueCharts](https://www.truecharts.org) team for the steps used to create this guide.
