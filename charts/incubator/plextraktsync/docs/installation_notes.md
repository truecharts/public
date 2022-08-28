# Installation Notes

- After installation, turn the chart off since it will not deploy the first time. This chart has enabled persistence for `/app/config` and in order to modify/add the files, you could use [truetool.sh](https://github.com/truecharts/truetool) to mount the pvc which is the easiest option available.

- shelling into the pod for this chart will **not** work initially.

- The upstream project decided that you have to run the same program temporarily on another system that can run commands to get the necessary files like `.env` and `.pytrakt.json` when authenticating for plex and `trakt.tv`.

- Grab your App's pin from trakt.tv and [authorize](https://trakt.tv/activate/authorize) the pin to activate the app.

- Here's [PlexTraktSync](https://github.com/Taxel/PlexTraktSync#setup) trakt.tv setup instructions.

- Here's [PlexTraktSync](https://github.com/Taxel/PlexTraktSync#installation) installation instructions.
