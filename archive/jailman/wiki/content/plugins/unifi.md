# Unifi Controller

The UniFi® Controller is a wireless network managementsoftware solution from Ubiquiti Networks™. It allows you tomanage multiple wireless networks using a web browser.

**For more information about Unifi Controller, please checkout:**
https://www.ui.com

**For more information about Unifi Poller, please checkout:**
https://github.com/unifi-poller/unifi-poller

### Installation:

- This jail requires an existing InfluxDB jail. InfluxDB may be created using the same install command, as long as influxdb is listed first.
- Once the script runs, a user must be created in the Unifi Controller software for your Unifi-Poller user.
- To view the data from Unifi-Poller, Grafana is required. Add the unifi InfluxDB database as a data source in Grafana.

### Config Description

- unifi_poller: boolean, true if you want to also install unifi-poller
- link_influxdb: This is the name of your influxdb database jail, should be influxdb.
- influxdb_database: The name of the database that will be created in influxdb for Unifi Poller.
- influxdb_user & influxdb_password: The created database's credentials for Unifi Poller.
- poller_user & poller_password: The Unifi-Poller user credentials. This user must be created in the Unifi Controller web gui after install matching these credentials. This is for the connection between Unifi Controller & Unifi Poller

### Unifi-Controller Post-Install

After the script runs and the unifi jail is running, open the web gui of the unifi jail at port 8443 (i.e. https://192.168.2.250:8443). After completing the initial setup wizard, go to Admins --> Add New Admin. Select "Manually set and share the password", enter the username and password used for up_user & up_password. Uncheck 'Require the user to change their password'. Verify "Role" is set to 'Read Only'. Click Create.
