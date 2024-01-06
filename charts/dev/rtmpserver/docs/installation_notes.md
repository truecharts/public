---
title: Installation Notes
---

The app has no configuration. The following is just a basic guide on how to stream and view the live stream.

## Stream

- This is the URL to use to stream `rtmp://<server_ip>:1935/live/<stream_key>`
  - Replace `<server_ip> and` `<stream_key>` respectively.
  - Change the port if its not default.

## View

- VLC

  - Go to Media > Open Network Stream.
    /code/charts/truecharts/charts/charts/rtmpserver - `rtmp://<server ip>:1935/live/<stream-key>`

- Web

  - ~~To play RTMP content: `http://<server_ip>:10610/players/rtmp.html`~~ (requires Flash, this tech is dead!)
  - To play HLS content: `http://<server_ip>:10610/players/hls.html`
  - To play HLS content using hls.js library: `http://<server_ip>:10610/players/hls_hlsjs.html`
  - To play DASH content: `http://<server_ip>:10610/players/dash.html`
  - To play RTMP and HLS contents on the same page: `http://<server_ip>:10610/players/rtmp_hls.html`

:::note

The default basic builtin stream sites use a default key, "test".

:::

## Customization

- If you want to mount a modified version of a nginx.conf you can do so by manually mounting `/etc/nginx/` as PVC or hostpath and then add the custom files after. Take a look at upstream's [configs](https://github.com/TareqAlqutami/rtmp-hls-server/tree/master/conf).

- If you want to mount and customized the web players you can do so by mounting `/usr/local/nginx/html/players` and adding the files in that dir, here are example players [html's](https://github.com/TareqAlqutami/rtmp-hls-server/tree/master/players).

- You might want to enable the `codeserver` addon to access the dirs to add/modify the files in a fast and easy to use web editor by going to `http://<server_ip>:36107/?folder=/`

:::note

We will not offer support if you manually mount these dirs, you can ask for help in our discord channel [#🎓・unsupported-setups](https://discord.gg/JRU6gUjeMJ) otherwise you can create a ticket in our support channel normally.

:::
