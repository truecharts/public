# Storage

TrueCharts tries to stay in sync with the Official IX-Systems App Catalog when it comes to storage. Which is currently pretty much a "work in progres".

### Storage types

Storage is currently seperated into two types:
1. ix_volumes
2. hostPath

While, from a k8s point of view, both of these are technically hostPath volumes, for you, as a user, there is a significant difference.

##### ix_volumes

ix_volumes, are the default storage option for every TrueCharts App. They always get created and used unless "hostPath" is checked.
ix_volumes are fully managed by TrueNAS SCALE, they get created and destroyed on demand when creating, updating or editing an App.
But, most importantly, they can be reverted if an upgrade goes wrong. Which makes them an great to use for storing config files.

They are, normally, stored in the following directory:
`/mnt/poolname/ix-applications/releases/releasename/volumes/ix_volumes/`

##### hostPath

Hostpath is quite simple: It mounts a directory from your TrueNAS SCALE system, directly to a directory inside the App you're installing.
There is, in contrast to the ix_volumes, no "special magic sauce" when adding hostPath storage.

### Permissions

Permission settings are rather important and are often something that causes issues for users.
For that reason TrueCharts introduced a feature to automatically set permissions individually for each of your storage options.

Setting permissions automatically means we `chown` the folder and all folder within it, to a user and group of your choice.
However, we only do so when installing or updating an app.

These permission get based on the user and group you enter in the App configuration dialog and default to `568` (the SCALE default Apps user).
