---
title: Installation Notes
---

Set the `IGDB_CLIENT_ID` and `IGDB_CLIENT_SECRET` with the API key from [IGDB](https://api-docs.igdb.com/#about).

## Optional API

`STEAMGRIDDB_API_KEY` and/or `MOBYGAMES_API_KEY` API Key can be optionally set for additional metadata.

MobyGames API is no longer free.


## Rom Library Structure

This app has two folder structures found [here](https://github.com/zurdi15/romm/blob/master/README.md#-folder-structure).

Structure 1 (high priority) - roms folder at root of library folder:

Just set the library PVC to hostpath or nfs mount.

```shell
library/
├─ roms/
   ├─ gbc/
   │  ├─ rom_1.gbc
   │  ├─ rom_2.gbc
   │
   ├─ gba/
   │  ├─ rom_1.gba
   │  ├─ rom_2.gba
   │
   ├─ ps/
      ├─ my_multifile_game/
      │   ├─ my_game_cd1.iso
      │   ├─ my_game_cd2.iso
      │
      ├─ rom_1.iso
```

Structure 2 (low priority) - roms folder inside each platform folder

```shell
library/
├─ gbc/
│  ├─ roms/
│     ├─ rom_1.gbc
│     ├─ rom_2.gbc
|
├─ gba/
│  ├─ roms/
│     ├─ rom_1.gba
│     ├─ rom_2.gba
|
├─ ps/
│  ├─ roms/
│     ├─ my_multifile_game/
│     │  ├─ my_game_cd1.iso
│     │  ├─ my_game_cd2.iso
│     │
│     ├─ rom_1.iso
```
