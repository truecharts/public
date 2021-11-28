# 05 - Upgrading, Rollback and Delete

With TrueCharts we always push new versions of an App for any change. Even for the containers.
This ensures upgrading the App always gives you the Latest-and-Greatest from TrueCharts

##### Requirements

- Make sure your storage-pool is created and working
- Make Make sure you selected your storage-pool when you first opened the "Apps" interface, if not please refer to quick-start guide `01 - First time Apps setup`
- Make sure you have a working internet connection and can reach github and truecharts.org from the host system.
- Make sure you already added the TrueCharts catalog from guide 02
- Make sure your App is installed and, preferably, working

## Upgrading

##### Upgrading the App  using the GUI

- Go to `Installed Applications`
- Make sure your App reports that an Upgrade is available on the App Card.
- Make note of the current version, you might want to revert to this version in the future.
- click the menu button on the right side of the App card
- Select `Upgrade`
- Confirm your wish to upgrade

The App will then go through a process of backuping(!) and upgrading your App your changes. If the proces fails, your changes will not be submitted and the edit will be reverted.
After the process popup disapears, it might take a few minutes to actually deploy your newly upgraded App, due to some things that happen in the background.


## Rollback

### Reverting using the GUI


### Reverting using the CLI

1. enter cli to enter the SCALE command line interface
2. enter app chart_release rollback
It should give you this screen:
<a href="https://truecharts.org/_static/img/rollback/cli-rollback1.png"><img src="https://truecharts.org/_static/img/rollback/cli-rollback1.png" width="100%"/></a>
3. Enter the release name and item_version like this:
<a href="https://truecharts.org/_static/img/rollback/cli-rollback2.png"><img src="https://truecharts.org/_static/img/rollback/cli-rollback2.png" width="100%"/></a>
(be sure to remove the # before the releasename)
4. Click save then click quit
It should show something like this, confirming the rollback:
<a href="https://truecharts.org/_static/img/rollback/cli-rollback3.png"><img src="https://truecharts.org/_static/img/rollback/cli-rollback3.png" width="100%"/></a>

### Finding the last installed version

Sadly enough, SCALE does not lists which versions are available to roll-back to, but does required a version to be entered.
There is a short walk-through to get the versioning history for the App in question:

1. run export KUBECONFIG=/etc/rancher/k3s/k3s.yaml
2. run  helm history jackett -n ix-jackett where "jackett" should be replaced with the name of the App that broke your UI
You'll see this:
<a href="https://truecharts.org/_static/img/rollback/history.png"><img src="https://truecharts.org/_static/img/rollback/history.png" width="100%"/></a>
Take note of the "Chart" column, it lists the version numbers you can enter in the rollback interface, prefixed by the App Name.
Ofcoarse only enter the version number in the GUI or CLI, not the name

## Delete

### Delete using the GUI


### Delete using the CLI


#### Video Guide

![type:video](https://www.youtube.com/embed/fs9Psx626Gs)
