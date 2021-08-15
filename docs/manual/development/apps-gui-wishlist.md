# Apps GUI Suggestions

The goal is to gather some suggestions and forward them to iX-Systems.

##### Documentation suggestions

- Document the fact users can also use the native Helm CLI instead of Apps for advanced deployments and which things they should avoid (such as `ix-` prefixed namespaces)
- Document how advanced users can take an existing Helm Chart and create an app with mostly empty GUI to deploy it on SCALE.

##### Visual suggestions

- Use all screen on install / edit app, not just a sidebar. [NAS-110183](https://jira.ixsystems.com/browse/NAS-110183)
- Add more bulk options, like bulk upgrade and restart.
- Add sorting options in app catalog.
- Default tab should be "Installed Apps" or have an option to set the default.
- Make timezone searchable and sorted in Scale Apps installation [NAS-109524](https://jira.ixsystems.com/browse/NAS-109524)
- Add service information (Service name and ports) to the App Overview (In the card displayed when clicking an installed app).
- The "Application Events" in the App Overview should be shown in a similar UI widget as the container logs. This would improve the readability.
- Application Events should be auto-updated, instead of having to re-open the app card to see the new events. [NAS-111626](https://jira.ixsystems.com/browse/NAS-111626)
- The App overview card should be resizable, right now viewing application events is very limiting.
- Fix some of the themes to work with apps section. Light color themes like paper make it very hard to see if an app is up to date or requiring upgrade
- Add ability to set which app will start on boot (Auto start)
- Add ability to set a delay before an app starts on boot (Delayed auto start)
- Add ability to group apps (for better organization) (e.g. Media apps, Production apps, Dev Apps etc)
- Show statistics per app (cpu / network / ram)
- Use blue for the Official Catalog/Train boxes in the available/installed apps tabs.
- Allow changing colors (yellow/gold default) of catalogs/trains boxes in the available/installed apps tabs, to be easier to distinguish between catalog/train.
- Add option for separators and whitespace in questions.yaml [NAS-110750](https://jira.ixsystems.com/browse/NAS-110750)
- Allow showing 1 or more default entries when creating a list (instead of an empty list)

- :white_check_mark: Make timezone default to timezone set in TN System [NAS-110373](https://jira.ixsystems.com/browse/NAS-110373)
- :white_check_mark: Show all config options on "Confirm options" when installing an App
- :white_check_mark: Installed apps status should be updated without the need to change view and come back. e.g After installing/updating an app, you will always see "Deploying" until you go to manage catalogs and come back to installed apps.

##### Technical suggestions

- Allow `show_if` and `show_subquestions_if` to to use values for evaluation from parent variables [NAS-110751](https://jira.ixsystems.com/browse/NAS-110751)
- Validate regex defined in questions.yaml when focus leaves input field.
- Set custom message to display when `valid_chars` is not matched.
- Add ability to save a PVC backup even on app delete
- Add ability to restore a PVC backup from a deleted app
- Investigate if we can show/mount the PVC path to the host (maybe show only if the App is `stopped`?)

Join our [discord](https://truecharts.org/discord) to make a new suggestion.
