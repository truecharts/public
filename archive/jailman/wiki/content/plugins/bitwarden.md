# Bitwarden_RS

This is a Bitwarden server API implementation written in Rust compatible with [upstream Bitwarden clients](https://bitwarden.com/#download)\*, perfect for self-hosted deployment where running the official resource-heavy service might not be ideal.

**For more information about Bitwarden_RS, please checkout:**
https://github.com/dani-garcia/bitwarden_rs

## Configuration Parameters

- admin_token: Long (preferable random) password to be used to open the Bitwarden_rs admin interface. Admin interface is disabled when empty
- link_mariadb: MariaDB jail to be used for storing the database.
- mariadb_database: The name of the database used for (encrypted) credential storage. defaults to the jail name. Will be created on first install.
- mariadb_user: The name of the database user to be used for (encrypted) credential storage. defaults to the database name. Will be created on first install.
- mariadb_password: The password of the database user to be used for (encrypted) credential storage. defaults to the database name.
