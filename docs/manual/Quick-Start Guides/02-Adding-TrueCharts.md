# 02 - Adding TrueCharts to SCALE

Adding the TrueCharts Community App Catalog is relatively straight forwards.

##### Requirements

- Make sure your storage-pool is created and working
- Make Make sure you selected your storage-pool when you first opened the "Apps" interface, if not please refer to quick-start guide `01 - First time Apps setup`
- Make sure you have a working internet connection and can reach github and truecharts.org from the host system.

##### Adding TrueCharts

- Go to "Apps" in the left hand menu
- Select the "Manage Catalogs" tab
- Click "Add Catalog" and enter the required information:

Name: `truecharts`
Repository: `https://github.com/truecharts/catalog`
Preferred Trains: `stable`
Branch: `main`

##### Difference between Stable and Incubator

TrueCharts has multiple "trains": All trains contain Apps that should work fine. However they have a slightly different meaning:

- `stable` contains most of our Apps. These are considered stable and working.
- `incubator` These Apps are still in development and/or are not considered to be of high-enough quality.


#### Video Guide

![type:video](https://www.youtube.com/embed/rfgCkCek7_s)

##### Notes

- If this doesn't work right away, try clicking "Refresh Catalogs".
