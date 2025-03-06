---
title: Important Notes
---

## Credentials

On first run, Cloudreve will generate an admin user and print the email and password to the logs. It will look something like this:

```bash
   ___ _                 _
  / __\ | ___  _   _  __| |_ __ _____   _____
 / /  | |/ _ \| | | |/ _  | '__/ _ \ \ / / _ \
/ /___| | (_) | |_| | (_| | | |  __/\ V /  __/
\____/|_|\___/ \__,_|\__,_|_|  \___| \_/ \___|

   V3.8.3  Commit #88409cc  Pro=false
================================================

[Info]    2024-01-22 03:27:02 Initializing database connection...
[Info]    2024-01-22 03:27:02 Start initializing database schema...
[Info]    2024-01-22 03:27:03 Admin user name: admin@cloudreve.org
[Info]    2024-01-22 03:27:03 Admin password: 8vLCPvDl
[Info]    2024-01-22 03:27:06 Start executing database script "UpgradeTo3.4.0".
[Info]    2024-01-22 03:27:06 Finish initializing database schema.
[Info]    2024-01-22 03:27:06 Initialize task queue with WorkerNum = 10
[Info]    2024-01-22 03:27:06 Initialize crontab jobs...
[Info]    2024-01-22 03:27:06 Current running mode: Master.
[Info]    2024-01-22 03:27:06 Listening to ":5212"
```

## Aria2

To use Cloudreve with Aria2, deploy the [TrueCharts Aria2 chart](/charts/stable/aria2/). This chart needs an env. 'RPC_SECRET', which should be a securely generated string that will be copied to Cloudreve later. See below for an example.

Once Aria2 is deployed, open Cloudreve's webpage and navigate to the Dashboard (Click on profile icon in top right corner -> Dashboard). In the Dashboard, select `Nodes` and then click the edit icon beside `Master (Local Machine)`. In the edit dialog, click `Enable` and then fill out the settings:

- RPC Server: Preferred to use Cluster DNS name. Most lickely: 'cloudreve.cloudreve.svc.cluster.local:5212'. More about internal cluster DNS can be found in the common documentation.
- RPC Secret: Set the shared secret here. Must also be set in the Aria2 chart.
- Absolute Path: Set this to a custom persistence mount that you've created for this cloudreve chart and have also mounted to Aria2.

### Example RPC Secrete Generation

Below is an example of one way to generate the RPC Secret value, which can be copy paste in a terminal which have openssl installed.

```
$ openssl rand -hex 32
```
