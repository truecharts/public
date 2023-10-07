{{- define "plexanisync.secret" -}}

{{- $pas := .Values.plexanisync -}}
{{- $cm := .Values.custom_mappings }}

enabled: true
data:
  settings.ini: |
    [PLEX]
    anime_section = {{ join "|" $pas.plex.anime_section }}

    authentication_method = {{ $pas.plex.plex_auth_method }}

    {{- if eq $pas.plex.plex_auth_method "direct" }}
    base_url = {{ $pas.plex.plex_url }}
    token = {{ $pas.plex.plex_token }}
    {{- end }}

    {{- if eq $pas.plex.plex_auth_method "myplex" }}
    server = {{ $pas.plex.myplex_server_name }}
    myplex_user = {{ $pas.plex.myplex_user }}
    myplex_token = {{ $pas.plex.myplex_token }}
    {{- end }}

    home_user_sync = {{ ternary "True" "False" $pas.plex.home_user_sync }}
    {{- if $pas.plex.home_user_sync }}
    home_username = {{ $pas.plex.home_username }}
    home_server_base_url = {{ $pas.plex.home_server_url }}
    {{- end }}

    [ANILIST]
    access_token = {{ $pas.anilist.ani_token }}
    plex_episode_count_priority = {{ ternary "True" "False" $pas.anilist.plex_ep_count_priority }}
    skip_list_update = {{ ternary "True" "False" $pas.anilist.skip_list_update }}
    username = {{ $pas.anilist.ani_username }}
    log_failed_matches = {{ ternary "True" "False" $pas.anilist.log_failed_matches }}

  custom_mappings.yaml: |
    # https://github.com/RickDB/PlexAniSync/blob/master/custom_mappings.yaml.example
  {{- if $cm }}
    {{- with $cm.remote_urls }}
    remote-urls:
      {{- range $url := . }}
      - {{ . | quote }}
      {{- end }}
    {{- end -}}

    {{- with $cm.entries }}
    entries:
      {{- range $entry := . }}
      - title: {{ $entry.title | quote }}
        {{- with $entry.seasons }}
        seasons:
          {{- range $season_entry := . }}
          - season: {{ $season_entry.season }}
            anilist-id: {{ $season_entry.anilist_id }}
          {{- end }}
        {{- end -}}
        {{- with $entry.synonyms }}
        synonyms:
          {{- range $synonym := . }}
          - {{ . | quote }}
          {{- end }}
        {{- end }}
      {{- end }}
    {{- end -}}
  {{- end -}}
{{- end -}}
