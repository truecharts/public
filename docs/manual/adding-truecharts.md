# Adding TrueCharts to SCALE

Adding the TrueCharts Community App Catalog is relatively straight forwards.

##### Requirements

- Make sure your storage-pool is created and working
- Make Make sure you selected your storage-pool when you first opened the "Apps" interface, if not please refert to the TrueNAS SCALE documentation how to setup your Apps using the apps settings menu.
- Make sure you have a working internet connection and can reach github and truecharts.org from the host system.

##### Adding TrueCharts

- Go to "Apps" in the left hand menu
- Select the "Manage Catalogs" tab
- Click "Add Catalog" and enter the required information:

Name: `truecharts`

Repository: `https://github.com/truecharts/apps`

Preferred Trains: `stable`

Branch: `master`

##### Notes

If this doesn't work right away, try clicking "Refresh Catalogs".