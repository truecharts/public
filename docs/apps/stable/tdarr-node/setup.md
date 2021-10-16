## Temp / Cache

Tdarr uses the temp folder (`/temp`) to store the encoded file (not chunks of it, but the whole file). It's recommended to __avoid__ mounting this folder to RAM.
If you encode a large file which will result in a 10GB file, this is the amount of RAM it will consume.


## Media folder mounts

Make sure the Node and Server instances have the same media library and transcode cache locations. In other words, the cache and library must be shared between the Node and Server.

## Connecting Node with a Server

__If the node is running on the same cluster:__

Assuming the server is named as `tdarr`.

* serverIP: tdarr-comm.ix-tdarr.svc.cluster.local
* serverPort: 8266 (The internal port used by the app)

For more info on how to generate the internal dns, visit our website. Check the linking apps internally section on the manual.

__If the node is running on a different cluster or non-SCALE machine:__

* serverIP: YOUR.HOST.SERVER.IP
* serverPort: 36152 (Default nodePort)
