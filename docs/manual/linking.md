# Linking Apps Together

We often need to connect individual apps together, for example: Ombi and Plex. This means we first need to know how to reach those Apps.

##### Linking Apps Internally

The backend for TrueNAS SCALE Apps is Kubernetes. Linking apps together in kubernetes is done slightly different than in other systems, as you can't point directly to other Containers using their IP-Address.

Instead we need to use their internal(!) domain name. Please be ware: this name is only available between Apps and can not be reached from the host/node or your own PC.
The format for internal domain name for the main service is as follows, please replace `$APPNAME` with the name you gave your App when installing.

`$APPNAME.ix-$APPNAME.svc.cluster.local`

However, if you need to reach a different service (which is not often the case!), you need a slightly different format, where `$SVCNAME` is the name of the service you want to reach:

`$SVCNAME.ix-$APPNAME.svc.cluster.local`

*For example:*

To reach an app named "plex", we use the following internal domain name:

`plex.ix-plex.svc.cluster.local`
