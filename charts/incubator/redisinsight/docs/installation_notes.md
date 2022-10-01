# Installation Notes

- If using ingress and want to access this service with a domain then set the value for `RITRUSTEDORIGINS` as "https://app.mydomain.tld".
- Set `RILOGLEVEL` with any option from the list: "DEBUG", "INFO", "WARNING", "ERROR" and "CRITICAL". Default is "WARNING".
- Set `RIAUTHPROMPT` to True to enable the authentication prompt that asks for authentication before opening an instance or when the user is idle.
- Set `RIAUTHTIMER` to a number for the idle timer for authentication prompt, in minutes. Default is 30.
