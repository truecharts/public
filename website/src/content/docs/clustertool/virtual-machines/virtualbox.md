---
title: Talos VM on VirtualBox
---

Below are the instructions for creating a Talos VM inside a VirtualBox host for use with TrueCharts.

## Downloading Talos

Obtain the Talos ISO [here](https://github.com/siderolabs/talos/releases/download/v1.7.0/metal-amd64.iso) by pasting the link into your web browser

## Creating the VM

1. Start by clicking the `New` button in the VirtualBox UI

![new](./img/vb-new-vm.png)

2. Supply a name for your new VM, specifying type and version

![type](./img/vb-nametype.png)

3. Edit memory to supply at least a minimum memory value of `8192` with the recommended value being `16384` Megabytes or more

![memory](./img/vb-memory.png)

4. Set the disk space to `500GB` or `1000GB`. Keep the remainder as the default

5. Once the VM has been created select the VM and then `settings`

![settings](./img/vb-edit-settings.png)

6. In the system section, supply `1` core for the host system with the remainder allocated to the vm i.e. for a six-core CPU select `5`

![cpu](./img/vb-cpu.png)

7. For the `Network` section switch the network `Attached To` section to `Bridged Adapter`

![network](./img/vb-network.png)

8. In the `Storage` section, select the optical drive and on the right, select the ISO you downloaded earlier by browsing your filesystem

![storage](./img/vb-storage.png)

## ClusterTool

By default ClusterTool installs the `qemu-guest-agent` extension. This is not compatible with VirtualBox and should be commented out as shown below in the `talconfig.yaml` file:

```yaml
// talconfig.yaml
controlPlane:
    patches:
        - '@./patches/controlplane.yaml'
        - '@./patches/manifests.yaml'
        # - '@./patches/nvidia.yaml'
    schematic:
        customization:
            extraKernelArgs:
                - net.ifnames=0
            systemExtensions:
                officialExtensions:
                    - siderolabs/iscsi-tools
                    # - siderolabs/qemu-guest-agent
                    # Enable where needed
                    # - siderolabs/amd-ucode
                    # - siderolabs/bnx2-bnx2x
                    # - siderolabs/drbd
                    # - siderolabs/gasket-driver
                    # - siderolabs/i915-ucode
                    # - siderolabs/intel-ucode
                    # - siderolabs/thunderbolt
worker:
    patches:
        - '@./patches/worker.yaml'
        # - '@./patches/nvidia.yaml'
    schematic:
        customization:
            systemExtensions:
                officialExtensions:
                    # Enable where needed
                    # - siderolabs/amd-ucode
                    # - siderolabs/bnx2-bnx2x
                    - siderolabs/iscsi-tools
                    # - siderolabs/qemu-guest-agent
                    # - siderolabs/drbd
                    # - siderolabs/gasket-driver
                    # - siderolabs/i915-ucode
                    # - siderolabs/intel-ucode
                    # - siderolabs/thunderbolt
```
