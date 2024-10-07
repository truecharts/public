


### JailMan is a collection of shell scripts designed to make it easier to install all sorts of iocage Jails on FreeNAS.

## Important:
### Jailman as a project has stopped development in favor of [TrueCharts](https://github.com/truecharts/truecharts) for TrueNAS SCALE.

---

[![GitHub last commit](https://img.shields.io/github/last-commit/jailmanager/jailman/dev.svg)](https://github.com/jailmanager/jailman/commits/dev) [![GitHub Release](https://img.shields.io/github/release/jailmanager/jailman.svg)](https://github.com/jailmanager/jailman/releases/latest) [![License: GPL v2](https://img.shields.io/badge/License-GPL%20v2-blue.svg)](https://github.com/jailmanager/jailman/blob/master/docs/LICENSE.GPLV2) [![License](https://img.shields.io/badge/License-BSD%202--Clause-orange.svg)](https://github.com/jailmanager/jailman/blob/master/docs/LICENSE.BSD2)

## Intro

There are a lot of great scripts out there to create all sorts of custom jails on FreeNAS. Sadly enough, they all take their own approach to configuration, which lead to a lot of time wasted configuring all sorts of different scripts.

We do not aim to be some sort of XKCD like "solution to replace all solutions", but aim to simply improve, iterate and integrate the great work others have already put forward.

The goal of this project is to be able to install, update, reinstall, upgrade and delete most of your services by just running a single command using a single config file. While doing this we aim for a "docker like" scenario, where the jail is completely disposable and all configuration is saved outside of the jail.

## Getting started
### Installing
- Get into FreeNAS using the in-gui console or SSH.
Run the following commands to install jailman:
- `git clone https://github.com/jailmanager/jailman.git`
- `cd jailman`
- `cp config.yml.example config.yml`
- edit config.yml to reflect your personal settings (optional, see "use")
- Run one of the commands under "How-To Use"


### Updating
This script includes an autoupdate feature which checks if changes to the script has been posted to github.


## How-To Use
Replace $jailname with the name of the jail you want to install.
For supported jails, please see this readme or config.yml.example

- First: CD into the directory you downloaded jailman into (see above)
example:
`cd /root/jailman`

- Install:
`./jailman.sh -i $jailname`
Example:
`./jailman.sh -i sonarr`

- ReInstall:
`./jailman.sh -r $jailname`
Example:
`./jailman.sh -r sonarr`

- Update:
`./jailman.sh -u $jailname`
Example:
`./jailman.sh -u sonarr`

- Destroy
`./jailman.sh -d $jailname`
Example:
`./jailman.sh -d sonarr`

You can also do multiple jails in one pass:
Example:
`jailman.sh -i sonarr radarr lidarr`

This installs the jail, creates the config dataset if needed, installs all packages and sets them up for you.
Only thing you need to do is do the setup of the packages in their respective GUI.
All settings for the applications inside the jails are persistent across reinstalls, so don't worry reinstalling!

config.yml.example includes basic configuration for all jails.
Basic means: The same setup as a FreeNAS plugin would've, DHCP on bridge0.

### Currently Supported Services

#### General

- organizr
- py-kms
- nextcloud (currently broken, fix ready for 1.3.0)
- bitwarden
- unifi controller

#### Backend
- mariadb
- influxdb

#### Downloads

- transmission
- jackett

#### Media

- plex
- tautulli
- sonarr
- radarr
- lidarr

## Get involved

### Preparing your own copy of JailMan
Getting involved with JailMan and creating your own Jails, is really simple although experience with Bash, BSD and iocage is highly recommended.

- Fork the JailMan Repository and clone your own fork to disk.
- Create a new branch, starting from the dev branch (with all current development changes)
- Open Jailman.sh and `BRANCH="dev"`into your own branch. 

### Making changes
To add a jail, you need 4 things:

- A jailfolder under jails/
- an install script in the jail folder, named `install.sh`
- an update script in the jail folder, named `update.sh`
- an entry in `config.yml` with the name of your jail

All jails created by JailMan start with their own persistant data folder in a seperate dataset, mounted under `/config`.
You can safely use this, or create additional datasets and mount those. 

To make your experience making changes to Jailman as easy as possible, we already made some  convenience functions in global.sh, those are available to your jail install and update scripts from the start!

But above all: Have fun building it!

## LICENCE
This work is dual licenced under GPLv2 and BSD-2 clause

### Sub-Licences
Some sub-modules available under "jails" might be licenced under a different licence.
Please be aware of this and take note of any LICENCE files signaling a differently licenced sub-module.


---
![built-with-resentment](http://forthebadge.com/images/badges/built-with-resentment.svg)       ![contains-technical-debt](http://forthebadge.com/images/badges/contains-technical-debt.svg)
