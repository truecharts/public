# Default Helm-Values

TrueCharts is primarily build to supply TrueNAS SCALE Apps.
However, we also supply all Apps as standard Helm-Charts. In this document we aim to document the default values in our values.yaml file.

Most of our Apps also consume our "common" Helm Chart.
If this is the case, this means that all values.yaml values are set to the common chart values.yaml by default. This values.yaml file will only contain values that deviate from the common chart.
You will, however, be able to use all values referenced in the common chart here, besides the values listed in this document.

## Values

| Key | Type | Default | Description |
|-----|------|---------|-------------|
| envFrom[0].configMapRef.name | string | `"littlelinkconfig"` |  |
| image.pullPolicy | string | `"IfNotPresent"` |  |
| image.repository | string | `"ghcr.io/techno-tim/littlelink-server"` |  |
| image.tag | string | `"latest@sha256:6d6bcbdd5e5a17b85f98a6ab42c95ba8f083dc8a2d7d2a3f4fcb28e446a57c4d"` |  |
| littlelink.avatar_2x_url | string | `"https://pbs.twimg.com/profile_images/1286144221217316864/qiaskopb_400x400.jpg"` |  |
| littlelink.avatar_alt | string | `"techno tim profile pic"` |  |
| littlelink.avatar_url | string | `"https://pbs.twimg.com/profile_images/1286144221217316864/qiaskopb_200x200.jpg"` |  |
| littlelink.bio | string | `"hey! just a place where you can connect with me!"` |  |
| littlelink.discord | string | `"https://discord.gg/djkexrj"` |  |
| littlelink.favicon_url | string | `"https://pbs.twimg.com/profile_images/1286144221217316864/qiaskopb_200x200.jpg"` |  |
| littlelink.footer | string | `"thanks for stopping by!"` |  |
| littlelink.github | string | `"https://github.com/timothystewart6"` |  |
| littlelink.instagram | string | `"https://www.instagram.com/techno.tim"` |  |
| littlelink.kit | string | `"https://kit.co/technotim"` |  |
| littlelink.meta_author | string | `"techno tim"` |  |
| littlelink.meta_description | string | `"techno tim link page"` |  |
| littlelink.meta_title | string | `"techno tim"` |  |
| littlelink.name | string | `"technotim"` |  |
| littlelink.theme | string | `"dark"` |  |
| littlelink.tiktok | string | `"https://www.tiktok.com/@technotim"` |  |
| littlelink.twitch | string | `"https://www.twitch.tv/technotim/"` |  |
| littlelink.twitter | string | `"https://twitter.com/technotimlive"` |  |
| littlelink.youtube | string | `"https://www.youtube.com/channel/ucok-ghyjcwznj3br4oxwh0a"` |  |
| service.main.ports.main.port | int | `3000` |  |
| service.main.ports.main.targetPort | int | `3000` |  |

All Rights Reserved - The TrueCharts Project
