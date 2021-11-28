## Temp / Transcode cache

Tdarr uses the temp folder (trascode-cache, `/temp`) to store the encoded file (not chunks of it, but the whole file). It's recommended to __avoid__ mounting this folder to RAM.
If you encode a large file which will result in a 10GB file, this is the amount of RAM it will consume.

## Media folder mounts

Make sure the Node and Server instances have the same media library and transcode cache locations. In other words, the cache and library must be shared between the Node and Server.
