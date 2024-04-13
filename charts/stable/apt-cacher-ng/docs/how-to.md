---
title: How-To
---

To start using Apt-Cacher NG on your Debian (Based) host, create the
configuration file `/etc/apt/apt.conf.d/01proxy` with the following content:

```apache
Acquire::HTTP::Proxy "http://SERVER.IP:3142";
Acquire::HTTPS::Proxy "false";
```

> Don't forget to replace `SERVER.IP` with your actual server IP.
