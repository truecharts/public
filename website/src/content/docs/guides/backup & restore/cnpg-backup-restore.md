---
title: CNPG
---

### Adding Credentials

You can add the credentials by copy-pasting the [Full Examples](/common/credentials#full-examples) section in the common-docs and adapting those accordingly

:::note[Bucket Creation]

You do not have to manually create the bucket beforehand, although this is recommended to ensure the bucket's name is available beforehand.

:::

## CNPG Database Backups

CNPG-backed PostgreSQL databases have their own S3 backup system.

For each chart:

1. Add CNPG backups to each database you want backed up

2. Add the name you gave to the S3 credentials earlier, under the `credentials` section

It will look like something like this:

```yaml
cnpg:
  main:
    backups:
      enabled: true
      credentials: s3
    recovery:
      credentials: s3

```

3. Confirm the data is being sent to your S3 host after ~5 minutes. At 00:00 UTC a complete backup will be made.

4. We advise you to set the "mode" to `recovery`, this should prevent the app starting with an empty database upon recovery.

It will look something like this:

```yaml
cnpg:
  main:
    mode: recovery
    backups:
      enabled: true
      credentials: s3
    recovery:
      credentials: s3

```

## CNPG Database Restore

Before CNPG will correctly restore the database, the following modifications need to be done after recreating or importing the app configuration:

1. Ensure you've setup CNPG backups as well as recovery as it was previously

2. Ensure the "mode" is set to `recovery`

3. Set "revision" on your recovery to match the previous **revision** setting on your backup settings.

4. Increase the **revision** on your backup setting by 1 (or set to 1 if previously empty). Revision needs to set as string ("")

It will look something like this:

```yaml
cnpg:
  main:
    mode: recovery
    backups:
      enabled: true
      revision: "1"
      credentials: s3
    recovery:
      # revision: "x"          ## Can be added when you are would like to recover when the revision is > 0 (Step 3)
      credentials: s3
```

## Total System Restore and Migration to New System

When on a completely new system, you can easily restore using the above steps with the following caveats:

- The PVC backend needs to support snapshots
- The apps need to be called **exactly** the same as they were before, and use exactly the same values.yaml structure
- If you've any non-PVC storage attached, be sure that this is still available or apps won't start until this is resolved.
