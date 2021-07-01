# Upgrading Installed Catalog Item

TrueNAS Scale allows upgrading installed catalog item to a new available
item version. TrueNAS Scale takes a snapshot of the existing PVC's / iX Volumes
before an upgrade which actually allows the user to rollback easily to a previous
catalog item version for any reason ( like some missing deprecated functionality or bug in the newer version ).

When TrueNAS Scale takes a snapshot of the application's data ( this excludes explicit host path volumes ),
TrueNAS does not stop any workloads before taking a snapshot as each workload
might have its own custom upgrade strategy like Rolling Update and in this
case TrueNAS should not be stopping the workload as that would violate the
custom upgrade strategy. This works with most use cases, however there are
workloads which should be stopped before a snapshot is taken of their data like
databases. It's possible that if a database workload is not stopped before
taking a snapshot, on a rollback it might get into an inconsistent state as
it might have had active transactions at the time the snapshot was taken and rolling
back to that period of time can result in inconsistent / undesired behavior
from the database.

For such custom scenarios, TrueNAS Scale allows to stop workloads specifically
before a snapshot is taken of an application's volumes. Workloads in this case can
add the following annotation to the deployment/statefulset:

```
"ix.upgrade.scale.down.workload": true
```

Deployment(s) / statefulset(s) having the above annotation set will be stopped
by TrueNAS Scale before a snapshot is taken of the application's volume.
