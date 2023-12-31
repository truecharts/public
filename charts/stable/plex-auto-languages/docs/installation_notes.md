---
title: Installation Notes
---

- Set `PLEX_URL` with `http://IP:PORT` or cluster: `http://plex.ix-plex.svc.cluster.local:32400`. this cluster URL assumes you named it `plex`.

- To set `PLEX_TOKEN` you need to Browse to a library item and view the XML for it in plex as the `admin` user in the browser, the url will end with `...Plex-Token=` so **ONLY** copy after the `=` for the token.

![xml_info_token.png](./img/xml_info_token.png)
