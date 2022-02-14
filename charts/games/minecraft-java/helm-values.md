# Default Helm-Values

TrueCharts is primarily build to supply TrueNAS SCALE Apps.
However, we also supply all Apps as standard Helm-Charts. In this document we aim to document the default values in our values.yaml file.

Most of our Apps also consume our "common" Helm Chart.
If this is the case, this means that all values.yaml values are set to the common chart values.yaml by default. This values.yaml file will only contain values that deviate from the common chart.
You will, however, be able to use all values referenced in the common chart here, besides the values listed in this document.

## Values

| Key | Type | Default | Description |
|-----|------|---------|-------------|
| env.ALLOW_NETHER | bool | `true` |  |
| env.ANNOUNCE_PLAYER_ACHIEVEMENTS | bool | `true` |  |
| env.DIFFICULTY | string | `"easy"` |  |
| env.ENABLE_COMMAND_BLOCK | bool | `false` |  |
| env.EULA | string | `"TRUE"` |  |
| env.FORCE_GAMEMODE | bool | `false` |  |
| env.GENERATE_STRUCTURES | bool | `true` |  |
| env.HARDCORE | bool | `false` |  |
| env.LEVEL | string | `"world"` |  |
| env.LEVEL_TYPE | string | `"DEFAULT"` |  |
| env.MAX_BUILD_HEIGHT | int | `256` |  |
| env.MAX_PLAYERS | int | `20` |  |
| env.MAX_TICK_TIME | int | `60000` |  |
| env.MAX_WORLD_SIZE | int | `10000` |  |
| env.MEMORY | string | `"2048M"` |  |
| env.MODE | string | `"survival"` |  |
| env.MOTD | string | `"Welcome to Minecraft on TrueNAS Scale!"` |  |
| env.ONLINE_MODE | bool | `true` |  |
| env.PVP | bool | `false` |  |
| env.SPAWN_ANIMALS | bool | `true` |  |
| env.SPAWN_MONSTERS | bool | `true` |  |
| env.SPAWN_NPCS | bool | `true` |  |
| env.TYPE | string | `"VANILLA"` |  |
| env.VERSION | string | `"LATEST"` |  |
| env.VIEW_DISTANCE | int | `16` |  |
| image.pullPolicy | string | `"Always"` |  |
| image.repository | string | `"tccr.io/truecharts/minecraft-java"` |  |
| image.tag | string | `"v2022.3.0@sha256:dc121eacba1f056fa287783d06a88dbb75bb50471cf0b6a8edcf04c96fd9dfc8"` |  |
| j11Image.pullPolicy | string | `"Always"` |  |
| j11Image.repository | string | `"tccr.io/truecharts/minecraft-java11"` |  |
| j11Image.tag | string | `"latest@sha256:99418d96c7c5c4e2ffc990479851943267b0958a5369479101da2bb22acfdde0"` |  |
| j11j9Image.pullPolicy | string | `"Always"` |  |
| j11j9Image.repository | string | `"tccr.io/truecharts/minecraft-java11-openj9"` |  |
| j11j9Image.tag | string | `"latest@sha256:248ecbdca94efa8ab7c0b0437a0b59ba82ca9dabe6cd1f90a8cbd43319f15b82"` |  |
| j8Image.pullPolicy | string | `"Always"` |  |
| j8Image.repository | string | `"tccr.io/truecharts/minecraft-java8-openj9"` |  |
| j8Image.tag | string | `"latest@sha256:e820e9a47c96c12fb8ca1cd99e79a012467097f7b3bbe3003805226d1ef39aa9"` |  |
| j8j9Image.pullPolicy | string | `"Always"` |  |
| j8j9Image.repository | string | `"tccr.io/truecharts/minecraft-java8-openj9"` |  |
| j8j9Image.tag | string | `"latest@sha256:e820e9a47c96c12fb8ca1cd99e79a012467097f7b3bbe3003805226d1ef39aa9"` |  |
| persistence.data.enabled | bool | `true` |  |
| persistence.data.mountPath | string | `"/data"` |  |
| portal.enabled | bool | `false` |  |
| service.main.ports.main.port | int | `25565` |  |
| service.main.ports.main.targetPort | int | `25565` |  |

All Rights Reserved - The TrueCharts Project
