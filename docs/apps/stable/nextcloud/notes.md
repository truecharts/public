# Important Notes

Nextcloud is a VERY picky Application and is VERY hard to support.
For this reason we ask you not to file support requests on our Discord or Github, unless your issue is clearly caused by TrueCharts.

While we consider the App layer "Stable", we simply cannot guarantee stability due to the nature of the Nextcloud Application inside the App.


# Installation Notes

Nextcloud generates it's `config.php` file on the first startup/installation. Therefore you have to set some values correctly on the first try.
Otherwise you will have to either re-install the App or edit the `config.php` manually, with the latter being out of our support scope.
The mentioned values are:
  - TRUSTED_PROXIES
  - NODE_IP

And if you plan to use ingress, this also needs to be configured correctly on the first time.

Also Nextcloud creates an Admin user on the first startup/installation, which you can only define it's username and password on the first install.
Changing them later, will have no effect.
The mentioned values are:
  - NEXTCLOUD_ADMIN_USER
  - NEXTCLOUD_ADMIN_PASSWORD
