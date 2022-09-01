# Installation Guide

## Userdata Dataset

This is the optional location your Nextcloud userdata will be located

> You do NOT need to create a dataset if you do not plan on using one. Nextcloud does not require one, instead you can rely on the PVC default

??? Note "Note"
The `apps`:`apps` user:group is built into Truenas SCALE, it is the default user for most applications on Truenas SCALE. You do not have to create a separate user for each application.

    When configuring your application you'll typically see user:group `568`, this is the UID for `apps` and its recommended not to change it.

- You are REQUIRED to use the `www-data` group and setting the permissions exactly, If you have anything different, chances are it will not work
- ACL's are known to cause problems with the Nextcloud Userdata folder, we advice you not to use them.

![!Dataset: Nextcloud](images/dataset.png)

## App Setup

For this application We used the `Nextcloud` provided by [TrueCharts](https://truecharts.org/manual/Quick-Start%20Guides/01-Adding-TrueCharts/).

- Available under the `stable` train

![!Container: Tube](images/nextcloud.png)

<br />

### Container

**Application Name**

```
nextcloud
```

Name it whatever you want, We stick with the chart name for now

**NEXTCLOUD_ADMIN_USER (First Install Only)**

```
USERNAME
```

> This is up to you

<br />

**NEXTCLOUD_ADMIN_PASSWORD (First Install Only)**

```
PASSWORD
```

> This is up to you

<br />
<br />

### Storage

> This is an optional step, if you did not create a separate dataset, you can skip this

1. Ensure you are under `UserData Storage`
2. `Type of Storage` should be `Hostpath (simple)`
3. `Hostpath` should be the path to the dataset you created

![!Container: Env_Var](images/storage.png)

<br />
<br />

### Ingress

> This is another optional step, if you never plan on using ingress, you can skip this.

<br />

1. Configure Hosts > Add
2. Configure Paths > Add
3. Type your hostname under `HostName`

![!Container: Ingres](images/ingress1.png)

<br />

1. Configure TLS-Settings > Add
2. Configure Certificate Hosts > Add
3. Type your hostname under `HostName`
4. Select your correct cert

> We do not add any middlewares, since Nextcloud has its own authentication, and adding middlewares breaks phone backups, since it has no way to authenticate through Authelia

![!Container: Ingres](images/ingress2.png)

<br />
