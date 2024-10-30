---
sidebar:
  order: 3
title: Getting Started
---

:::caution[Work In Progress]

This program, all its features and its general design, are all a Work-In-Progress. It is not done and not widely available.

All code and docs are considered Pre-Beta drafts

:::

### (Optional) Create a Git Repository to store your config

With our new ClusterTool, we started for fully embrace Infrastructure-as-Code.
This means all configs can, safely, be saved towards a (public *or* private) GIT repository for processing, testing and safekeeping!

For this reason we also include integrated SOPS Encryption, Decryption and an automated encryption-check.

All things considered, we would advise users to prepare their repository beforehand by following:

- [Create a repository](https://docs.github.com/en/repositories/creating-and-managing-repositories/quickstart-for-repositories)
- [Setup GIT](https://docs.github.com/en/get-started/getting-started-with-git/set-up-git)
- [Cloning a Repository](https://docs.github.com/en/repositories/creating-and-managing-repositories/cloning-a-repository)

Besides these basic getting-started steps, we would also advise users to have already followed [this](https://docs.github.com/en/authentication/keeping-your-account-and-data-secure/managing-your-personal-access-tokens#creating-a-personal-access-token-classic). We also would advise users to save this token somewhere secure until needed.

## Prepare your Config

Let's get started!

Make sure you either have a new empty folder open that is going to contain all your cluster configuration *or* the previously made, and cloned, github repo.
From this step forward, we're going to assume a github repo. If you're starting with a local folder, that's perfectly fine, however some steps need to be skipped.

### Downloading ClusterTool

ClusterTool is available on [GitHub](https://github.com/truecharts/public/releases). Please extract the archive and copy the executable into your `configuration folder`.

### Initialisation

First off we need to generate all file and folder structure for us to store any configuration.

For this, in a terminal, run:

`ClusterTool init`

or, on Windows:

`ClusterTool.exe init`

This builds all config files and folders.

### Save your encryption key

This step also will have generated a file called `age.agekey`. This file contains your encryption key and will, as such, **not** be saved to your github repository.

It's **absolutely crucial** you save this file somewhere safe and preferably have multiple copies in safe places. Not saving this file can and **will** lead to loss of your config.

## Configuration

Thanks to our use of TalHelper, a streamlined Talos configuration tool, there are only two files that contain all our configuration for Talos:

- `clusters/main/clusterenv.yaml`
- `clusters/main/talos/talconfig.yaml`


### ClusterEnv

This file that contains the most important settings, its content also gets saved on the cluster for use with FluxCD and its settings get referenced in multiple places.
You're free to add settings as you please, or as you need them. Feel free to adapt them if needed!

Primary settings that **need** to be adapted:

- `MASTER1IP`: The static-DHCP IP that was set during the TalosOS network configuration
- `VIP`: Contains the shared IP for all master-nodes
- `METALLB_RANGE`: Contains the range MetalLB will allow IPs to be distributed in *(cannot overlap with any nodeIP or VIP, nor should it overlap with local dhcp range)*
- `DASHBOARD_IP`: The IP, within the MetalLB range, that the kubernetes monitoring/management dashboard will be made available on *(should be a free ip adres on your network, not overlapping with dhcp adresses)*

#### (optional) Enabling FluxCD Bootstrapping

If you want to setup FluxCD during bootstrap, be sure to enter a `GITHUB_REPOSITORY` in `ClusterEnv.yaml`.
It should start with `ssh://`, so be sure to pick the SSH repository url option when copying your repository url from GitHub

### TalConfig

This file contains purely the structure of the Talos Cluster and its nodes themselves. As such, it also contains a number of `${VARIABLE}` references to `clusterenv.yaml`. These should **not** be removed.

We generate an opinionated variant of this file, that is optimised to run with our default setup. *Making any changes outside of the nodes section, might completely break ClusterTool*

We would advise to adapt the nodes so they fit your cluster design. By default we've a single node, with a single disk and a single network interface added. This is sufficient for all our VM guides and will be enabled for both 'controlplane', controlling the cluster itself, as well as 'worker' workloads.

For more information on talconfig.yaml and talhelper, please see [here](https://budimanjojo.github.io/talhelper/latest/)

## (optional) Setting Up Github SSH access for FluxCD

If you want to use FluxCD, you need to add the SSH public key defined in `./ssh-public-key.txt`, to your Github Account.

For More info, see:
https://docs.github.com/en/authentication/connecting-to-github-with-ssh/adding-a-new-ssh-key-to-your-github-account

## Generating ClusterConfig and updating files from Config

:::caution[Compatibility]

While our genconfig *can* generate a clusterconfig, that can get applied 'out of the box' through TalosCTL. By default, our `talconfig.yaml` is completely designed around our ClusterTool expected defaults.

Hence these cannot be expected to work directly through TalosCTL.

:::

Clusterconfig are the files Talos itself sends to the nodes and uses to connect to the nodes. To create these files, which are not saved to git by default, from the config you created earlier, please run:

In a terminal, run:

`ClusterTool genconfig`

or, on Windows:

`ClusterTool.exe genconfig`

This also will update a number of files we (pre)generate for FluxCD and/or prepare to be uploaded to the cluster. This includes things like the CNI (Cilium and MetalLB).

### Saving your config

To save your config, it's important to first ensure none of your secrets leak out, by encrypting all confidential settings.

For this, in a terminal, run:

`ClusterTool encrypt`

or, on Windows:

`ClusterTool.exe encrypt`

It's important to note that from this point onwards, some settings might be hidden behind encryption text. You can still safely alter anything else, but to access these settings again, please follow the below:

In a terminal, run:

`ClusterTool decrypt`

or, on Windows:

`ClusterTool.exe decrypt`

To be 100% sure encryption worked out correctly, you can always check for the encryption status by running:

In a terminal, run:

`ClusterTool checkcrypt`

or, on Windows:

`ClusterTool.exe checkcrypt`

We **highly** advise to always run `checkcrypt` before sending data to git.

To send the data to git run:

- `git add *`
- `git commit -a -m "some description"`
- `git push`

## Bootstrapping your first node

To ensure stability, we will first apply the configuration to the first ControlPlane node in the list and bootstrap this node.

For this, in a terminal, run:

`ClusterTool apply`

or, on Windows:

`ClusterTool.exe apply`

You will be asked if you want to bootstrap the cluster, to do this enter `y` or `yes`
After this is finished successfully, make sure the node is running correctly. It should have everything loaded already.

## Applying config to the rest of your cluster

Now we can continue to add more nodes to the cluster. This is completely automated, we can apply the configuration to every node in the cluster, new or existing, by simply running:

In a terminal, run:

`ClusterTool apply`

or, on Windows:

`ClusterTool.exe apply`
