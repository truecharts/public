---
title: VolSync
---

### Adding Credentials

You can add the credentials by copy-pasting the [Full Examples](/common/credentials#full-examples) section in the common-docs and adapting those accordingly

:::note[Bucket Creation]

You do not have to manually create the bucket beforehand, although this is recommended to ensure the bucket's name is available beforehand

:::

## PVC Backups

PVC data can be easily backed up to S3 storage by using our integrated VolSync support. For each individual app, the `VolSync Destination (Restore)` option _must_ set on creation of the app by doing the following:

1. Add `VolSync` to each persistence object you want synced as below

2. Add the name you gave to the S3 credentials earlier, under the `credentials` section of VolumeSnapshots

3. Enable the `VolSync Source (Backup)` and/or `VolSync Destination (Restore)` options as desired

4. Confirm the data is being sent to your S3 host after ~5 minutes

It will look something like this for each of your persistence:

```yaml
persistence:
  config:
    volsync:
      - name: config
        type: restic
        credentials: mys3_credentials
        dest:
          enabled: true
        src:
          enabled: true

```

## PVC Restoration

PVC data restoration will happen automatically before the app starts. Please be aware this can take a while depending on the size of the backup, your connection speed, etc.

## Total System Restore and Migration to New System

When on a completely new system, you can easily restore using the above steps with the following caveats:

- On a non-SCALE system, the PVC backend needs to support snapshots
- The apps need to be called **exactly** the same as they were before, preferably using a previously-exported config
- If you've any non-PVC storage attached, be sure that this is still available or apps won't start until this is resolved
