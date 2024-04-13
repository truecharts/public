---
title: Nvidia Device Plugin Setup
---

# Talos Linux Setup

## Enable NVIDIA kernel modules

Before installing the device plugin, some initial steps need to be taken per
[Talos Documentation][1]. Please make sure you have installed the correct system
extensions through a combination of patches + the correct [factory image][2] for your
use case.

example gpu-worker-patch.yaml

```yaml
machine:
  kernel:
    modules:
      - name: nvidia
      - name: nvidia_uvm
      - name: nvidia_drm
      - name: nvidia_modeset
  sysctls:
    net.core.bpf_jit_harden: 1
```

### Quick Sanity Check

If running these commands does not produce similar output, you haven't set up base
system completely:

```
❯ talosctl read /proc/modules
nvidia_uvm 1482752 - - Live 0xffffffffc3b4e000 (PO)
nvidia_drm 73728 - - Live 0xffffffffc3b3b000 (PO)
nvidia_modeset 1290240 - - Live 0xffffffffc39dc000 (PO)
nvidia 56602624 - - Live 0xffffffffc03e0000 (PO)

❯ talosctl get extensions
NODE            NAMESPACE   TYPE              ID            VERSION   NAME                       VERSION
192.168.2.104   runtime     ExtensionStatus   0             1         nonfree-kmod-nvidia        535.129.03-v1.6.7
192.168.2.104   runtime     ExtensionStatus   2             1         nvidia-container-toolkit   535.129.03-v1.13.5
192.168.2.104   runtime     ExtensionStatus   4             1         schematic                  a22f54cdf137d9d058e9a399adecf4bab2f3cc74b15b5bee00005811433e06b0
192.168.2.104   runtime     ExtensionStatus   modules.dep   1         modules.dep                6.1.82-talos
```

## Create NVIDIA runtime class:

You will need to add this runtime class to pods you wish to add GPU resources to.

```
❯ cat <<EOF | kubectl apply -f -
apiVersion: node.k8s.io/v1
kind: RuntimeClass
metadata:
  name: nvidia
handler: nvidia
EOF
```

### Adding runtimeClass to pods with common

```yaml
workload:
  main:
    podSpec:
      runtimeClassName: "nvidia"
      containers: ...
```

## Create nvidia-device-plugin namespace & enable privileged podsecurity

_Note: This is only required if you want multiple GPU resources per physical GPU. If you are happy with 1 to 1 GPU to POD mapping, you can just create namespace, it won't need privileges. You will need to turn off a setting below._

```
❯ kubectl create namespace nvidia-device-plugin
❯ kubectl label namespace nvidia-device-plugin pod-security.kubernetes.io/enforce=privileged
```

## Install nvidia-device-plugin from kubeapps

There are notes in values.yaml, but the following defines how many resources are made per GPU:

```yaml
resources:
  - name: nvidia.com/gpu
    replicas: 5
```

_Note: If you do not want multigpu mapping, set replicas to 1 and change the following line to false._

```yaml
gfd:
  enabled: true
```

### Enable GPU in values.yaml

```yaml
resources:
  limits:
    nvidia.com/gpu: 1
```

[1]: https://www.talos.dev/v1.6/talos-guides/configuration/nvidia-gpu-proprietary/
[2]: https://factory.talos.dev
