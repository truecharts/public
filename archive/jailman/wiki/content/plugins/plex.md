# Plex

Plex gives you one place to find and access all the media that matters to you. From personal media on your own server, to podcasts, web shows, and news, to streaming music, you can enjoy it all in one app, on any device.

**For more information about Plex, please checkout:**
https://plex.tv

#### Advanced config parameters:

- ramdisk: Specify the `size` parameter to create a transcoding ramdisk under /tmp_transcode. Requires manual setting it un plex to be used for transcoding. (optional)

#### Experimental config parameters:

These parameters are either not fully tested or expected to break with short-term OS updates. They are included in the release however, because they are suspected to become stable eventually.

- hw_transcode: set this to "true" to enable hardware transcoding on compatible systems, to "false" to disable or, preferable, just leave it out to disable
