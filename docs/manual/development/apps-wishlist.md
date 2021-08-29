# Apps GUI Suggestions

The goal is to gather some suggestions and forward them to iX-Systems.

For easy reference the priorities are linked to a future release for reference purposes and should be read as "The following release or earlier".
When given a priority the following is taken into account:
- The amount of complaints about something
- How invasive the change is, most likely, going to be vs. the time till the aimed release.
- If there are any TrueCharts features that are currently "on-hold" or struggeling, due to the lack of a certain feature
- The added value a feature is going to have for TrueNAS SCALE



### Priority: High/Release

##### GUI suggestions

- Add more bulk options, like bulk upgrade and restart. https://jira.ixsystems.com/browse/NAS-112055
- Default tab should be "Installed Apps" or have an option to set the default. https://jira.ixsystems.com/browse/NAS-112057
- Use blue for the Official Catalog/Train boxes in the available/installed apps tabs. https://jira.ixsystems.com/browse/NAS-112059
- Allow showing 1 or more default entries when creating a list (instead of an empty list)[NAS-109761](https://jira.ixsystems.com/browse/NAS-109761)
- When using rollback display a dropdown of available versions, instead of a textbox. https://jira.ixsystems.com/browse/NAS-112060
- Allow fields of type `text` in questions.yaml, instead of just `string` https://jira.ixsystems.com/browse/NAS-112061

##### Backend suggestions

- Allow multiple Containers to all consume the same intel GPU https://jira.ixsystems.com/browse/NAS-112058


### Priority: Medium/U1

##### GUI suggestions

- Use all screen on install / edit app, not just a sidebar. [NAS-110183](https://jira.ixsystems.com/browse/NAS-110183)
- Add service information (Service name and ports) to the App Overview (In the card displayed when clicking an installed app).
- The "Application Events" in the App Overview should be shown in a similar UI widget as the container logs. This would improve the readability.
- Allow changing colors (yellow/gold default) of catalogs/trains boxes in the available/installed apps tabs, to be easier to distinguish between catalog/train.
- Add option for separators and whitespace in questions.yaml [NAS-110750](https://jira.ixsystems.com/browse/NAS-110750)


##### Backend suggestions

- Add ability to save a PVC backup even on app delete
- Add ability to restore a PVC backup from a deleted app
- Add MetalLB Loadbalancer https://jira.ixsystems.com/browse/NAS-111019


### Priority: Low/Post-U1

##### GUI suggestions

- Add sorting options in app catalog.
- The App overview card should be resizable, right now viewing application events is very limiting.
- Fix some of the themes to work with apps section. Light color themes like paper make it very hard to see if an app is up to date or requiring upgrade
- Add ability to group apps (for better organization) (e.g. Media apps, Production apps, Dev Apps etc)
- Show statistics per app (cpu / network / ram)'
- Validate regex defined in questions.yaml when focus leaves input field.
- Set custom message to display when `valid_chars` is not matched.
- Application Events should be auto-updated, instead of having to re-open the app card to see the new events. [NAS-111626](https://jira.ixsystems.com/browse/NAS-111626)
- Make timezone searchable and sorted in Scale Apps installation [NAS-109524](https://jira.ixsystems.com/browse/NAS-109524)

##### Backend suggestions

- Allow `show_if` and `show_subquestions_if` to to use values for evaluation from parent variables [NAS-110751](https://jira.ixsystems.com/browse/NAS-110751)

##### Documentation suggestions

- Document the fact users can also use the native Helm CLI instead of Apps for advanced deployments and which things they should avoid (such as `ix-` prefixed namespaces)
- Document how advanced users can take an existing Helm Chart and create an app with mostly empty GUI to deploy it on SCALE.



### Priority: Not sure if possible/reasonable

- Add ability to set which app will start on boot (Auto start)
- Add ability to set a delay before an app starts on boot (Delayed auto start)
- Investigate if we can show/mount the PVC path to the host (maybe show only if the App is `stopped`?)
- Allow to auto update Apps https://jira.ixsystems.com/browse/NAS-112056


### Done Already

- :white_check_mark: Make timezone default to timezone set in TN System [NAS-110373](https://jira.ixsystems.com/browse/NAS-110373)
- :white_check_mark: Show all config options on "Confirm options" when installing an App
- :white_check_mark: Installed apps status should be updated without the need to change view and come back. e.g After installing/updating an app, you will always see "Deploying" until you go to manage catalogs and come back to installed apps.
