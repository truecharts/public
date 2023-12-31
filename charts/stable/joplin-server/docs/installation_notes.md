---
title: Installation Notes
---

- To set the variable `App Base Url` correctly:
  - If you are accessing it _without_ ingress/domain -> `http://IP:PORT`.
  - If ingress is enabled, set it to `https://app.mydomain.tld`.

---

- To enable the `mailer` options just set `Mailer Enabled` to `1`.
  - Set `Mailer Host` to the smtp service that you use, eg `smtp.example.com`
  - Set `Mailer Port` to the smtp service port, eg `465`, `587`, etc.
  - Set `Mailer Secure` to **true** if you need SSL/HTTPS.
  - Set `Mailer Auth User` to email as the username.
  - Set `Mailer Auth Password` to your email's password.
  - Set `Mailer No Reply Name` to whatever you want.
  - Set `Mailer No Reply Email` to the default email for `no reply`.

:::note

If you are using google as the SMTP service, your email password will _not_ work. You need to create a `app password` instead. find out more [here](https://support.google.com/accounts/answer/185833?hl=en).

:::
