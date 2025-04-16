---
title: System Requirements
sidebar:
  order: 3
---

Below are our recommended and supported system requirements for running TrueCharts Charts inside either a VM or bare-metal machine

See [below](/general/systemrequirements/#best-effort-cpu-recommendations) for additional information.

## Recommended System Specifications for Master-only Nodes

Systems complying with these specifications are suitable for deployment as a master node only, and as such, have lower requirements than those used further down the page. This allows for deployment on platforms that are much more compute-starved.

**CPU:** 4 *Physical* Cores, suitable for deployment on ARM environments such as a Raspberry Pi v4, v5, etc.

**RAM:** 8GB, preferably 16GB or more

**Storage:** SSD or alternatively a high-end, write-durable SD card such as a Samsung Pro Plus or Pro Ultimate, SanDisk Extreme Pro or High/Max Endurance and equivalents.


## Minimum System Specifications

Systems complying with these minimum specifications will be able to run **some** of our apps and may be limited to just a few at the same time. Experiences in terms of performance and which apps work may vary.

**CPU:** 6 *Physical* Cores of AMD Ryzen or Intel 8th Gen Core or better families

* for VMs: dedicated 1 Core (2 Threads) remaining for the host system, e.g. SCALE or Proxmox

**RAM:** 16GB or more

**GPU:** None

**Disk Storage:** enterprise-grade SSD of 500Gb

*The disk has to be either an enterprise-grade SSD (preferably NVMe) or a sparsely allocated ZFS zvol/dataset with sync set to *disabled*


### Example Minimum Spec System

**CPU:** AMD Ryzen 3600 or Intel Core i7 8700

**RAM:** 32GB

**VM Disk Storage:** 1TB SSD

**GPU:** Intel iGPU

## Recommended System Specifications

Systems complying with these recommended specifications will likely be able to run any Chart we offer, and likely many at the same time, depending on system load and the specific Charts in deployment.

**CPU:** 7+ *Physical* Cores of AMD Ryzen or Intel 8th Gen Core or better families

* for VMs: dedicated 1 Core (2 Threads) remaining for the host system, e.g. SCALE or Proxmox

**RAM:** 48GB or more

**GPU:** Intel iGPU, or dedicated Nvidia GPU (AMD GPUs **may** work but are not guaranteed)

**VM Disk Storage:** enterprise-grade SSD of 1TB

*The disk has to be either an enterprise-grade SSD (preferably NVMe) or a sparsely allocated ZFS zvol/dataset with sync set to *disabled*

### Example Recommended Spec System

**CPU:** AMD Ryzen 5700X

**RAM:** 64GB

**VM Disk Storage:** 1TB SSD

**GPU:** Dedicated Nvidia GPU

## Notes

### VM Creation Instructions

You can find the VM install instructions [here](https://truecharts.org/clustertool/virtual-machines/truenas-scale/)

### Best Effort CPU Recommendations

We obviously cannot account for all possible system configurations on the planet. Please use some common sense when determining if your hardware may or may not be suitable for running a Talos VM for our apps. Aside from our below recommendations, the most generic advice we can give is to use a CPU that is at least of the [x86-64 v3 baseline](https://en.wikipedia.org/wiki/X86-64#Microarchitecture_levels).

These include, but are not limited to

- Intel [Haswell](https://en.wikipedia.org/wiki/Haswell_(microarchitecture)#List_of_Haswell_processors) family CPUs
- Intel [Gracemont](https://en.wikipedia.org/wiki/Gracemont_(microarchitecture)#List_of_Gracemont_processors) family Atom CPUs (specifically only the N300/N305)
- AMD [Ryzen](https://en.wikipedia.org/wiki/List_of_AMD_Ryzen_processors) family CPUs

[Here](https://www.cpubenchmark.net/compare/3099vs3481vs4814/Intel-i7-8700-vs-AMD-Ryzen-5-3600-vs-AMD-Ryzen-7-5700X) is a link to PassMark CPU score comparisons of our minimum and recommended CPUs. You can add your own CPU to the comparison table to determine your equivalent standing. In short, you want **your** CPU to be scoring higher than the minimum.

### RAM Recommendations

16GB of RAM allocated to the Talos VM is a **hard** bare-minimum recommendation by us. Users running a Talos VM with less than 16GB of RAM allocated to it may incur performance issues, and may be excluded from support. RAM requirements for your VM will obviously increase as you deploy more charts.

### Storage Recommendations

An an SSD, HDD+METADATA zfs pool and/or having sync-writes disabled, will greatly improve performance and is assumed to be required.

Sparse allocation is adviced:
For example: A 512GB "sparsely allocated" disk for the Talos VM, housed on a 1TB disk in the host system, will not immediately/always take up 512GB of space. 512GB is the maximum amount of space the file *could* occupy if needed.

### GPU Recommendations

Unfortunately, AMD (i)GPUs continue to be rather lacklustre in the Kubernetes world. AMD GPUs are *supposed* to work under Kubernetes, but suffer limitations such as only being able to be used by 1 app/chart at a time, which makes them hard to recommend.

Nvidia, and to some extent Intel, GPUs by comparison will almost always work "out of the box".
