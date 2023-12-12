{{/* Define the configs */}}
{{- define "synapse.config" -}}
---
apiVersion: v1
kind: ConfigMap
metadata:
  name: synapse-config
  labels:
  {{ include "tc.common.labels" . | nindent 4 }}
  annotations:
    rollme: {{ randAlphaNum 5 | quote }}
data:
  homeserver.yaml: |
    server_name: {{ .Values.matrix.serverName }}
    pid_file: /data/homeserver.pid
    public_baseurl: {{ include "matrix.baseUrl" . | quote }}

    {{- if .Values.matrix.clientBaseURL -}}
    # Client Base URL, Formerly riot_base_url
    client_base_url: {{ .Values.matrix.clientBaseURL }}
    {{- end}}

    use_presence: {{ .Values.matrix.presence }}

    allow_public_rooms_over_federation: {{ and .Values.matrix.federation.enabled .Values.matrix.federation.allowPublicRooms }}

    block_non_admin_invites: {{ .Values.matrix.blockNonAdminInvites }}

    enable_search: {{ .Values.matrix.search }}

    {{- if .Values.matrix.federation.whitelist }}
    federation_domain_whitelist:
        {{- range .Values.matrix.federation.whitelist }}
        - {{ . }}
        {{- end }}
    {{- end}}

    federation_ip_range_blacklist:
    {{- range .Values.matrix.federation.blacklist }}
        - {{ . }}
    {{- end }}

    listeners:
      - port: 8008
        tls: false
        type: http
        x_forwarded: true
        bind_addresses: ['0.0.0.0']
        resources:
          - names: [client, federation]
            compress: false

    {{- if .Values.synapse.metrics.enabled }}
      - type: metrics
        port: {{ .Values.synapse.metrics.port }}
        bind_addresses: ['0.0.0.0']
        resources:
          - names: [metrics]
    {{- end }}

    admin_contact: 'mailto:{{ .Values.matrix.adminEmail }}'
    hs_disabled: {{ .Values.matrix.disabled }}
    hs_disabled_message: {{ .Values.matrix.disabledMessage }}
    redaction_retention_period: {{ .Values.matrix.retentionPeriod }}

    log_config: "/data/{{ .Values.matrix.serverName }}.log.config"
    media_store_path: "/data/media_store"
    uploads_path: "/data/uploads"
    max_upload_size: {{ .Values.matrix.uploads.maxSize }}
    max_image_pixels: {{ .Values.matrix.uploads.maxPixels }}
    url_preview_enabled: {{ .Values.matrix.urlPreviews.enabled }}

    {{- if .Values.coturn.enabled -}}
    {{- if not (empty .Values.coturn.uris) }}
    turn_uris:
        {{- range .Values.coturn.uris }}
        - {{ . }}
        {{- end }}
    {{- else }}
    turn_uris:
      - "turn:{{ include "matrix.hostname" . }}?transport=udp"
    {{- end }}
    turn_user_lifetime: 1h
    turn_allow_guests: {{ .Values.coturn.allowGuests }}
    {{- end }}

    enable_registration: {{ .Values.matrix.registration.enabled }}

    {{- if .Values.matrix.registration.enabled }}
    registration_requires_token: {{ .Values.matrix.registration.requiresToken }}

    {{- if .Values.matrix.registration.require3PID }}
    {{/* It seems toYaml doesn't work on lists/arrays */}}
    registrations_require_3pid: {{- print " " -}}{{ .Values.matrix.registration.require3PID | toJson }}
    {{- end }}

    disable_msisdn_registration: {{ .Values.matrix.registration.disableMSISDNRegistration }}
    enable_3pid_lookup: {{ .Values.matrix.registration.enable3PIDLookup }}

    {{- if .Values.matrix.registration.allowedLocal3PIDs }}
    {{/* It seems toYaml doesn't work on lists/arrays */}}
    allowed_local_3pids: {{- print " " -}}{{ .Values.matrix.registration.allowedLocal3PIDs | toJson }}
    {{- end }}

    {{- end }}

    allow_guest_access: {{ .Values.matrix.registration.allowGuests }}

    {{- if .Values.synapse.metrics.enabled }}
    enable_metrics: true
    {{- end }}

    report_stats: false

    {{- if .Values.synapse.appConfig }}
    app_service_config_files:
    {{- range .Values.synapse.appConfig }}
      - {{ . }}
    {{- end }}
    {{- end }}

    signing_key_path: "/data/keys/{{ .Values.matrix.serverName }}.signing.key"

    {{- if .Values.matrix.security.trustedKeyServers }}
    trusted_key_servers:
        {{- range .Values.matrix.security.trustedKeyServers }}
        - server_name: {{ .serverName }}
          {{- if .verifyKeys }}
          verify_keys:
            {{- range .verifyKeys }}
              {{ .id | quote }}: {{ .key | quote }}
            {{- end }}
          {{- end }}
          {{- if .acceptKeysInsecurely }}
          accept_keys_insecurely: {{ .acceptKeysInsecurely }}
          {{- end }}
        {{- end }}
    {{- end }}

    suppress_key_server_warning: {{ .Values.matrix.security.supressKeyServerWarning }}
  {{- if not .Values.synapse.loadCustomConfig }}
  custom.yaml: |
    # PLACEHOLDER
  {{- end }}

  {{ .Values.matrix.serverName }}.log.config: |
    version: 1

    formatters:
      precise:
        format: '%(asctime)s - %(name)s - %(lineno)d - %(levelname)s - %(request)s - %(message)s'

    filters:
      context:
        (): synapse.util.logcontext.LoggingContextFilter
        request: ""

    handlers:
      console:
        class: logging.StreamHandler
        formatter: precise
        filters: [context]

    loggers:
      synapse:
        level: {{ .Values.matrix.logging.synapseLogLevel }}

      synapse.storage.SQL:
        # beware: increasing this to DEBUG will make synapse log sensitive
        # information such as access tokens.
        level: {{ .Values.matrix.logging.sqlLogLevel }}


    root:
      level: {{ .Values.matrix.logging.rootLogLevel }}
      handlers: [console]
{{- end }}
