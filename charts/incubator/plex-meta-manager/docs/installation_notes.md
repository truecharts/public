# Installation Notes

## setup ENV variables

- Set `PMM_RUN` as **true** to run immediately bypassing `PMM_TIME`.

- however disabling `PMM_RUN` will show the options to set a time for `PMM_TIME` with a comma-separated list in HH:MM format(ex: **06:00,18:00**) and `PMM_NO_COUNTDOWN` set to **true** to run without displaying a countdown to the next scheduled run.

Additional env are available [here](https://metamanager.wiki/en/latest/home/environmental.html#run-commands-environment-variables)

## configuration file setup

an example [config.yml](https://metamanager.wiki/en/latest/config/configuration.html#configuration-file-walkthrough):

```yaml
libraries:                                      # This is called out once within the config.yml file                                       
  Movies:                                       # Each library must match the Plex library name
    metadata_path:
      - file: config/Movies.yml                 # This is a local file on the system
      - folder: config/Movies/                  # This is a local directory on the system
      - git: PMM/chart/basic                    # This is a file within the https://github.com/meisnate12/Plex-Meta-Manager-Configs Repository
      - git: PMM/chart/imdb                     # This is a file within the https://github.com/meisnate12/Plex-Meta-Manager-Configs Repository
    overlay_path:
      - remove_overlays: false                  # Set this to true to remove all overlays
      - file: config/Overlays.yml               # This is a local file on the system
      - git: PMM/overlays/imdb_top_250          # This is a file within the https://github.com/meisnate12/Plex-Meta-Manager-Configs Repository
  TV Shows:                           
    metadata_path:
      - file: config/TVShows.yml
      - folder: config/TV Shows/
      - git: PMM/chart/basic                    # This is a file within the https://github.com/meisnate12/Plex-Meta-Manager-Configs Repository
      - git: PMM/chart/imdb                     # This is a file within the https://github.com/meisnate12/Plex-Meta-Manager-Configs Repository
    overlay_path:
      - remove_overlays: false                  # Set this to true to remove all overlays
      - file: config/Overlays.yml               # This is a local file on the system
      - git: PMM/overlays/imdb_top_250          # This is a file within the https://github.com/meisnate12/Plex-Meta-Manager-Configs Repository
  Anime:
    metadata_path:
      - file: config/Anime.yml
      - git: PMM/chart/basic                    # This is a file within the https://github.com/meisnate12/Plex-Meta-Manager-Configs Repository
      - git: PMM/chart/anilist                  # This is a file within the https://github.com/meisnate12/Plex-Meta-Manager-Configs Repository
  Music:
    metadata_path:
      - file: config/Music.yml
playlist_files:
  - file: config/playlists.yml       
  - git: PMM/playlist                           # This is a file within the https://github.com/meisnate12/Plex-Meta-Manager-Configs Repository
settings:
  cache: true
  cache_expiration: 60
  asset_directory: config/assets
  asset_folders: true
  asset_depth: 0
  create_asset_folders: false
  dimensional_asset_rename: false
  download_url_assets: false
  show_missing_season_assets: false
  show_missing_episode_assets: false
  show_asset_not_needed: true
  sync_mode: append
  minimum_items: 1
  default_collection_order:
  delete_below_minimum: true
  delete_not_scheduled: false
  run_again_delay: 2
  missing_only_released: false
  only_filter_missing: false
  show_unmanaged: true
  show_filtered: false
  show_options: false
  show_missing: true
  show_missing_assets: true
  save_report: true
  tvdb_language: eng
  ignore_ids:
  ignore_imdb_ids:
  item_refresh_delay: 0
  playlist_sync_to_users: all
  verify_ssl: true
webhooks:
  error:
  run_start:
  run_end:
  changes:
    version:
plex:
  url: http://192.168.1.12:32400
  token: ####################
  timeout: 60
  clean_bundles: false
  empty_trash: false
  optimize: false
tmdb:
  apikey: ################################
  language: en
tautulli:
  url: http://192.168.1.12:8181
  apikey: ################################
omdb:
  apikey: ########
notifiarr:
  apikey: ####################################
anidb:
  username: ######
  password: ######
radarr:
  url: http://192.168.1.12:7878
  token: ################################
  add_missing: false
  add_existing: false
  root_folder_path: S:/Movies
  monitor: true
  availability: announced
  quality_profile: HD-1080p
  tag:
  search: false
  radarr_path:
  plex_path:
sonarr:
  url: http://192.168.1.12:8989
  token: ################################
  add_missing: false
  add_existing: false
  root_folder_path: "S:/TV Shows"
  monitor: all
  quality_profile: HD-1080p
  language_profile: English
  series_type: standard
  season_folder: true
  tag:
  search: false
  cutoff_search: false
  sonarr_path:
  plex_path:
trakt:
  client_id: ################################################################
  client_secret: ################################################################
  authorization:
    # everything below is autofilled by the script
    access_token:
    token_type:
    expires_in:
    refresh_token:
    scope: public
    created_at:
mal:
  client_id: ################################
  client_secret: ################################################################
  authorization:
    # everything below is autofilled by the script
    access_token:
    token_type:
    expires_in:
    refresh_token
```
