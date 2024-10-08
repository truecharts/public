# Grafana

Grafana allows you to query, visualize, alert on and understand your metrics no matter where they are stored. Create, explore, and share dashboards with your team and foster a data driven culture:

**For more information about Grafana, please checkout:**
https://grafana.com

#### Configuration Parameters

- password (req): The password for the default admin account (admin). Required.
- link_influxdb (opt): set to the name of the influxdb jail to set as datasource, if desired.
- link_unifi (opt): set to the name of the Unifi jail with Unifi Poller to automatically get its data from influxdb. (requires link_influxdb)
