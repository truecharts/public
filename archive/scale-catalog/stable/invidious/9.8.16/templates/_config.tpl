{{/* Define the configmap */}}
{{- define "invidious.secret" -}}

{{- $secretName := printf "%s-invidious-secret" (include "tc.v1.common.lib.chart.names.fullname" .) -}}

{{- $hmac := randAlphaNum 64 -}}
{{- with (lookup "v1" "Secret" .Release.Namespace $secretName) -}}
  {{- $hmac = (index .data "HMAC_KEY") | b64dec -}}
{{- end -}}

{{- $vNet := .Values.invidious.network }}
{{- $vLog := .Values.invidious.logging }}
{{- $vFeat := .Values.invidious.features }}
{{- $vUserAcc := .Values.invidious.users_accounts }}
{{- $vBgJobs := .Values.invidious.background_jobs }}
{{- $vJobs := .Values.invidious.jobs }}
{{- $vCaptca := .Values.invidious.captcha }}
{{- $vMisc := .Values.invidious.miscellaneous }}
{{- $vLoc := .Values.invidious.default_user_preferences.internationalization }}
{{- $vUI := .Values.invidious.default_user_preferences.interface }}
{{- $vVidBeh := .Values.invidious.default_user_preferences.video_player_behavior }}
{{- $vVidPlay := .Values.invidious.default_user_preferences.video_playback_settings }}
{{- $vSubFeed := .Values.invidious.default_user_preferences.subscription_feed }}
{{- $vUserMisc := .Values.invidious.default_user_preferences.miscellaneous }}
enabled: true
data:
  HMAC_KEY: {{ $hmac }}
  INVIDIOUS_CONFIG: |
    # Database
    check_tables: true
    db:
      user: {{ .Values.cnpg.main.user }}
      dbname: {{ .Values.cnpg.main.database }}
      password: {{ .Values.cnpg.main.creds.password | trimAll "\"" }}
      host: {{ .Values.cnpg.main.creds.host | trimAll "\"" }}
      port: 5432

    # Network
    host_binding: 0.0.0.0
    port: {{ .Values.service.main.ports.main.port }}
    external_port: {{ $vNet.inbound.external_port }}
    https_only: {{ $vNet.inbound.https_only }}
    domain: {{ $vNet.inbound.domain }}
    hsts: {{ $vNet.inbound.hsts }}
    disable_proxy: {{ $vNet.outbound.disable_proxy }}
    pool_size: {{ $vNet.outbound.pool_size }}
    use_quic: {{ $vNet.outbound.use_quic }}
    cookies: {{ join "; " $vNet.outbound.cookies }}
    force_resolve: {{ $vNet.outbound.force_resolve }}

    # Logging
    output: {{ $vLog.output }}
    log_level: {{ $vLog.log_level }}

    # Features
    popular_enabled: {{ $vFeat.popular_enabled }}
    statistics_enabled: {{ $vFeat.statistics_enabled }}

    # Users and Accounts
    registration_enabled: {{ $vUserAcc.registration_enabled }}
    login_enabled: {{ $vUserAcc.login_enabled }}
    captcha_enabled: {{ $vUserAcc.captcha_enabled }}
    {{- if $vUserAcc.admins }}
    admins:
      {{- range $vUserAcc.admins }}
      - {{ . }}
      {{- end }}
    {{- else }}
    admins: [""]
    {{- end }}
    enable_user_notifications: {{ $vUserAcc.enable_user_notifications }}

    # Background Jobs
    channel_threads: {{ $vBgJobs.channel_threads }}
    channel_refresh_interval: {{ $vBgJobs.channel_refresh_interval }}
    full_refresh: {{ $vBgJobs.full_refresh }}
    feed_threads: {{ $vBgJobs.feed_threads }}
    decrypt_polling: {{ $vBgJobs.decrypt_polling }}

    # Jobs
    jobs:
      clear_expired_items:
        enable: {{ $vJobs.clear_expired_items.enable }}
      refresh_channels:
        enable: {{ $vJobs.refresh_channels.enable }}
      refresh_feeds:
        enable: {{ $vJobs.refresh_feeds.enable }}

    # Captcha
    captcha_api_url: {{ $vCaptca.captca_api_url }}
    captcha_key: {{ $vCaptca.captca_key }}

    # Miscellaneaous
    banner: {{ $vMisc.banner }}
    use_pubsub_feeds: {{ $vMisc.use_pubsub_feeds }}
    hmac_key: {{ $hmac }}
    {{- if $vMisc.dmca_content }}
    dmca_content:
      {{- range $vMisc.dmca_content }}
      - {{ . }}
      {{- end }}
    {{- else }}
    dmca_content: [""]
    {{- end }}
    cache_annotations: {{ $vMisc.cache_annotations }}
    playlist_length_limit: {{ $vMisc.playlist_length_limit }}
    modified_source_code_url: ""

    # Default User Preferences
    default_user_preferences:

      # Internationalization
      locale: {{ $vLoc.locale }}
      region: {{ $vLoc.region }}
      {{- with $vLoc.captions -}}
        {{- if ne (len .) 3 -}}
          {{- fail "Exactly 3 entries are required for Captions" -}}
        {{- end }}
      captions:
        {{- range $c := . }}
        - {{ $c }}
        {{- end -}}
      {{- else }}
      captions: ["","",""]
      {{- end }}

      # Interface
      dark_mode: {{ $vUI.dark_mode }}
      thin_mode: {{ $vUI.thin_mode }}
      {{- with $vUI.feed_menu }}
        {{- if gt (len . ) 4 -}}
          {{- fail "Max 4 Feed menu items are accepted" -}}
        {{- end }}
      feed_menu:
        {{- range $f := . }}
        - {{ $f }}
        {{- end -}}
      {{- else }}
      feed_menu: ["Popular", "Trending", "Subscriptions", "Playlists"]
      {{- end }}
      default_home: {{ $vUI.default_home }}
      max_results: {{ $vUI.max_results }}
      annotations: {{ $vUI.annotations }}
      annotations_subscribed: {{ $vUI.annotations_subscribed }}
      {{- with $vUI.comments }}
        {{- if ne (len .) 2 -}}
          {{- fail "Exactly 2 entries are required for comments" -}}
        {{- end }}
      comments:
        {{- range $c := . }}
        - {{ $c }}
        {{- end }}
      {{- else }}
      comments: ["youtube", ""]
      {{- end }}
      player_style: {{ $vUI.player_style }}
      related_videos: {{ $vUI.related_videos }}

      # Video Player Behaviour
      autoplay: {{ $vVidBeh.autoplay }}
      continue: {{ $vVidBeh.continue }}
      continue_autoplay: {{ $vVidBeh.continue_autoplay }}
      listen: {{ $vVidBeh.listen }}
      video_loop: {{ $vVidBeh.video_loop }}

      # Video Playback Settigns
      quality: {{ $vVidPlay.quality }}
      quality_dash: {{ $vVidPlay.quality_dash }}
      speed: {{ printf "%.2f" ($vVidPlay.speed | float64) }}
      volume: {{ $vVidPlay.volume }}
      vr_mode: {{ $vVidPlay.vr_mode }}

      # Subscription Feed
      latest_only: {{ $vSubFeed.latest_only }}
      notifications_only: {{ $vSubFeed.notifications_only }}
      unseen_only: {{ $vSubFeed.unseen_only }}
      sort: {{ $vSubFeed.sort }}

      # Miscellaneous
      local: {{ $vUserMisc.local }}
      show_nick: {{ $vUserMisc.show_nick }}
      automatic_instance_redirect: {{ $vUserMisc.automatic_instance_redirect }}
      extend_desc: {{ $vUserMisc.extend_desc }}
{{- end -}}
