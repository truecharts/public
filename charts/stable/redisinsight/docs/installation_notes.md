---
title: Installation Notes
---

- If using ingress and want to access this service with a domain add an entry to `Trusted Origins` like `https://app.mydomain.tld`.
- Set `Log Level` with any option from the list: "DEBUG", "INFO", "WARNING", "ERROR" and "CRITICAL". Default is "WARNING".
- Check `Auth Prompt` to enable the authentication prompt that asks for authentication before opening an instance or when the user is idle.
- Set `Auth Timer` to a number for the idle timer for authentication prompt, in minutes. Default is 30.
