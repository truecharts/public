# 06 - App Roleback after an update


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


#### Video Guide

![type:video](https://www.youtube.com/embed/FtfF3rs_YEk)
