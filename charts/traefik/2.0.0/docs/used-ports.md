# Used Ports

Traefik forwards traffic for a lot of applications and we don't want to require from users to edit its configuration.

This means that by default Traefik will claim a lot of ports from the node. Please be aware: these ports can NOT be used by other applications as NodePorts. Under "Advanced" we offer options to disable exposing these ports, freeing them for other applications, or altering the port numbers.

###### Used Port List


- **web:** 80

- **websecure:** 443

- **plex:** 32400

- **kms:** 1688

- **dns-tcp:** 53

- **dns-udp:** 53/UDP

- **stun-tcp:** 3478

- **stun-udp:** 3478/UDP

- **torrent-tcp:** 51413

- **torrent-udp:** 51413/UDP

- **radius:** 1812

- **radius-acc:** 1813

- **ldaps:** 636

- **unificom:** 8080
