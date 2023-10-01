# Installation Notes

## Sonarr Version 3 (v3)

The current stable version of Sonarr is v3. When configuring Sonarr v3, the default authentication method is `In-App Setting`. The available authentication methods for Sonarr v3 are as follows:

- **In-App Setting**: Allows users to make changes via the web GUI (Graphical User Interface).
- **None**: No authentication required.
- **Basic**: Basic username and password authentication.
- **Forms**: Form-based authentication.

For Sonarr v3, we strongly recommend using either "In-App Setting" or "None" for the authentication method.

## Sonarr Version 4 (v4)

Sonarr v4 introduces new default values for the "Auth Method" configuration. The available authentication methods for Sonarr v4 are as follows:

- **In-App Setting**: Allows users to make changes via the web GUI (Graphical User Interface) without requiring authentication.
- **Basic**: Basic username and password authentication.
- **Forms**: Form-based authentication.
- **External**: External authentication mechanisms.

For Sonarr v4 (when it becomes stable), we recommend using only "In-App Setting" or "External" for the authentication method. While these options leave the application less secure, we advise implementing a forward authentication mechanism such as Authelia for enhanced security.

:::warning

**Note:** We strongly discourage the use of the "Basic" authentication method, as it may potentially impact system probes and security.

:::
