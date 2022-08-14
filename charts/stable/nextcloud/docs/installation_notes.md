# Important Notes

Nextcloud is a VERY picky Application and is VERY hard to support.
The support staff on our Discord can help with the basic installation and
getting Ingress to run with the chart, as that is that is the only recommended and supported installation method since 15.X.

The support staff will not help with upgrades that fail from an earlier version than 15.X, we've included a
[migration guide](migration_guide.md) to help with this upgrade.

If you're having issues with the Nextcloud app/chart itself after basic installation we ask you not to file support
requests on our Discord or Github, unless your issue is clearly caused by TrueCharts. It's, however, fine to ask in an, appropiate, other, non-support, channel!

While we consider the App layer "Stable", we simply cannot guarantee stability due to the nature of the Nextcloud Application inside the App.

## Installation Notes

Nextcloud generates it's `config.php` file on the first startup/installation. Therefore you have to set some values correctly on the first try.
Otherwise you will have to either re-install the App or edit the `config.php` manually, with the latter being out of our support scope.
The mentioned values are:

- User Data storage location, type (eg. PVC, hostPath).

Also Nextcloud creates an Admin user on the first startup/installation. Changing them later, will have no effect.
The mentioned values are:

- NEXTCLOUD_ADMIN_USER
- NEXTCLOUD_ADMIN_PASSWORD
