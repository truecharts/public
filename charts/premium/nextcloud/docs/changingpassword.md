---
title: Changing Database Password
---

Sadly enough, Nextcloud Containers do not correctly update database passwords when changed.
To do so, please execute the following steps to do so manually:

Due to other platforms do all having the same storage backend, it depends on your storage backend how you do this.
It might be advisable to change the password within nextcloud _before_ changing the password on the cnpg database.

In summary:

- Access the config PVC
- Edit config.php to ensure "dbpassword" reflects your password
