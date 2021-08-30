# 15 - Adding additional storage

We  provide the option to mount as many host folders as you want.

hostPathMounts are actually quite simple:
It mounts a directory from your TrueNAS SCALE system, directly to a directory inside the App you're installing.

#### Permissions

We offer an optional automatic set the permissions according to App fsGroup or PUID.

Setting permissions automatically means we `chown` the folder and all folder within it, to a group of your choice.
However, we only do so when installing or updating an app.

Please be aware that automatically setting ownership/permissions, does mean it overrides your current CHOWN and CHMOD settings. This could break things and yes, it will destroy your system if used carelessly. It's also not wise to enable the automatic permissions on mounted shares from an external system.


#### Video Guide

TBD

##### Additional Documentation
