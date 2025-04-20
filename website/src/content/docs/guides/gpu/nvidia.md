---
title: Nvidia-GPU
---

:::caution[Charts]

Adding a GPU to your Cluster isn't covered by the Support Policy.
Feel free to open a thread in the appropiate Channel in our Discord server.

:::

## Prerequisites

- Having your GPU isolated
- Passed the GPU to your Talos Machine

## Extensions

:::caution[Charts]

This guide assumes you are using Clustertool for your talos cluster. The steps may differ otherwise.

:::

Its important to add the following Extensions to your `talconfig.yaml` for bootstrap:

```yaml

schematic:
    customization:
        systemExtensions:
            officialExtensions:
                - siderolabs/nonfree-kmod-nvidia-lts
                - siderolabs/nvidia-container-toolkit-lts

```

## GPU Talos Patch

Additionally, you will need to add the `nvidia.yaml` patch shipped by clustertool to your `talconfig.yaml`
This patch file then needs to be added to the `talconfig.yaml`. The placement of this line would be in relation to where your GPU exists.
More than likely it would be placed under a specific node:

```yaml

patches:
    - "@./patches/nvidia.yaml"

```

Example:

```yaml
nodes:
    # We would adivce to always stick to a "k8s-something-1" style naming scheme
    - hostname: k8s-control-1
      ipAddress: ${MASTER1IP_IP}
      controlPlane: true
      schematic:
        customization:
          systemExtensions:
            officialExtensions:
              - siderolabs/nonfree-kmod-nvidia-lts
              - siderolabs/nvidia-container-toolkit-lts
      ### Note the placement of the gpu patch reference ###
      patches:
        - "@./patches/nvidia.yaml"
```

## Adding it to your cluster

If its a fresh bootstrap you can simply follow the clustertool guide on how to bootstrap your cluster.
If it is a existing cluster you will need to run `clustertool talos upgrade` to add the extensions and `clustertool talos apply` to add the patch.

## Testing

Run the following commands and see if the shown outputs are included in your command-output:

### Check the Modules

```bash
talosctl read /proc/modules
```

Output (the numbers and hex values may be different):

```bash
nvidia_uvm 1884160 - - Live 0xffffffffc3f79000 (PO)
nvidia_drm 94208 - - Live 0xffffffffc42f6000 (PO)
nvidia_modeset 1531904 - - Live 0xffffffffc4159000 (PO)
nvidia 62754816 - - Live 0xffffffffc039e000 (PO)
```

### Check the Extensions

```bash
talosctl get extensions
```

Output (the numbers and hex values may be different):

```bash
192.168.178.9   runtime     ExtensionStatus   3             1         nonfree-kmod-nvidia-lts        535.183.06-v1.8.4
192.168.178.9   runtime     ExtensionStatus   4             1         nvidia-container-toolkit-lts   535.183.06-v1.16.1
```

### Read Driver Version

```bash
talosctl read /proc/driver/nvidia/version
```

Output (the numbers and hex values may be different):

```bash
NVRM version: NVIDIA UNIX x86_64 Kernel Module  535.183.06  Wed Jun 26 06:46:07 UTC 2024
GCC version:  gcc version 13.3.0 (GCC)
```

### Testing the GPU

```bash
kubectl run \
  nvidia-test \
  --restart=Never \
  -ti --rm \
  --image nvcr.io/nvidia/cuda:12.1.0-base-ubuntu22.04 \
  --overrides '{"spec": {"runtimeClassName": "nvidia"}}' \
  nvidia-smi
```

Output (The Warning about PodSecurity can be ignored):

```bash
Mon Dec 16 12:54:35 2024
+---------------------------------------------------------------------------------------+
| NVIDIA-SMI 535.183.06             Driver Version: 535.183.06   CUDA Version: 12.2     |
|-----------------------------------------+----------------------+----------------------+
| GPU  Name                 Persistence-M | Bus-Id        Disp.A | Volatile Uncorr. ECC |
| Fan  Temp   Perf          Pwr:Usage/Cap |         Memory-Usage | GPU-Util  Compute M. |
|                                         |                      |               MIG M. |
|=========================================+======================+======================|
|   0  NVIDIA GeForce GTX 1660 ...    On  | 00000000:00:0A.0 Off |                  N/A |
| 24%   26C    P8               5W / 125W |      1MiB /  6144MiB |      0%      Default |
|                                         |                      |                  N/A |
+-----------------------------------------+----------------------+----------------------+

+---------------------------------------------------------------------------------------+
| Processes:                                                                            |
|  GPU   GI   CI        PID   Type   Process name                            GPU Memory |
|        ID   ID                                                             Usage      |
|=======================================================================================|
|  No running processes found                                                           |
+---------------------------------------------------------------------------------------+
pod "nvidia-test" deleted
```

## Nvidia-Device-Plugin

If all of the previous tests where successfull. Your GPU is ready to be used with the Nvidia-Device-Plugin.
An example `helm-release.yaml` can be seen below:

```yaml
apiVersion: helm.toolkit.fluxcd.io/v2
kind: HelmRelease
metadata:
    name: nvidia-device-plugin
    namespace: nvidia-device-plugin
spec:
    interval: 5m
    chart:
        spec:
            chart: nvidia-device-plugin
            version:  0.17.1
            sourceRef:
                kind: HelmRepository
                name: home-ops-mirror
                namespace: flux-system
            interval: 5m
    install:
        createNamespace: true
        crds: CreateReplace
        remediation:
            retries: 3
    upgrade:
        crds: CreateReplace
        remediation:
            retries: 3
    values:
      image:
        repository: nvcr.io/nvidia/k8s-device-plugin
        tag: v0.17.0
      runtimeClassName: nvidia
      config:
        map:
          default: |-
            version: v1
            flags:
              migStrategy: none
            sharing:
              timeSlicing:
                renameByDefault: false
                failRequestsGreaterThanOne: false
                resources:
                  - name: nvidia.com/gpu
                    replicas: 5
      gfd:
        enabled: true
```

Don't forget to add the required repository `nvdp.yaml` into the `repositories/helm` folder and adding it to the required `kustomization.yaml`:

```yaml
---
# yaml-language-server: $schema=https://kubernetes-schemas.pages.dev/source.toolkit.fluxcd.io/helmrepository_v1.json
apiVersion: source.toolkit.fluxcd.io/v1
kind: HelmRepository
metadata:
  name: home-ops-mirror
  namespace: flux-system
spec:
  type: oci
  interval: 2h
  url: oci://ghcr.io/home-operations/charts-mirror

```

## Example of GPU Assignment

The following shows an example on how to add the GPU to a chart. Depending on the chart you may need to adapt the workload-name.

```yaml
resources:
    limits:
      nvidia.com/gpu: 1
workload:
    main:
      podSpec:
        runtimeClassName: "nvidia"
```

If you followed this guide the GPU can be assigned up to 5 different charts.
The number `1` will always be the same and wont be increased for a second chart with gpu usage.

## Troubleshooting

If all the Extensions, Modules and the Driver Version is there but the GPU-Testing shows something similar to:

```bash
failed to create containerd task: failed to create shim task: OCI runtime create failed: runc create failed: unable to start container process: error during container init: error running prestart hook #0: exit status 1, stdout: , stderr: Auto-detected mode as 'legacy'
nvidia-container-cli: mount error: failed to add device rules: unable to generate new device filter program from existing programs: unable to create new device filters program: load program: invalid argument: last insn is not an exit or jmp
processed 0 insns (limit 1000000) max_states_per_insn 0 total_states 0 peak_states 0 mark_read 0
```

Then the patch wasnt addded properly. This can be fixed by manually adding the patch with the following command:

```bash
talosctl patch mc --patch @gpu.yaml
```

This should fix the error and should display the desired output
