# App Addition Guidelines

Though we aim to be as open to contributions, at TrueCharts we still sometimes have to decide which Apps we do and do not add to our catalog. This document aims to give some guidelines in how we are going to make such decisions.

### Guidelines

##### Target Audience

- Our target audience is Home and SMB users
- While we currently support only one node, due to TrueNAS SCALE constraints, we aim for a maximum adviced deployment size of 10 Nodes and/or 50 Drives. This is in line with what we expect our target audience to be


##### Commercial vs non-commercial

- Apps that are only useable for paying customers are a no-go
- Apps that are trial-ware to non-paying customers are a no-go. Apps that have an enterprise option, that doesn't obstruct the open-core version are generally allowed
- Apps that are open-source are prefered over closed-source Apps. If opensource alternatives are available we might not approve a closed-source App.
- If a company or official maintainer submits an App, we expect them to maintain it themselves. We do not have the resources to work for external projects.

##### Update Policies and stability

- We expect Apps to have decent security (options) in place
- We expect Apps not to contain higher-level CVE's
- We prefer Apps that are actively maintained. Expect Apps that are abandoned (or barely maintained) for a year or more to even be removed, as we do not expect those to be secure.

##### App design

- Apps charts are expected to be kept as simple as possible, preferably using the common-chart where-ever possible.
- It's adviced to only deploy HA versions of apps if they are relatively simple. Complicated Apps (with addon operators and load balancers for example), should only be used in key area's because they are harder to maintain.
- We aim for a "1 App - 1 DB - 1 DB Instance" solution, because small single DB instances can be easily spread over multiple nodes in the future.
