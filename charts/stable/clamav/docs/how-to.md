---
title: How-To
---

This is a quick setup guide on how to use ClamAV with mounted directories via NFS shares and configure the integrated cron job to scan these mounted folders.

## App Installation

### Cron Job

Without a GUI, using a cron job is the easiest way to run ClamAV in the background at specific times.
- To generate a cron schedule, you can use a website like [CronHub](https://crontab.cronhub.io) or [Crontab Guru](https://crontab.guru).
- `date_format` follows the Linux `date` command syntax. See the [date(1)](https://man7.org/linux/man-pages/man1/date.1.html) man page for reference.
- `extra_args` is where you define the directories to be scanned.

```yaml
clamav:
  cron_enabled: true
  cron_schedule: "* * * * *"
  date_format: "+%m-%d-%Y_%H.%M.%S"
  log_file_name: clamscan_report
  extra_args: "/Apps /PathA /PathB"
```

### Scan directory

Add your scanned directories, ensuring that your mounted directories match the paths specified in the `extra_args` section above.

```yaml
persistence:
  Apps:
    enabled: true
    type: nfs
    path: ${NFS_PATH}
    server: ${SERVER_IP}
    mountPath: /Apps
```

## Support

If you need more details or have a more customized setup, refer to the documentation on the [upstream repository](https://github.com/Cisco-Talos/clamav)
