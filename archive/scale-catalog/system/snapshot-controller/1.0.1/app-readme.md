Deploys a Snapshot Controller in a cluster. Snapshot Controllers are often bundled with the Kubernetes distribution,
this chart is meant for cases where it is not.
Also deploys the Snapshot Validation Webhook and configures your cluster to validate every `VolumeSnapshot` and
`VolumeSnapshotContent` resource by sending it to the webhook.


This App is supplied by TrueCharts, for more information visit the manual: [https://truecharts.org/charts/system/snapshot-controller](https://truecharts.org/charts/system/snapshot-controller)

---

TrueCharts can only exist due to the incredible effort of our staff.
Please consider making a [donation](https://truecharts.org/sponsor) or contributing back to the project any way you can!
