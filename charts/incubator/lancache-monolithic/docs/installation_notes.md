# Installation Notes

Clients like Steam, Battle.net, etc sends requests to port 80/443.
In case you don't want to use traefik in front of this app, you need to change the ports.

- `Service` -> `Main` -> `Port`: **80**
- `Service` -> `https` -> `Port`: **443**

:::danger

Doing this will break Traefik and we do NOT recommend it.
Also, you have to make sure that you do NOT have any other service on these ports.
Like TrueNAS Scale WebUI.

:::
