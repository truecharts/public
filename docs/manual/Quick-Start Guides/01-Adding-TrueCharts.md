# 01 - Adding TrueCharts to SCALE

Adding the TrueCharts Community App Catalog is relatively straight forwards.

##### Requirements

- Make sure your storage-pool is created and working
- Make sure you have a working internet connection and can reach github and truecharts.org from the host system.

##### Adding TrueCharts

When opening the Apps menu item on TrueNAS SCALE for the first time, you get prompted to setup a new pool for Apps.
This will create a new dataset on the selected pool called "ix-applications", which will contain all docker containers and most application data, unless specified otherwise.

- Go to "Apps" in the left hand menu
- Select the "Manage Catalogs" tab
- Click "Add Catalog" and enter the required information:

Name: `truecharts`
Repository: `https://github.com/truecharts/catalog`
Preferred Trains: `stable` and `core`
Branch: `main`

##### Difference between Stable and Incubator

TrueCharts has multiple "trains": All trains contain Apps that should work fine. However they have a slightly different meaning:

- `stable` contains most of our Apps. These are considered stable and working.
- `core` contains important Apps that are used to supply features like "ingress" or advanced networking to our Apps.
- `incubator` These Apps are still in development and/or are not considered to be of high-enough quality.


#### Video Guide

![type:video](https://www.youtube.com/embed/Vomm8uvdCM0)

##### Notes

- If this doesn't work right away, try clicking "Refresh Catalogs".
