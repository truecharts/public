# Migration between versions

Sometimes we can not guarantee automatic updating between new versions of our Apps.
These pages include some common scenario's and give some guidance how to manually move between different versions and Trains.

### Between Trains

An app will always be just in one train. If an App moves to a different train, you will not be able to update automatically
Our basic guidence for these cases is:


- Backup all your files, config and databases.
- Make notes on how you set up your app previously
- Delete the old App
- Install the new app using your previously made setup notes
- Stop the new App
- Put back all your old files.
- Re start the new App

### Between Versions

When new versions introduce breaking changes (which would often be major version changes) they might(!) require the user to reinstall.
However: We often already provide migration scrips and dealth with these issues manually.

##### Common 2.0 -> common 3.0 based Apps

In cases you upgrade to a common 3.0 based app, reinstall is currently required. Please be aware: Installing will nuke your data!
Be also aware that we do not have common 2.0 based installs available in the version dropdown

##### Common 3.0 -> common 4.0 based Apps

In cases you upgrade to a common 4.0 based app, reinstall is currently required. Please be aware: Installing will nuke your data!
However: Common 3.0 based Apps are still available to be installed using the version dropdown

##### Common 4.0 -> common 5.0 based Apps

Common 5.0.0 is actually a rather small update: It just allows using a ramdisk when using emptyDir on hostPathMount.
It is however still a breaking change.

To update, we advice removing all(!) entries from hostPathMounts/customStorage and readd them after the update
