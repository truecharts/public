# Important Notes

Nextcloud is a VERY picky Application and is VERY hard to support. The support staff on our Discord can help with the basic installation and getting Ingress to run with the chart, as that is that is the only recommended installation method since 15.X. The support staff will not help with upgrades that fail from an earlier version than 15.X, we've included a troubleshooting guide to help with this upgrade below that troubleshoot the common errors. If you're having issues with the Nextcloud app/chart itself after basic installation we ask you not to file support requests on our Discord or Github, unless your issue is clearly caused by TrueCharts.

While we consider the App layer "Stable", we simply cannot guarantee stability due to the nature of the Nextcloud Application inside the App.

## Installation Notes

Nextcloud generates it's `config.php` file on the first startup/installation. Therefore you have to set some values correctly on the first try.
Otherwise you will have to either re-install the App or edit the `config.php` manually, with the latter being out of our support scope.
The mentioned values are:

- TRUSTED_PROXIES
- NODE_IP
- Ingress, if you plan to use it.
- Data storage location, type (eg. PVC, hostPath).

Also Nextcloud creates an Admin user on the first startup/installation, which you can only define it's username and password on the first install.
Changing them later, will have no effect.
The mentioned values are:

- NEXTCLOUD_ADMIN_USER
- NEXTCLOUD_ADMIN_PASSWORD

## Troubleshooting Guide for Nextcloud Pre-15.X upgrades

This guide is provided as a resource to help taken from our Discord, but since 15.X is a breaking change there's no guarantees this will work, and you may have to install fresh

We want to highlight that this is considered a completely new App, hence the "breaking change".
For the best stability we would advice people to reinstall (with the option to save the usersdata).

While we try to help people through migration and even have added some automated migration tooling, we cannot guaranteemigration with breaking changes like these.

The correct troubleshooting steps would be:
0. Remove any mention of "nextcloud_datadir" either in env-vars or config.php, we never supported this due to us expecting this change long beforehand
1. Remove any custom storage
2. Ensure config is set to "PVC"
3. Add "127.0.0.1" to the TRUSTED_PROXY setting like this: 172.16.0.0/16 127.0.0.1
5. Stop and Start the old version to double-ensure the settings are applied
6. Apply the update
7. wait for a good while (go grab lunch, eat it and drink a coffee afterwards)
8. Check if it worked out

If not:
9. Manually ensure your nextcloud datastructure is correct inside the App in both /var/www/html and /var/www/html/data
10. Double check if datadirectory is not set to anything other than /var/www/html/data (not set at-all is fine though)
11. restart
