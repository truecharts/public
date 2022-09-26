# Installation notes

## Credentials

Default username: `akadmin`

## Outposts

Enable each outpost by simple setting `enabled` to `true`.
Scale users, just have to check the checkbox

> You have to create an outpost in the GUI first.
> And afterwards enable it.
> Applications > Outposts

### Host

`host` should not need to be overridden. Defaults to `https://localhost:9443`

### Host Browser

`host_browser` by default is set to the first ingress host you set

### Token

`token` is only needed if you accidentally deleted the bootstrap token within the UI.

> You can get one from Applications > Outposts > View Deployment Info
