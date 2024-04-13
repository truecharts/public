---
title: Important Notes
---

## Credentials

On first run, cloudreve will generate an admin user and print the email and password to the app logs. It will look something like this:

```
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

To retrieve the password in TrueNAS SCALE, wait for the app to finish deploying and then navigate to the `Workload` card and click the `View Logs` icon.

## Aria2

To use cloudreve with aria2, install the [TrueCharts aria2 app](/charts/stable/aria2/). The installation dialog will ask for a RPC Secret, which should be a securely generated string that will be copied to cloudreve later. See below for an example.

Once aria2 is installed, open cloudreve's webpage and navigate to the Dashboard (Click on profile icon in top right corner -> Dashboard). In the dashboard, select `Nodes` and then click the edit icon beside `Master (Local Machine)`. In the edit dialog, click `Enable` and then fill out the settings:

- RPC Server: find with `heavyscript dns`, and read about internal DNS [here](/manual/SCALE/guides/linking-apps/).
- RPC Secret: Set the shared secret here. Must also be set in the Aria2 app.
- Absolute Path: Set this to a custom persistent mount that you've created for this cloudreve app, and have also mounted to Aria2.

### Example RPC Secrete Generation

Below is an example of one way to generate the RPC Secret value. If you do not have a computer with openssl installed, you can use the shell (`System Settings` -> `Shell`) in TrueNAS SCALE. Copy the resulting value by highlighting it and pressing `Ctrl+Insert`.

```
$ openssl rand -hex 32
```
