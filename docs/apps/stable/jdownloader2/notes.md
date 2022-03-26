# Installation Notes

- If you enable `Reverse Proxy` for `jDownloader2`, you need to have `SECURE_CONNECTION` set to `0` and `Port Type` set to `HTTP`, otherwise you may run into errors for `Too many redirects`.
- `VNC` can't be `Reversed Proxied`. if you want to use `VNC`, you must set this service to `Simple` instead of `clusterIP`.
- `VNC` with `SECURE_CONNECTION` set 1, only works with very few clients. One of them is `SSVNC`.
- `SECURE_CONNECTION` affects both `WebUI` and `VNC`.
