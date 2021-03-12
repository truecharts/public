# FAQ

- Q: I tried to run TrueCharts on TrueNAS SCALE 20.12 and it doesn't work.<br>
A: TrueNAS SCALE 20.12 has never supported custom charts in any way, shape or form. Hence TrueCharts is 21.02+ only

- Q: Please include app X<br>
A: Please file an issue about it, after checking the wiki to make sure it hasn't been discussed already:
https://github.com/truecharts/truecharts/wiki/k8s-at-home-to-SCALE-App-migration-list

- Q: Isn't there more documentation for app x<br>
A: If it's not on our [wiki](https://wiki.truecharts.org), we do not. Currently during TrueNAS SCALE ALPHA/BETA we focus on the technical aspects.

- Q: Function x doesn't seem to be working, should it be working?<br>
A: Maybe, please file an issue

- Q: I'm missing a lot of configuration opions in the install GUI.<br>
A: We try to aim for a balance in the amount of options vs the simplicity of installation. Suggestions are always welcome

- Q: The portal button isn't working.<br>
A: Portal buttons are current't not implemented very well and are considered "not supported" for the time being

- Q: I selected letsencrypt but still get a traefik certificate.<br>
A: Cert Manager might take up to 10 minutes to fetch the right certificate and requires free access to 1.1.1.1:53. Until the right certificate is fetched, it will use the Traefik Default cert.

- Q: Is my data guaranteed to be secure?<br>
A: ix_volumes (the auto generated storage) is considered relatively secure as long as you don't delete the App, but we can't give an absolute guarantee. data mounted using a hostPath, is as secure as the application that is using the data, our charts do not actively alter said dataset/folder. However: SCALE is still ALPHA, so breaking changes in the storage design are very likely.

- Q: sabnzbd isn't starting.<br>
A: SabNZBD has a weird security implementation that requires you to add the hostname or IP adress to their config file. In the future we might automate this proces, but currently we do not.

- Q: An app is asking for a password.<br>
A: We almost allways use the defaults from the upstream project, if we are forced to use a password and not add the option to change it in the install GUI.
