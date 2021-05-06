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

Repository: `https://github.com/truecharts/catalog`

Preferred Trains: `stable` (and optionally: `incubator`)

Branch: `main`

##### Difference between Stable and Incubator

TrueCharts has 2 trains: `Staging` and `Incubator`. Both trains contain Apps that should work fine. However they have a slightly different meaning:

`Staging` Contains Apps that have an active maintainer that uses and maintains these Apps. This person guarantees that the Apps should function without issues. They also are reviewed more strictly before being accepted into `Stable`, for both security and stability.

`Incubator` Contains Apps that either do not have an active maintainer or are not fully reviewed to comply to all our technical guidelines. They should, however, still function without issues.

##### Adding TrueCharts on TrueNAS SCALE 21.02ALPHA

Because we are very close to release of TrueNAS SCALE 21.04ALPHA and we have made considerably bugfixes and rewrites of code already,  TrueNAS SCALE 21.02ALPHA is considered to be depricated by the TrueCharts team.
However: Your old installed apps should still be available in the "installed applications" section.

In case you really need to add the old "legacy" version of TrueCharts, you can install a special legacy branch named `legacy_21.02ALPHA`


##### Notes

- If this doesn't work right away, try clicking "Refresh Catalogs".
