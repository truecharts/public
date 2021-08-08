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
Preferred Trains: `stable` (and optionally: `incubator`)
Branch: `main`

##### Difference between Stable and Incubator

TrueCharts has multiple "trains": All trains contain Apps that should work fine. However they have a slightly different meaning:

- `stable` contains Apps that have an active maintainer that uses and maintains these Apps. This person guarantees that the Apps should function without issues. They also are reviewed more strictly before being accepted into `stable`, for both security and stability.
- `incubator` contains Apps that either do not have an active maintainer or are not fully reviewed to comply to all our technical guidelines. They should, however, still function without issues.


#### Video Guide

![type:video](https://www.youtube.com/embed/rfgCkCek7_s)

##### Notes

- If this doesn't work right away, try clicking "Refresh Catalogs".
