---
title: Democratic-CSI
---

Democratic CSI is a multi-platform CSI, mostly using either local or network (NFS/iSCSI) based storage.

## Values

Their Helm-Chart is available at: https://democratic-csi.github.io/charts/
All below examples, are based on their Helm-Chart

### NFS

```yaml
csiDriver:
    name: "nfs"
storageClasses:
- name: nfs
  defaultClass: true
  reclaimPolicy: Delete
  volumeBindingMode: Immediate
  allowVolumeExpansion: true
  parameters:
    fsType: nfs
    detachedVolumesFromSnapshots: "false"
  secrets:
    provisioner-secret:
    controller-publish-secret:
    node-stage-secret:
    node-publish-secret:
    controller-expand-secret:

# if you want to use snapshots
volumeSnapshotClasses:
- name: nfs-snapshot
    parameters:
        detachedSnapshots: "true"
driver:
  config:
    driver: freenas-api-nfs
    instance_id:
    httpConnection:
        protocol: http
        host: ${CONFIG_TRUENAS_IP}
        port: 81
        allowInsecure: true
        apiKey: ${TRUENAS_API_KEY}
    zfs:
        datasetParentName: ${PATH TO YOUR PARENT SHARE}
        detachedSnapshotsDatasetParentName: ${PATH TO YOUR PARENT SNAPSHOT SHARE}
        datasetEnableQuotas: true
        datasetEnableReservation: false
        datasetPermissionsMode: "0770"
        datasetPermissionsUser: 0
        datasetPermissionsGroup: 0
    nfs:
        shareHost: ${CONFIG_TRUENAS_IP}
        shareAlldirs: false
        shareAllowedHosts: []
        shareAllowedNetworks: []
        shareMaprootUser: root
        shareMaprootGroup: root
        shareMapallUser: ""
        shareMapallGroup: ""
```

### iSCSI

```yaml
csiDriver:
      name: "iscsi"
storageClasses:
    - name: iscsi
    defaultClass: true
    reclaimPolicy: Delete
    volumeBindingMode: Immediate
    allowVolumeExpansion: true
    parameters:
        fsType: ext4
        detachedVolumesFromSnapshots: "false"
    mountOptions: []
    secrets:
        provisioner-secret:
        controller-publish-secret:
        node-stage-secret:
        node-publish-secret:
        controller-expand-secret:
volumeSnapshotClasses:
    - name: iscsi
    parameters:
        detachedSnapshots: "true"
driver:
    config:
    driver: freenas-api-iscsi
    instance_id:
    httpConnection:
        protocol: http
        host: ${TRUENAS_IP}
        port: 81
        allowInsecure: true
        apiKey: ${SECRET_TRUENAS_API}
    zfs:
        datasetParentName: ${PATH TO YOUR PARENT SHARE}
        detachedSnapshotsDatasetParentName: ${PATH TO YOUR PARENT SNAPSHOT SHARE}
        zvolCompression:
        zvolDedup:
        zvolEnableReservation: false
        zvolBlocksize:
    iscsi:
        targetPortal: "${TRUENAS_IP}:3260"
        interface:
        namePrefix: csi-
        nameSuffix: "-talos"
        targetGroups:
        - targetGroupPortalGroup: 1
            targetGroupInitiatorGroup: 1
            targetGroupAuthType: None
            targetGroupAuthGroup:
        extentInsecureTpc: true
        extentXenCompat: false
        extentDisablePhysicalBlocksize: true
        extentBlocksize: 512
        extentRpm: "SSD"
        extentAvailThreshold: 0"
```

## TrueNAS CRON Job Script

Due to flaws in TrueNAS SCALE, this script needs to run each day est. 20min after volsync cycle to clear stuck jobs. (Truenas Cronjob)

```python
from datetime import datetime, timedelta, timezone
from truenas_api_client import Client
import subprocess

def main():
    # Initialize Middleware Client
    middleware = Client()

    try:
        # Get current time as a timezone-aware datetime in UTC
        current_time = datetime.now(timezone.utc)
        ten_minutes_ago = current_time - timedelta(minutes=10)

        filters = [
            ['state', '=', 'RUNNING'],
            ['method', '=', 'replication.run_onetime'],
            ['progress.description', '=', '']
        ]
        jobs = middleware.call('core.get_jobs', filters)

        for job in jobs:
            start_time = job['time_started']

            # Check if the job started more than 10 minutes ago
            if start_time <= ten_minutes_ago:
                job_id = job['id']
                start_time_formatted = start_time.strftime("%d %B %Y %H:%M:%S")
                running_time = current_time - start_time
                running_time_minutes = running_time.total_seconds() // 60.0

                print(f'{job_id}')
                print(f'- Started: {start_time_formatted}')
                print(f'- Runtime: {running_time_minutes}m')

                print(f'- Aborting: {job_id}')

                # Abort the job
                abort_result = middleware.call('core.job_abort', job_id)
                if abort_result is None:
                    print(f"-- Success")
                else:
                    print(f"-- Failed")

                # Parse and format target dataset path
                target_dataset = job['arguments'][0]['target_dataset']
                target_dataset = target_dataset.rsplit('/snapshot-', 1)[0]
                print(f'- Destroying ZFS dataset "{target_dataset}"')

                # Quote dataset path, in case it contains spaces
                destroy_command = f'zfs destroy "{target_dataset}"'

                # Destroy the ZFS dataset
                destroy_result = subprocess.run(destroy_command, capture_output=True, shell=True)
                if destroy_result.returncode == 0:
                    print(f"-- Success")
                else:
                    print(f"-- Failed")
                print("")

    finally:
        # Close the middleware client connection
        middleware.close()

if __name__ == "__main__":
    main()
```

## Other references

Other resource for guidance: https://github.com/fenio/k8s-truenas
