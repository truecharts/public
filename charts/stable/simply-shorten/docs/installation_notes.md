---
title: Installation Notes
---

- Set `username` to a username that is hard to guess.
- Set `password` to a password that is hard to guess.

- Enable ingress, without doing so `http://IP:PORT` will be used as the short url generator which obviously will be an issue.


## Disable authentication

- Due to **NOT** being a recommended option you will have to manually add this env yourself.

- Add an additional env variable `INSECURE_DISABLE_PASSWORD` with the value of `I_KNOW_ITS_BAD` in **Configure Extra Environment Variables**. Any other value will **NOT** work.
