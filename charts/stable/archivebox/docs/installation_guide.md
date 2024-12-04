---
title: Installation Guide
---

## Configuration

- Configure an initial admin username and password you want to log in within the Web UI (only applied on first setup run).

  ```yaml
  values:
    config:
      admin_username: "admin"
      admin_password: "changeme"
  ```

- If needed, it is possible to set up a persitent storage for archived data.

  Example configuration using NFS:

  ```yaml
  values:
    persistence:
      archive:
        enabled: true
        mountPath: /data/archive
        type: nfs
        path: /mnt/Tank/apps/archivebox
        server: ${NAS_IP}
  ```

  Make sure whatever filesystem the data is located on supports FSYNC and doesn't squash permissions. NFS servers may need to set <code>no_root_squash</code>

  For more info about ArchiveBox's filesystem requirements, see here:

  - [ArchiveBox Filesystem Requirements](https://github.com/ArchiveBox/ArchiveBox#storage-requirements)
  - [ArchiveBox Issue #742](https://github.com/ArchiveBox/ArchiveBox/issues/742) (example of common filesystem issue with NFS)
  - [ArchiveBox Issue #1304](https://github.com/ArchiveBox/ArchiveBox/issues/1304)

- Optionally add any other [ArchiveBox Configuration](https://github.com/ArchiveBox/ArchiveBox/wiki/Configuration) variables you want

  Example:

  ```yaml
  values:
    workload:
      main:
        podSpec:
          containers:
            main:
              env:
                SNAPSHOTS_PER_PAGE: 10
  ```

## Further Reading

- [ArchiveBox Documentation](https://github.com/ArchiveBox/ArchiveBox/wiki/)
- [ArchiveBox UI Usage](https://github.com/ArchiveBox/ArchiveBox/wiki/Usage#ui-usage)
- [ArchiveBox Security Overview](https://github.com/ArchiveBox/ArchiveBox/wiki/Security-Overview)
- [ArchiveBox Configuration](https://github.com/ArchiveBox/ArchiveBox/wiki/Configuration)
- [ArchiveBox Hosting Guide](https://github.com/ArchiveBox/ArchiveBox/wiki/Publishing-Your-Archive)
- [ArchiveBox Changelog](https://github.com/ArchiveBox/ArchiveBox/releases)

### Ask For Help

- [Archivebox Bug Tracker](https://github.com/ArchiveBox/ArchiveBox/issues)
- [ArchiveBox Community Forum / Chat Server](https://zulip.archivebox.io)
