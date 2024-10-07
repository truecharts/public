# Custom Functions

## Intro

With Jailman we have a number of functions that are custom. This document lists them and explains their use. Currently all custom functions are inculded in ./includes/global.sh

## parse_yaml
This functions parses the yml config files. It does not support lists however and we highly advice not using indentations other than 2 spaces either.
It's only input is a yml file and it should be called as the argument of an eval statement.

## gitupdate
This function triggers an update based on the branch it is given.
Currently only called in jailman.sh and it is fed the remote/branch combo it is currently on.

## jailcreate
This function creates the actual jail based on a plugin.
It takes the jail name, looks up the plugin and proceeds accordingly.
It also creates things like basic mount points and such. while also checking if all required vars are filled.

Currently only used in jailman.sh

## initplugin
This function turns all config.yml variables for the jail inputed as $1 into local variables. This is not required (as variables are also available as `${!jail_$1_varname}`), but makes it easier for less experienced plugin creators to start working with Jailman
It takes only the Jailname as input.

## exitplugin
This script does the "success" processing for an installation. It takes the name of the jail and a message (preferable a connection instruction), creates the "INSTALLED" file, does the last checks and outputs the successmessages
No additional scripting besides `echo`'s should be done after executing this script.

## createmount
This function creates a dataset and mounts said dataset to a specific folder in a jail, while also creating required subfolders if needed.
It's easier to use and update than mounting folders manually, so it's the only allowed way to do so, unless very specific config is required (such as database datasets)
It has the following input options:
# $1 = jail name
# $2 = Dataset
# $3 = Target mountpoint
# $4 = fstab prefernces
