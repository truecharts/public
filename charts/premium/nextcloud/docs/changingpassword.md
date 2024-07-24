---
title: Changing Database Password
---

Sadly enough, Nextcloud Containers do not correctly update database passwords when changed.
To do so, please execute the following steps to do so manually:

## Other Platforms

Due to other platforms do all having the same storage backend, it depends on your storage backend how you do this.
It might be advisable to change the password within nextcloud _before_ changing the password on the cnpg database.

In summary:

- Access the config PVC
- Edit config.php to ensure "dbpassword" reflects your password

## TrueNAS SCALE

1. Mount Nextcloud with HeavyScript, ex:
   heavyscript pvc --mount nextcloud

2. Change to the mounted path, then to the nextcloud-config folder, ex:
   cd /mnt/mounted_pvc/nextcloud/nextcloud-config

3. grep out dbpassword, ex:
   cat config.php | grep "dbpassword"

4. Copy the value from the grep command, should look something like: dF6h35JFX5v6AzfFpviFAoBbZU9cghKrwHWJf9GY5oRmYJEaiTHkYz93JPUgRf
   Change to your home directory, or exit the terminal, ex:
   cd ~

5. Unmount Nextcloud with HeavyScript, ex:
   heavyscript pvc --unmount nextcloud

6. Open TrueNAS UI > Apps > Nextcloud > Edit, and scroll down to the CNPG section and replace PLACEHOLDERPASSWORD under the password field, with the grep value (from step 3-4), then save
   If a failure happens here regarding cannot upgrade between pg versions then change the Postgres Version under CNPG settings to 15 if its 16 and attempt to save again

7. Start with heavyscript, ex:
   heavyscript app --start nextcloud
