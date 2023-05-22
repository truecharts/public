# Plex Installation Notes

## Transcode Folder

- By default the Plex transcode folder is not configured. The recommend setup is emptyDir.

:::danger Memory Requirements

Please be aware of memory requirements if you memory for emptyDir.
Plex transcode storage requirement is size of file being transcoded + 100MB per simultaneous stream.

Keep in mind that emptyDir's memory counts against the resources defined.

:::

1. Under Additional App Storage click add.
2. Setup either a Disk Transcode or Memory Transcode as shown below.

### Disk Transcode

![disk-transcode](./img/plex-disk-transcode.png)

### Memory Transcode

![memory-transcode](./img/plex-memory-transcode.png)

## Require HTTPS

![Plex App Config](img/Plex-App-Config.png)

- This option cannot be enabled until initial plex setup is complete and remote access is enabled and functioning as shown below.

![remote access](./img/plex-remote-access.png)
