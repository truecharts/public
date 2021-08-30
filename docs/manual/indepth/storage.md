# Storage

TrueCharts uses multiple different storage systems:


### Storage types

Storage is currently seperated into two types:

1. Integrated Persistent Storage (PVC)
2. Custom Storage aka "hostPathMounts"


### Integrated Persistent Storage

Integrated Persistent Storage is based around Kubernetes PVC's to integrate as closely as possible into TrueNAS SCALE. They are also heavily preconfigured to work as optimal as possible and provide options for future expansion such as NFS and Gluster options being added.
These storage options inherently are not well suited to being shared with multiple applications.

This storage is integrated into TrueNAS SCALE and completely supports reverting upgrades. Thats why this is the default (and only actually supported!) way of storing App configuration files.


### Custom app storage aka "hostPathMounts"

Besides the earlier mentioned Integrated Persistent Storage, we also provide the option to mount as many host folders as you want.

hostPathMounts are actually quite simple:
It mounts a directory from your TrueNAS SCALE system, directly to a directory inside the App you're installing.


### Permissions

Permission settings are rather important and are often something that causes issues for users.
For both Integrated Persistent Storage and Custom storage, we offer special options to automatically set permissions to coincide with your container.

##### Integrated Persistent Storage

These get automatically set to be owned by :__PGID__

##### Custom app storage aka "hostPathMounts"

We offer an optional automatic set the permissions according to App App fsGroup or PUID.

Setting permissions automatically means we `chown` the folder and all folder within it, to a user and group of your choice.
However, we only do so when installing or updating an app.

Please be aware that automatically setting ownership/permissions, does mean it overrides your current CHOWN and CHMOD settings. This could break things and yes, it will destroy your system if used carelessly. It's also not wise to enable the automatic permissions on mounted shares from an external system.
These permission get based on the user and group you enter in the App configuration dialog and default to `568` (the SCALE default Apps user).
