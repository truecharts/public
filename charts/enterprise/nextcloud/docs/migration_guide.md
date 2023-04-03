# Migration Notes

This guide is provided as a resource to help taken from our Discord, but since 15.X is a breaking change
there's no guarantees this will work, and you may have to install fresh

We want to highlight that this is considered a completely new App, hence the "breaking change".
For the best stability we would advice people to reinstall (with the option to save the users data).

While we try to help people through migration and even have added some automated migration tooling,
we cannot guarantee migration with breaking changes like these.

The correct troubleshooting steps would be:

- Remove any mention of "nextcloud_datadir" either in env-vars or config.php (if you manually added or altered it), we never supported this due to us expecting this change long beforehand
- Remove any custom storage
- Ensure config is set to "PVC"
- Add `127.0.0.1` to the TRUSTED_PROXY setting like this: `172.16.0.0/16 127.0.0.1`
- Stop and Start the old version to double-ensure the settings are applied
- Apply the update
- Wait for a good while (go grab lunch, eat it and drink a coffee afterwards)
- Check if it worked out

If not:

- Manually ensure your nextcloud data structure is correct inside the App in both /var/www/html and /var/www/html/data
- Double check if data directory is not set to anything other than /var/www/html/data (not set at-all is fine though)
- Restart
