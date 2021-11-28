# FAQ

- Q: Please include app X<br>
A: Please file an issue about it, after checking the wiki, discord and Github to make sure it hasn't been discussed already

- Q: Isn't there more documentation for app x<br>
A: If it's not on our [website](https://truecharts.org) or the discord, we (sadly) do not. There might be other sources for documentation however!

- Q: Function x doesn't seem to be working, should it be working?<br>
A: Maybe, please file an issue on github or ask on the Discord

- Q: Is my data guaranteed to be secure?<br>
A: ix_volumes (the auto generated storage) is considered relatively secure as long as you don't delete the App, but we can't give an absolute guarantee. data mounted using a hostPath, is as secure as the application that is using the data, our charts do not actively alter said dataset/folder.

- Q: sabnzbd isn't starting.<br>
A: SabNZBD has a weird security implementation that requires you to add the hostname or IP adress to their config file. In the future we might automate this proces, but currently we do not.

- Q: An app is asking for a password.<br>
A: We almost allways use the defaults from the upstream project, if we are forced to use a password and not add the option to change it in the install GUI.
