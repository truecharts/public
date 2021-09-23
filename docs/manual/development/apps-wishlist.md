# Apps Development Suggestions

The goal is to gather some suggestions and forward them to iX-Systems.

For easy reference the priorities are linked to a future release for reference purposes and should be read as "The following release or earlier".
When given a priority the following is taken into account:
- The amount of complaints about something
- How invasive the change is, most likely, going to be vs. the time till the aimed release.
- If there are any TrueCharts features that are currently "on-hold" or struggling, due to the lack of a certain feature
- The added value a feature is going to have for TrueNAS SCALE



### Priority: High/Release

##### GUI suggestions

- Add more bulk options, like bulk upgrade and restart. [NAS-112055](https://jira.ixsystems.com/browse/NAS-112055)
- Use blue for the Official Catalog/Train boxes in the available/installed apps tabs. [NAS-112059](https://jira.ixsystems.com/browse/NAS-112059)
- Allow showing 1 or more default entries when creating a list (instead of an empty list)[NAS-109761](https://jira.ixsystems.com/browse/NAS-109761)
- When using rollback display a dropdown of available versions, instead of a textbox. [NAS-112060](https://jira.ixsystems.com/browse/NAS-112060)
- Hide ServiceLB pods from podlog selector [NAS-112510](https://jira.ixsystems.com/browse/NAS-112510)


##### Backend suggestions

- Allow multiple Containers to all consume the same intel GPU [NAS-112058](https://jira.ixsystems.com/browse/NAS-112058)


##### Documentation suggestions

- Document how (not-to) use the Helm CLI on SCALE [NAS-112075](https://jira.ixsystems.com/browse/NAS-112075)

### Priority: Medium/U1

##### GUI suggestions

- Use all screen on install / edit app, not just a sidebar. [NAS-110183](https://jira.ixsystems.com/browse/NAS-110183)
- Allow changing colors (yellow/gold default) of catalogs/trains boxes in the available/installed apps tabs, to be easier to distinguish between catalog/train. [NAS-112065](https://jira.ixsystems.com/browse/NAS-112065)
- Add option for separators and whitespace in questions.yaml [NAS-110750](https://jira.ixsystems.com/browse/NAS-110750)
- Show App service internal DNS names in App Overview [NAS-112063](https://jira.ixsystems.com/browse/NAS-112063)
- Allow fields of type `text` in questions.yaml, instead of just `string` [NAS-112061](https://jira.ixsystems.com/browse/NAS-112061)


##### Backend suggestions

- Add ability to save and restore a PVC backup even on app delete [NAS-112066](https://jira.ixsystems.com/browse/NAS-112066)
- Add MetalLB Loadbalancer [NAS-111019](https://jira.ixsystems.com/browse/NAS-111019)
- Allow to auto update Apps [NAS-112056](https://jira.ixsystems.com/browse/NAS-112056)



### Priority: Low/Post-U1

##### GUI suggestions

- Add sorting options in app catalog. [NAS-112067](https://jira.ixsystems.com/browse/NAS-112067)
- Fix some of the themes to work with apps section. [NAS-112069](https://jira.ixsystems.com/browse/NAS-112069)
- Add ability to group apps. [NAS-112070](https://jira.ixsystems.com/browse/NAS-112070)
- Show statistics per app (cpu / network / ram) [NAS-112071](https://jira.ixsystems.com/browse/NAS-112071)
- Validate regex defined in questions.yaml when focus leaves input field. [NAS-112072](https://jira.ixsystems.com/browse/NAS-112072)
- Set custom message to display when `valid_chars` is not matched. [NAS-112073](https://jira.ixsystems.com/browse/NAS-112073)
- Make timezone searchable and sorted in Scale Apps installation [NAS-109524](https://jira.ixsystems.com/browse/NAS-109524)

##### Backend suggestions

- Allow `show_if` and `show_subquestions_if` to to use values for evaluation from parent variables [NAS-110751](https://jira.ixsystems.com/browse/NAS-110751)
- Add a feature to allow App creators to show a dropdown listing other Apps to connect to [NAS-112064](https://jira.ixsystems.com/browse/NAS-112064)
- Mount the PVC dataset to the host [NAS-112078](https://jira.ixsystems.com/browse/NAS-112078)


### Priority: Not sure if possible

- Add ability to set which app will start on boot (Auto start) [NAS-112076](https://jira.ixsystems.com/browse/NAS-112076)
- Add ability to set a delay before an app starts on boot (Delayed auto start) [NAS-112077](https://jira.ixsystems.com/browse/NAS-112077)
