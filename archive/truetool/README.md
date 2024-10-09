# truetool

An easy tool for frequently used TrueNAS SCALE CLI utilities.

Please before using this tool, [read this note](https://truecharts.org/manual/guides/Important-MUST-READ)

## Table of contents:

* [Synopsis](#synopsis)
* [Arguments](#arguments)
* [How to Install](#how-to-install)
* [How to Update](#how-to-update)
* [Creating a Cron Job](#creating-a-cron-job)
* [Additional Information](#additional-information)

<br>

## Synopsis

TrueTool is a command line tool, designed to enable some features of TrueNAS SCALE that are either not-enabled by default or not-available in the Web-GUI.
It also offers a few handy shortcuts for commonly required chores, like: Enabling Apt or Helm

## Arguments

| Flag            | Example                | Parameter | Description                                                                                                                                                                                                                |
| --------------- | ---------------------- | --------- | -------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| --delete-backup | --delete-backup        | None      | Opens a menu to delete backups<br>_Useful if you need to delete old system backups or backups from other scripts_                                                                                                          |
| --restore       | --restore              | None      | Restore TrueTool specific `ix-applications dataset` snapshot                                                                                                                                                               |
| --mount         | --mount                | None      | Initiates mounting feature<br>Choose between unmounting and mounting PVC data                                                                                                                                              |
| --dns           | --dns                  | None      | list all of your applications DNS names and their web ports                                                                                                                                                                |
| --list-backups  | --list-backups         | None      | Prints a list of backups available                                                                                                                                                                                         |
| --helm-enable   | --helm-enable          | None      | Enables Helm command access on SCALE                                                                                                                                                                                       |
| --kubeapi-enable   | --kubeapi-enable          | None      | Enables external access to Kuberntes API port                                                                                                                                                                               |
| --apt-enable    | --apt-enable           | None      | Enables Apt command access on SCALE                                                                                                                                                                                        |
| --no-color      | --no-color             | None      | (deprecated) Disables showing colors in terminal output, usefull for SCALE Email output                                                                                                                                                 |
| -U              | -U                     | None      | Update applications, ignoring major version changes                                                                                                                                                                        |
| -u              | -u                     | None      | Update applications, do NOT update if there was a major version change                                                                                                                                                     |
| -b              | -b 14                  | Integer   | Backup `ix-applications` dataset<br>_Creates backups up to the number you've chosen_                                                                                                                                       |
| -i              | -i nextcloud -i sonarr | String    | Applications listed will be ignored during updating<br>_List one application after another as shown in the example_                                                                                                        |
| -v              | -v                     | None      | Verbose Output<br>                                                                                                                                                       |
| -t              | -t 150                 | Integer   | Set a custom timeout to be used with either:<br>`-m` <br>_Time the script will wait for application to be "STOPPED"_<br>or<br>`-(u\|U)` <br>_Time the script will wait for application to be either "STOPPED" or "ACTIVE"_ |
| -s              | -s                     | None      | Sync Catalogs prior to updating                                                                                                                                                                                            |
| -p              | -p                     | None      | Prune old/unused docker images                                                                                                                                                                                             |


<br>
<br>

## How to Install

### oneliner

```
curl -s https://raw.githubusercontent.com/truecharts/truetool/main/bootstrap | bash
```

You can now use truetool anywhere `truetool -ARGUMENTS`

## Manual Install

### Choose a folder

It's important to save the script in a folder that is persistent across TrueNAS System Updates.
This saves you from reinstalling or experiencing an accidental lack-of-backups after an update.

##### New dataset

In this example we created a `scripts` dataset on the TrueNAS SCALE system, feel free to use another folder.

##### Root folder

The `/root` folder houses files for the root user.
It's also persistent across updates and hence can be safely used for storing the script.

### Open a Terminal

**Change Directory to your scripts folder**

```
cd /mnt/pool/scripts
```

**Git Clone truetool**

```
git clone https://github.com/truecharts/truetool.git
```

**Change Directory to truetool folder**

```
cd truetool
```

From here, you can just run truetool with `bash truetool.sh -ARGUMENTS`

<br>

## How to Update

TrueTool updates itself automatically.

<br >


## Creating a Cron Job

1. TrueNAS SCALE GUI
2. System Settings
3. Advanced
4. Cron Jobs
   1. Click Add

| Name                   | Value                                                                | Reason                                                                                                                       |
| ---------------------- | -------------------------------------------------------------------- | ---------------------------------------------------------------------------------------------------------------------------- |
| `Description`          | TrueTool Update apps                                                 | This is up to you, put whatever you think is a good description in here                                                      |
| `Command`              | `bash /PATH/TO/truetool_DIRECTORY/truetool.sh --no-color -b 14 -sup` | This is the command you will be running on your schedule, example: `bash /mnt/speed/scripts/truetool/truetool.sh -b 14 -sup` |
| `Run As User`          | `root`                                                               | Running the script as `root` is REQUIRED. You cannot access all of the kubernetes functions without this user.               |
| `Schedule`             | Up to you, example: `0400`                                           | Again up to you                                                                                                              |
| `Hide Standard Output` | `False` or Un-ticked                                                  | It's best to keep an eye on updates and enable this to receive email reports                                                 |
| `Hide Standard Error`  | `False` or Un-ticked                                                  | We definitely want to see what errors occurred during updating                                                               |
| `Enabled`              | `True` or Ticked                                                     | This will Enable the script to run on your schedule                                                                          |

<br >
<br >

### Additional Information

#### TrueTool vs HeavyScript

TrueTool and HeavyScript are based, in essence, based on the original (python based) TrueUpdate and TrueTool.
Then Support-Manager for TrueCharts, HeavyBullets8, ported this to Bash and started adding some additional logic and options for tasks we frequently needed our users to do, such as mounting PVC's.

After a month or so, the TrueCharts Team officially started refactoring this expanded bash-port. Due to personal reasons, HeavyBullets by then decided to separate from TrueCharts after merging the TrueCharts refactor into his own work. The beauty of OpenSource.

From this point onwards the HeavyScript and TrueTool diverged a bit. Development of TrueTool slowed down a bit during Q3 of 2022 and HeavyScript significantly improved on the reliability of primary features while also adding some of it's own.

While previously HeavyScript and TrueTool shared a lot of code back-and-forth without much care to attribution, we've decided to more officially attribute and start using functions with all the HeavyScript improvements in-place for some of the primary features like: Backup, Restore and App-Updates. Cleanly seperating those from TrueCharts features that have neglitable involvement of HeavyScript.

Users from HeavyScript should be able to safely start using TrueTool, as we've made precautions to ensure the backups take over smoothly.
We, however, do _not_ advise using HeavyScript with TrueCharts Apps. Not because it's a bad App, but because we offer an alternative that is validated by our Staff.

We internally review changes within our staff team, to verify we somewhat stick to best-practices. This means, in some cases, we decided not to port certain features from HeavyScript and did decide to add features we think are useful and safe.
But this also means we can give guarantees TrueTool works optimally with our Catalog of TrueNAS SCALE Apps, as well as official Apps.
