---
title: Installation Notes
---

Notes about the proper setup of PeaNUT.

## Configuration

- NUT Host: This is the server that NUT is running on. On TrueNAS Scale this would be your Scale IP Address.
- NUT Port: This is the port that the NUT is running on. On TrueNAS Scale this is `3493`
- Username: This is the username of the NUT. On TrueNAS Scale this is set in the UPS Service as `Monitor User` the default is `upsmon`
- Password: This is the password of the NUT. On TrueNAS Scale this is set in the UPS Service as `Monitor Password`

## Homepage Widget

- PeaNUT supports Homepage integration and has a Widget. After enabling Homepage and the Widget enter the name of the UPS in the `API-key (key)` block. On TrueNAS Scale this is set in the UPS Service as `Identifier`.
