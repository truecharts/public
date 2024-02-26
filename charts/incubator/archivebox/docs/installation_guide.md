---
title: Installation Guide
---

## SCALE App

1. to setup archivebox:

- `App Configuration > Admin Username & Admin Password`
  Configure an initial admin username and password you want to log in with in the Web UI (only applied on first setup run).
  <img width="500" alt="Screenshot of example Admin Username & Password configuration" src="https://github.com/pirate/truecharts/assets/511499/fcd60d72-2339-4eed-bb13-5c1cd7134236">

- `Networking and Services > Service's Port(s) Configuration > Port`
  Configure the port you want to access the ArchiveBox web interface on, or use the pre-populated default.
  <img width="500" alt="Screenshot of example Archivebox webserver port configuration" src="https://github.com/pirate/truecharts/assets/511499/f5083399-64e0-4088-8187-dfd92851eb34">

- `Storage and Persistence > App Data Storage`
  Setup persistent a persistent storage volume to use for your ArchiveBox `/data` directory.
  We recommend using a `Host Path` with `Automatic Permissions Configuration` disabled.
  <img width="500" alt="Screenshot of example App Data Storage configuration" src="https://github.com/pirate/truecharts/assets/511499/aa5c4b4f-0285-443b-b654-9d7ceb64ae50">
  <sup>Make sure whatever filesystem the data is located on supports FSYNC and doesn't squash permissions.</sup>
  <sup>(NFS servers may need to set <code>no_root_squash</code> + <code>no_all_squash</code>)</sup>
  For more info about ArchiveBox's filesystem requirements, see here:

  - [ArchiveBox Filesystem Requirements](https://github.com/ArchiveBox/ArchiveBox#storage-requirements)
  - [ArchiveBox Troubleshooting: Filesystems, NFS, FSYNC](https://github.com/ArchiveBox/ArchiveBox/wiki/Upgrading-or-Merging-Archives#filesystem-doesnt-support-fsync-eg-network-mounts)
  - [ArchiveBox Issue #742](https://github.com/ArchiveBox/ArchiveBox/issues/742) (example of common filesystem issue with NFS)

- `Containers > Main Container > Extra Environment Variables` **(optional)**
  Optionally add any other [ArchiveBox Configuration](https://github.com/ArchiveBox/ArchiveBox/wiki/Configuration) variables you want here.
  <img width="500" alt="Screenshot of example Archivebox extra configuration" src="https://github.com/pirate/truecharts/assets/511499/936b3ca6-28e5-484f-8858-2049c0210a3a">

2. ✅ Then **click `Install`** at the bottom, and wait a few minutes for it to finish deploying.

3. Once deployed, **click `Applications > ArchiveBox > Web Portal` to access ArchiveBox** .
   <img width="150" alt="Screenshot TrueNAS Apps UI to access Web Portal" src="https://github.com/pirate/truecharts/assets/511499/08b902c8-7674-427f-b2d1-d546d78855b0" align="top">
   <img width="650" alt="Screenshot ArchiveBox UI open in browser" src="https://github.com/pirate/truecharts/assets/511499/12bbcd8a-a473-44f5-8d65-c4cbd7d7d5ab" align="top">
   Click the `Log In` (upper right) and proceed with the admin username and password you configured above.
   <img width="500" alt="Screenshot of ArchiveBox UI login page" src="https://github.com/pirate/truecharts/assets/511499/ce6a1e1c-45eb-40b4-b4d5-a41b0374cc00">
   Optionally change your password from the initial value by going to `Account` in the navbar (`/admin/password_change/`).
   <img width="500" alt="Screenshot of ArchiveBox navbar highlighting Account and Add buttons" src="https://github.com/pirate/truecharts/assets/511499/831f5eeb-e5c4-4fff-9f3c-07b9af486dc0">
   Click `Add` in the menubar to get started adding new URLs to archive.

---

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
