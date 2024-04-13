---
title: Installation Notes
---

- In order to run this chart, you need to be a _paid_ end-user for [proton](https://proton.me/mail/bridge).
- Shell into the app after installing it to complete the login phase.
- Run the following commands in order:

```shell
chmod +x entrypoint.sh && ps aux | grep [b]ridge | awk '{print $2}' | xargs -I {} kill -9 {} && ./entrypoint.sh init
```

```shell
login
```

- You can then login with your username and password.

:::tip

To save time and energy, you can paste the password by holding SHIFT and pressing INSERT.

Password field is still blank, just hit enter as normal.

:::
