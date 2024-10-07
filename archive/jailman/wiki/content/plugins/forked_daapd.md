# forked-dappd

This plugin installs forked-daapd with a current version of ffmpeg.
As it compiles ffmepg from sources the initialisation takes a while (~25 minutes
on a Xeon E3-1230 v5 @ 3.40GHz).

#### Configuration parameters

- itunes_media: Path to your itunes media that will be mounted in the jail. (ex. /mnt/tank/media/music/itunes/)

`forked-daapd` needs to know the location of your iTunes Library. Add a `itunes_media:`
section to your `config.yaml` with the  path to your itunes library as value.
