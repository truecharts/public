---
title: Installation Notes
---

- If you enable `Ingress` for this app, you need to have `SECURE_CONNECTION` set to `false` and `Port Type` set to `HTTP`, otherwise you may run into errors for `Too many redirects`.
- You can't enable `Ingress` for `VNC` If you want to use `VNC`, you must set this service to `Simple` instead
- `VNC` with `SECURE_CONNECTION` set `true`, only works with very few clients. One of them is `SSVNC`.
- `SECURE_CONNECTION` affects both `WebUI` and `VNC`.

---

- If you are passing through devices such as `Optical Drives`, you have to Click `Container Security Settings` and set `PUID` to `0`.
