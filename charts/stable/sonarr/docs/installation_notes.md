---
title: Installation Notes
---

## Sonarr (v3)

The current stable version of Sonarr is v3. When configuring Sonarr v3, the default authentication method is `In-App Setting`. The available authentication methods for Sonarr v3 are as follows:

- **In-App Setting**: Allows users to make changes via the web GUI (Graphical User Interface).
- **None**: No authentication required.
- **Basic**: Basic username and password authentication.
- **Forms**: Form-based authentication.

For Sonarr v3, we strongly recommend using either "In-App Setting" or "None" for the authentication method.

:::caution

We strongly discourage the use of the "Basic" authentication method, as it may potentially impact system probes and security.

:::
