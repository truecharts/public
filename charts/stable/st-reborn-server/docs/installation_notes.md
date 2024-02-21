---
title: Installation Notes
---

## The location of STServer.ini

It will be located in the internal directory:
/home/server/config

## Editing STServer.ini

The default STServer.ini config file will look like this:

```yaml
[general]
sLogLevel=info # Logs everything
bConsole=true # Enables interactive console is enabled or not


[LiveServices]
bAnnounceServer=true # Makes it show on the global server list


[Gameplay]
fGoldLossFactor=0 # Disables players losing gold on deaths
bEnablePvp=true # Enables PVP
bEnableGreetings=false # Disables NPCs greeting
uDifficulty=5 # Setting the difficulty level at Legendary


[ModPolicy]
bAllowMO2=true # Allows using ModOrganizer2
bAllowSKSE=true # Allows SKSE
bEnableModCheck=false # Disables verifying connecting users loadorder.txt (more on that later)


[GameServer]
sPassword=mySuperServerPassword # Setting the password to mySuperServerPassword
sAdminPassword=thisdoesntmatter # Setting the admin password to thisdoesntmatter
sServerName=My Very Best Server # Setting the server name to be "My Very Best Server"
bPremiumMode=true # Setting the tickrate to 60
uPort=10578 # Setting the port to 10578 (important!)
```

for more info checkout the source [guide](https://wiki.tiltedphoques.com/tilted-online/guides/server-guide/server-configuration)
