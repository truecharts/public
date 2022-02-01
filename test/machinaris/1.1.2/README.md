Machinaris
=====

[MACHINARIS](https://github.com/guydavis/machinaris) is an easy-to-use WebUI for Chia plotting and farming. This includes Chia, Plotman, MadMax, Chiadog under main node along with various coin-forks which can be enabled conditionally.

Coins include Cactus, Chives, CrypoDoge, Flax, Flora, HDDCoin, Maize, NChain, StaiCoin, Stor, BTCGreen and Shibgreen.

Introduction
------------

This chart bootstraps MACHINARIS deployment on a [Kubernetes](http://kubernetes.io) cluster using the [Helm](https://helm.sh) package manager.

# Machinaris Defaults
This section contains information about the defaults of Machinaris application for visibility.

## 1. Environment Variables
Following are the default environment variables for Machinaris main node and the coin forks.

### Machinaris Node
Machinaris main node comes with following default environment variables:

| Variable         | Default Value                                         | Description           |
| ---------------- | ----------------------------------------------------- | --------------------- |
| 	TZ             |  Same as to User selected Timezone                    | Timezone information  |
| 	worker_address |  Same as to LAN IP address                            | Worker Address        |
| 	blockchains    |  chia                                                 | Block Chain            |
| 	plots_dir      |  Same as to User selected plots volume                | Plots Directory       |
| 	mode           |  fullnode                                             | Machinaris Mode       |

These values can be overridden while configuring Machinaris application.

### Coin Forks
Coin forks also come with a set of default environment variables:

| Variable         | Default Value                                         | Description           |
| ---------------- | ----------------------------------------------------- | --------------------- |
| 	TZ             |  Same as to User selected Timezone                    | Timezone information  |
| 	worker_address |  Same as to LAN IP address                            | Worker Address        |
| 	blockchains    |  chia                                                 | BlockChain            |
| 	plots_dir      |  Same as to User selected plots volume                | Plots Directory       |
| 	mode           |  fullnode                                             | Machinaris Mode       |
| 	controller_host|  Same as to LAN IP address                            | Controller Host       |
| 	worker_api_port|  Coin's Workload REST API Port                        | Worker API Port       |

These defaults can be overridden for each coin fork when you enable them through Machinaris application configuration.

## 2. Volumes

Before getting to defaults, please take the following note:
>
>If Custom Host Path is not enabled for a Volume Configuration then, application will use ix-volumes and create datasets inside for Host Path by default.
>
>The path for ix-volumes has the following composition:
>```
>/mnt/<pool_name>/ix-applications/releases/<application_name>/volumes/ix-volumes/
>```
>And with the dataset inside, would be like:
>```
>/mnt/<pool_name>/ix-applications/releases/<application_name>/volumes/ix-volumes/><dataset_name>
>```
>
Following are the Volume Configurations for Machinaris main node & the coin-forks by default:

| Volume                 | hostPath (default value)                              | mountPath in container  |   Description                                   |
| ---------------------- | ----------------------------------------------------- | ----------------------- | ----------------------------------------------- |
| 	`config`             |  `<ix-volumes>/config`                                | `/root/.chia`           | Chia config for main node                       |
| 	`plots`              |  `<ix-volumes>/plots`                                 | `/plots`                | Plots volume for main node & coin forks         |
| 	`plotting`           |  `<ix-volumes>/plotting`                              | `/plotting`             | Plotting temp volume for main node & coin forks |
| 	`<coinName>-config`  |  `<ix-volumes>/<coinName>-config`                     | `/root/.chia`           | Chia config for each of the coin-fork containers|

Where `<ix-volumes>` is `/mnt/<pool_name>/ix-applications/releases/<application_name>/volumes/ix_volumes/` and `<coinName>` is one of the following: `[ cactus, chives, crypodoge, flax, flora, hddcoin, maize, nchain, staicoin, stor, btcgreen, shibgreen ]`.
