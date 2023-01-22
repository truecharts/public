{{/* Define the secrets */}}
{{- define "vikunja.secrets" -}}

{{- $secretName := printf "%s-secret" (include "tc.common.names.fullname" .) -}}
{{- $secretStorage := printf "%s-storage-secret" (include "tc.common.names.fullname" .) -}}

{{- $jwtSecret := randAlphaNum 32 -}}
{{- with lookup "v1" "Secret" .Release.Namespace $secretStorage -}}
  {{- $jwtSecret = index .data "JWT_SECRET" | b64dec -}}
{{- end }}
---
apiVersion: v1
kind: Secret
type: Opaque
metadata:
  name: {{ $secretStorage }}
  labels:
    {{- include "tc.common.labels" . | nindent 4 }}
data:
  JWT_SECRET: {{ $jwtSecret | b64enc }}
---
apiVersion: v1
kind: Secret
type: Opaque
metadata:
  name: {{ $secretName }}
  labels:
    {{- include "tc.common.labels" . | nindent 4 }}
stringData:
  config.yml: |
    database:
      type: postgres
      user: {{ .Values.postgresql.postgresqlUsername }}
      password: {{ .Values.postgresql.postgresqlPassword | trimAll "\"" }}
      host: {{ printf "%v-%v" .Release.Name "postgres" }}

    cache:
      enabled: true
      type: redis

    redis:
      enabled: true
      host: {{ printf "%v-%v:%v" .Release.Name "redis" "6379" }}
      password: {{ .Values.redis.redisPassword | trimAll "\""}}
      db: 0

    keyvalue:
      type: redis

    metrics:
      enabled: {{ .Values.vikunja.metrics.enabled }}
      username: {{ .Values.vikunja.metrics.username | quote }}
      password: {{ .Values.vikunja.metrics.password | quote }}
      {{ include "vikunja.extra" (dict "curr" .Values.vikunja.metrics "extra" .Values.vikunja.metricsExtra) | nindent 4 }}

    cors:
      enabled: {{ .Values.vikunja.cors.enabled }}
      {{- with .Values.vikunja.cors.origins }}
      origins:
        {{- range . }}
        - {{ . | quote }}
        {{- end }}
      {{- else }}
      origins: []
      {{- end }}
      maxage: {{ .Values.vikunja.cors.maxage }}
      {{ include "vikunja.extra" (dict "curr" .Values.vikunja.cors "extra" .Values.vikunja.corsExtra) | nindent 4 }}

    mailer:
      enabled: {{ .Values.vikunja.mailer.enabled }}
      host: {{ .Values.vikunja.mailer.host | quote }}
      port: {{ .Values.vikunja.mailer.port }}
      authtype: {{ .Values.vikunja.mailer.authtype | quote }}
      username: {{ .Values.vikunja.mailer.username | quote }}
      password: {{ .Values.vikunja.mailer.password | quote }}
      skiptlsverify: {{ .Values.vikunja.mailer.skiptlsverify }}
      fromemail: {{ .Values.vikunja.mailer.fromemail | quote }}
      queuelength: {{ .Values.vikunja.mailer.queuelength }}
      queuetimeout: {{ .Values.vikunja.mailer.queuetimeout }}
      forcessl: {{ .Values.vikunja.mailer.forcessl }}
      {{ include "vikunja.extra" (dict "curr" .Values.vikunja.mailer "extra" .Values.vikunja.mailerExtra) | nindent 4 }}

    log:
      enabled: {{ .Values.vikunja.log.enabled }}
      standard: {{ .Values.vikunja.log.standard | quote }}
      level: {{ .Values.vikunja.log.level | quote }}
      database: {{ ternary "off" "on" .Values.vikunja.log.database | quote }}}
      databaselevel: {{ .Values.vikunja.log.databaselevel | quote }}
      http: {{ .Values.vikunja.log.http | quote }}
      echo: {{ ternary "off" "on" .Values.vikunja.log.echo | quote }}}
      events: {{ .Values.vikunja.log.events | quote }}
      eventslevel: {{ .Values.vikunja.log.eventslevel | quote }}
      {{ include "vikunja.extra" (dict "curr" .Values.vikunja.log "extra" .Values.vikunja.logExtra) | nindent 4 }}

    ratelimit:
      enabled: {{ .Values.vikunja.ratelimit.enabled }}}
      kind: {{ .Values.vikunja.ratelimit.kind | quote }}
      period: {{ .Values.vikunja.ratelimit.period }}
      limit: {{ .Values.vikunja.ratelimit.limit }}
      store: redis
      {{ include "vikunja.extra" (dict "curr" .Values.vikunja.ratelimit "extra" .Values.vikunja.ratelimitExtra "disallow" (list "store")) | nindent 4 }}

    files:
      maxsize: {{ .Values.vikunja.files.maxsize }}
      {{ include "vikunja.extra" (dict "curr" .Values.vikunja.files "extra" .Values.vikunja.filesExtra) | nindent 4 }}

    avatar:
      gravatarexpiration: {{ .Values.vikunja.avatar.gravatarexpiration }}
      {{ include "vikunja.extra" (dict "curr" .Values.vikunja.avatar "extra" .Values.vikunja.avatarExtra) | nindent 4 }}

    legal:
      imprinturl: {{ .Values.vikunja.legal.imprinturl | quote }}
      privacyurl: {{ .Values.vikunja.legal.privacyurl | quote }}
      {{ include "vikunja.extra" (dict "curr" .Values.vikunja.legal "extra" .Values.vikunja.legalExtra) | nindent 4 }}

    service:
      interface: {{ .Values.vikunja.service.interface | quote }}
      JWTSecret: {{ $jwtSecret }}
      timezone: {{ .Values.TZ | quote }}
      jwtttl: {{ .Values.vikunja.service.jwtttl | int }}
      jwtttllong: {{ .Values.vikunja.service.jwtttllong | int }}
      frontendurl: {{ .Values.vikunja.service.frontendurl | quote }}
      maxitemsperpage: {{ .Values.vikunja.service.maxitemsperpage }}
      enablecaldav: {{ .Values.vikunja.service.enablecaldav }}
      motd: {{ .Values.vikunja.service.motd | quote }}
      enablelinksharing: {{ .Values.vikunja.service.enablelinksharing }}
      enableregistration: {{ .Values.vikunja.service.enableregistration }}
      enabletaskattachments: {{ .Values.vikunja.service.enabletaskattachments }}
      enabletaskcomments: {{ .Values.vikunja.service.enabletaskcomments }}
      enabletotp: {{ .Values.vikunja.service.enabletotp }}
      enableemailreminders: {{ .Values.vikunja.service.enableemailreminders }}
      enableuserdeletion: {{ .Values.vikunja.service.enableuserdeletion }}
      maxavatarsize: {{ .Values.vikunja.service.maxavatarsize }}
      {{ include "vikunja.extra" (dict "curr" .Values.vikunja.service "extra" .Values.vikunja.serviceExtra) | nindent 4 }}
    defaultsettings:
      avatar_provider: {{ .Values.vikunja.defaultsettings.avatar_provider | quote }}
      avatar_file_id: {{ .Values.vikunja.defaultsettings.avatar_file_id }}
      email_reminders_enabled: {{ .Values.vikunja.defaultsettings.email_reminders_enabled }}
      discoverable_by_name: {{ .Values.vikunja.defaultsettings.discoverable_by_name }}
      discoverable_by_email: {{ .Values.vikunja.defaultsettings.discoverable_by_email }}
      overdue_tasks_reminders_enabled: {{ .Values.vikunja.defaultsettings.overdue_tasks_reminders_enabled }}
      overdue_tasks_reminders_time: {{ .Values.vikunja.defaultsettings.overdue_tasks_reminders_time | quote }}
      default_list_id: {{ .Values.vikunja.defaultsettings.default_list_id }}
      week_start: {{ .Values.vikunja.defaultsettings.week_start }}
      language: {{ .Values.vikunja.defaultsettings.language | quote }}
      timezone: {{ .Values.vikunja.defaultsettings.timezone | quote }}
      {{ include "vikunja.extra" (dict "curr" .Values.vikunja.defaultsettings "extra" .Values.vikunja.defaultsettingsExtra) | nindent 4 }}
{{- end -}}

{{- define "vikunja.extra" -}}
  {{- $curr := .curr -}}
  {{- $extra := .extra -}}
  {{- $disallow := .disallow -}}

  {{- $keys := $curr | keys -}}
  {{- range $k, $v := $extra -}}
    {{- if mustHas $k $keys -}}
      {{- fail (printf "Key (%s) can already be configured from the provided interface" $k) -}}
    {{- end -}}

    {{- if mustHas $k $disallow -}}
      {{- fail (printf "Key (%s) is not allowed to be altered" $k) -}}
    {{- end -}}

    {{ $k }}: {{ $v }}
  {{- end -}}
{{- end -}}
