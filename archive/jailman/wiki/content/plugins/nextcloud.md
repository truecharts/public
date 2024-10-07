# Nextcloud
Nextcloud is the most deployed on-premises file share and collaboration platform. Access & collaborate across your devices. 

**For more information about Nextcloud, please checkout:**
https://nextcloud.com/

## Configuration parameters:

- time_zone: Is the time zone of your location, in PHP notation--see the [PHP manual](http://php.net/manual/en/timezones.php) for a list of all valid time zones.
- cert_type: DNS_CERT, STANDALONE_CERT, SELFSIGNED_CERT, and NO_CERT determine which method will be used to generate a TLS certificate (or, in the case of NO_CERT, indicate that you don't want to use SSL at all).  DNS_CERT and STANDALONE_CERT indicate use of DNS or HTTP validation for Let's Encrypt, respectively.
- cert_email: The email address Let's Encrypt will use to notify you of certificate expiration.  This is mandatory regardless of whether you're using Let's Encrypt (Caddy won't start without it), but it's only used with Let's Encrypt.  If you are **not** using one of the Let's Encrypt certificate options, you can set this to a dummy address as above.  If you **are** using Let's Encrypt, though, it should be set to a valid address for the system admin.
- dns_plugin: If DNS_CERT is set, DNS_PLUGIN must contain the name of the DNS validation plugin you'll use with Caddy to validate domain control.  See the [Caddy documentation](https://caddyserver.com/docs) under the heading of "DNS Providers" for the available plugins, but omit the leading "tls.dns.".  For example, to use Cloudflare, set `DNS_PLUGIN="cloudflare"`.
- dns_env: If DNS_CERT is set, DNS_ENV must contain the authentication credentials for your DNS provider.  See the [Caddy documentation](https://caddyserver.com/docs) under the heading of "DNS Providers" for further details.  For Cloudflare, you'd set `DNS_ENV="CLOUDFLARE_EMAIL=foo@bar.baz CLOUDFLARE_API_KEY=blah"`, using your the email address of your Cloudflare account and your Global API key--the newer API tokens aren't currently supported.
- link_mariadb: The name of the MariaDB database jail you want to use.
- mariadb_password: The Password for the mariadb database user you want to use. Will be created on first install.
- mariadb_user: The name for the mariadb database user you want to use. Will be created on first install. Will default to the database name.
- mariadb_database: The name of the mariadb database you want to use. Will be created on first install. Will default to the jail name.
- admin_password: The password for the default Nextcloud admin user you want to create. Not created on reinstall.

