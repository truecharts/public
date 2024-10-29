---
title: How To
---

The following sections are just _examples_ and may not represent best practices or all use cases.
The only tested servers were Spigot Based variants by PaperMC, Paper version **1.19.2**, the latest current MC version.

## Bungeecord / WaterFall

Spigot compatible server(s) need to be set **offline** by unchecking **Enable/Disable Online Mode** in minecraft-java instance(s).

Then modify a single value in **/data/spigot.yml** in each server:

```yaml
bungeecord: true
```

Then in this file(assuming its paper) **/config/paper-global.yml**:

```yaml
bungee-cord:
  online-mode: true
```

This is a sample **config.yml** that you can create in the **/config** dir.

```yaml
connection_throttle: 4000
connection_throttle_limit: 3
timeout: 30000
permissions:
  default:
    - bungeecord.command.server
    - bungeecord.command.list
  admin:
    - bungeecord.command.alert
    - bungeecord.command.end
    - bungeecord.command.ip
    - bungeecord.command.reload
network_compression_threshold: 256
servers:
  lobby:
    motd: "&1My Lobby MC"
    address: MY_PRIVATE_IP:25566 # Set this as your local IP, or cluster URL `minecraft-java.ix-minecraft-java.svc.cluster.local`
    restricted: false
player_limit: -1
prevent_proxy_connections: false
server_connect_timeout: 5000
remote_ping_timeout: 5000
forge_support: false
remote_ping_cache: -1
log_commands: false
log_pings: true
ip_forward: true # needs to be true
disabled_commands:
  - disabledcommandhere
groups:
  md_5:
    - admin
listeners:
  - host: 0.0.0.0:25577 # leave this as `0.0.0.0:25577`
    query_port: 25577 # leave port as is.
    motd: "&1Another Bungee server" # change this to whatever you like
    max_players: 2
    force_default_server: false
    tab_size: 60
    forced_hosts:
      pvp.md-5.net: pvp
    tab_list: GLOBAL_PING
    bind_local_address: true # should be kept true
    ping_passthrough: false
    query_enabled: false
    proxy_protocol: false
    priorities:
      - lobby
      - survival
      - creative
online_mode: true # needs to true
```

## Velocity

Create a file called **secrets** in **/config** dir and apply the name to this value like so -> **forwarding-secret-file = "secret"**.

The contents of the secret file:

```text
MyForwardingSecret
```

For every MC (Spigot) instance you want proxied by Velocity, you need to make sure **bungeecord** in **/data/spigot.yml** is set to:

```yaml
bungeecord: false
```

Then in this file(assuming you are running paper) **/config/paper-global.yml**:

```yaml
bungee-cord:
    online-mode: false # needs to be `false`.
    # ....
    velocity:
    enabled: true
    online-mode: true
    secret: MyForwardingSecret # the actual value and NOT the name of the file.
```

Here's a sample of a **velocity.toml** that you can place in **/config** dir.

```toml
# Config version. Do not change this
config-version = "2.5"

# What port should the proxy be bound to? By default, we'll bind to all addresses on port 25577.
bind = "0.0.0.0:25577" # leave alone, dont change.

# What should be the MOTD? This gets displayed when the player adds your server to
# their server list. Legacy color codes and JSON are accepted.
motd = "&#09add3A Velocity Server"

# What should we display for the maximum number of players? (Velocity does not support a cap
# on the number of players online.)
show-max-players = 420

# Should we authenticate players with Mojang? By default, this is on.
online-mode = true

# Should the proxy enforce the new public key security standard? By default, this is on.
force-key-authentication = true

# If client's ISP/AS sent from this proxy is different from the one from Mojang's
# authentication server, the player is kicked. This disallows some VPN and proxy
# connections but is a weak form of protection.
prevent-client-proxy-connections = false

# Should we forward IP addresses and other data to backend servers?
# Available options:
# - "none":        No forwarding will be done. All players will appear to be connecting
#                  from the proxy and will have offline-mode UUIDs.
# - "legacy":      Forward player IPs and UUIDs in a BungeeCord-compatible format. Use this
#                  if you run servers using Minecraft 1.12 or lower.
# - "bungeeguard": Forward player IPs and UUIDs in a format supported by the BungeeGuard
#                  plugin. Use this if you run servers using Minecraft 1.12 or lower, and are
#                  unable to implement network level firewalling (on a shared host).
# - "modern":      Forward player IPs and UUIDs as part of the login process using
#                  Velocity's native forwarding. Only applicable for Minecraft 1.13 or higher.
player-info-forwarding-mode = "modern"

# If you are using modern or BungeeGuard IP forwarding, configure a file that contains a unique secret here.
# The file is expected to be UTF-8 encoded and not empty.
forwarding-secret-file = "secret"

# Announce whether or not your server supports Forge. If you run a modded server, we
# suggest turning this on.
#
# If your network runs one modpack consistently, consider using ping-passthrough = "mods"
# instead for a nicer display in the server list.
announce-forge = false

# If enabled (default is false) and the proxy is in online mode, Velocity will kick
# any existing player who is online if a duplicate connection attempt is made.
kick-existing-players = false

# Should Velocity pass server list ping requests to a backend server?
# Available options:
# - "disabled":    No pass-through will be done. The velocity.toml and server-icon.png
#                  will determine the initial server list ping response.
# - "mods":        Passes only the mod list from your backend server into the response.
#                  The first server in your try list (or forced host) with a mod list will be
#                  used. If no backend servers can be contacted, Velocity won't display any
#                  mod information.
# - "description": Uses the description and mod list from the backend server. The first
#                  server in the try (or forced host) list that responds is used for the
#                  description and mod list.
# - "all":         Uses the backend server's response as the proxy response. The Velocity
#                  configuration is used if no servers could be contacted.
ping-passthrough = "DISABLED"

# If not enabled (default is true) player IP addresses will be replaced by `<ip address withheld>` in logs
enable-player-address-logging = true

[servers]
# Configure your servers here. Each key represents the server's name, and the value
# represents the IP address of the server to connect to.
lobby = "MY_PRIVATE_IP:25566" #  cluster urls do work too -> `minecraft-java.ix-minecraft-java.svc.cluster.local`

# In what order we should try servers when a player logs in or is kicked from aserver.
try = [
    "lobby"
]

[forced-hosts]
# Configure your forced hosts here.
"lobby.mydomain.com" = [
    "lobby"
]

[advanced]
# How large a Minecraft packet has to be before we compress it. Setting this to zero will
# compress all packets, and setting it to -1 will disable compression entirely.
compression-threshold = 256

# How much compression should be done (from 0-9). The default is -1, which uses the
# default level of 6.
compression-level = -1

# How fast (in milliseconds) are clients allowed to connect after the last connection? By
# default, this is three seconds. Disable this by setting this to 0.
login-ratelimit = 3000

# Specify a custom timeout for connection timeouts here. The default is five seconds.
connection-timeout = 5000

# Specify a read timeout for connections here. The default is 30 seconds.
read-timeout = 30000

# Enables compatibility with HAProxy's PROXY protocol. If you don't know what this is for, then
# don't enable it.
haproxy-protocol = false

# Enables TCP fast open support on the proxy. Requires the proxy to run on Linux.
tcp-fast-open = true # any issues, set 'false'.

# Enables BungeeCord plugin messaging channel support on Velocity.
bungee-plugin-message-channel = true

# Shows ping requests to the proxy from clients.
show-ping-requests = false

# By default, Velocity will attempt to gracefully handle situations where the user unexpectedly
# loses connection to the server without an explicit disconnect message by attempting to fall the
# user back, except in the case of read timeouts. BungeeCord will disconnect the user instead. You
# can disable this setting to use the BungeeCord behavior.
failover-on-unexpected-server-disconnect = true

# Declares the proxy commands to 1.13+ clients.
announce-proxy-commands = true

# Enables the logging of commands
log-command-executions = false

# Enables logging of player connections when connecting to the proxy, switching servers
# and disconnecting from the proxy.
log-player-connections = true

[query]
# Whether to enable responding to GameSpy 4 query responses or not.
enabled = false

# If query is enabled, on what port should the query protocol listen on?
port = 25577 # DONT CHANGE THIS PORT.

# This is the map name that is reported to the query services.
map = "Velocity"

# Whether plugins should be shown in query response by default or not
show-plugins = false
```

:::tip

There's currently a known issue with **limbo server** when attemptng to connect to a **1.19.2** velocity proxy server and using **player-info-forwarding-mode = "modern"**. You can track the current issue here [issue 50](https://github.com/LOOHP/Limbo/issues/50).

Bungeecord/waterfall are _not_ affected.

Sources:

- [bungeecord | waterfall config.yml](https://www.spigotmc.org/wiki/bungeecord-configuration-guide/)
- [velocity.toml](https://github.com/PaperMC/Velocity/blob/dev/3.0.0/proxy/src/main/resources/default-velocity.toml)

:::
