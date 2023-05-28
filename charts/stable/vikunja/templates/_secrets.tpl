{{/* Define the secrets */}}
{{- define "vikunja.secrets" -}}

{{- $secretStorage := printf "%s-storage-secret" (include "tc.v1.common.lib.chart.names.fullname" .) -}}
{{- $pgHost := printf "%v-cnpg-main-rw" (include "tc.v1.common.lib.chart.names.fullname" $) -}}
{{- $jwtSecret := randAlphaNum 32 -}}
{{- with lookup "v1" "Secret" .Release.Namespace $secretStorage -}}
  {{- $jwtSecret = index .data "JWT_SECRET" | b64dec -}}
{{- end }}
secret:
  secret-storage:
    enabled: true
    data:
      JWT_SECRET: {{ $jwtSecret }}

  config:
    enabled: true
    data:
      config.yaml: |
        database:
          type: postgres
          user: {{ .Values.cnpg.main.user }}
          password: {{ .Values.cnpg.main.creds.password | trimAll "\"" }}
          host: {{ $pgHost }}

        cache:
          enabled: true
          type: redis

        redis:
          enabled: true
          host: {{ printf "%v-%v:%v" .Release.Name "redis" "6379" }}
          password: {{ .Values.redis.creds.redisPassword | trimAll "\""}}
          db: 0

        keyvalue:
          type: redis

        service:
          interface: ":3456"
          JWTSecret: {{ $jwtSecret }}
          timezone: {{ .Values.TZ | quote }}
          {{- /* Multiply by 1, so large integers are not rendered in scientific notation
            See: https://github.com/helm/helm/issues/1707#issuecomment-1167860346 */}}
          jwtttl: {{ mul .Values.vikunja.service.jwtttl 1 }}
          jwtttllong: {{ mul .Values.vikunja.service.jwtttllong 1 }}
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

        metrics:
          enabled: {{ .Values.metrics.enabled }}

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

        log:
          enabled: {{ .Values.vikunja.log.enabled }}
          path: {{ .Values.vikunja.log.path | quote }}
          standard: {{ .Values.vikunja.log.standard | quote }}
          level: {{ .Values.vikunja.log.level | quote }}
          database: {{ .Values.vikunja.log.database | quote }}
          databaselevel: {{ .Values.vikunja.log.databaselevel | quote }}
          http: {{ .Values.vikunja.log.http | quote }}
          echo: {{ .Values.vikunja.log.echo | quote }}
          events: {{ .Values.vikunja.log.events | quote }}
          eventslevel: {{ .Values.vikunja.log.eventslevel | quote }}

        ratelimit:
          enabled: {{ .Values.vikunja.ratelimit.enabled }}
          kind: {{ .Values.vikunja.ratelimit.kind | quote }}
          period: {{ .Values.vikunja.ratelimit.period }}
          limit: {{ .Values.vikunja.ratelimit.limit }}
          store: redis

        files:
          maxsize: {{ .Values.vikunja.files.maxsize }}

        avatar:
          gravatarexpiration: {{ .Values.vikunja.avatar.gravatarexpiration }}

        legal:
          imprinturl: {{ .Values.vikunja.legal.imprinturl | quote }}
          privacyurl: {{ .Values.vikunja.legal.privacyurl | quote }}

        backgrounds:
          enabled: {{ .Values.vikunja.backgrounds.enabled }}
          providers:
            upload:
              enabled: {{ .Values.vikunja.backgrounds.providers.upload.enabled }}
            unsplash:
              enabled: {{ .Values.vikunja.backgrounds.providers.unsplash.enabled }}
              accesstoken: {{ .Values.vikunja.backgrounds.providers.unsplash.accesstoken | quote }}
              applicationid: {{ .Values.vikunja.backgrounds.providers.unsplash.applicationid | quote }}

        migration:
          todoist:
            enable: {{ .Values.vikunja.migration.todoist.enable }}
            clientid: {{ .Values.vikunja.migration.todoist.clientid | quote }}
            clientsecret: {{ .Values.vikunja.migration.todoist.clientsecret | quote }}
            redirecturl: {{ .Values.vikunja.migration.todoist.redirecturl | quote }}
          trello:
            enable: {{ .Values.vikunja.migration.trello.enable }}
            key: {{ .Values.vikunja.migration.trello.key | quote }}
            redirecturl: {{ .Values.vikunja.migration.trello.redirecturl | quote }}
          microsofttodo:
            enable: {{ .Values.vikunja.migration.microsofttodo.enable }}
            clientid: {{ .Values.vikunja.migration.microsofttodo.clientid | quote }}
            clientsecret: {{ .Values.vikunja.migration.microsofttodo.clientsecret | quote }}
            redirecturl: {{ .Values.vikunja.migration.microsofttodo.redirecturl | quote }}

        auth:
          local:
            enabled: {{ .Values.vikunja.auth.local.enabled }}
          openid:
            enabled: {{ .Values.vikunja.auth.openid.enabled }}
            {{- with .Values.vikunja.auth.openid.redirecturl }}
            redirecturl: {{ . | quote }}
            {{- end }}
            {{- with .Values.vikunja.auth.openid.providers }}
            providers:
              {{- range . }}
              - name: {{ .name | quote }}
                authurl: {{ .authurl | quote }}
                {{- with .logouturl }}
                logouturl: {{ . | quote }}
                {{- end }}
                clientid: {{ .clientid | quote }}
                clientsecret: {{ .clientsecret | quote }}
              {{- end }}
            {{- end }}

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
          {{- with .Values.vikunja.defaultsettings.language }}
          language: {{ . | quote }}
          {{- end }}
          {{- with .Values.vikunja.defaultsettings.timezone }}
          timezone: {{ . | quote }}
          {{- end }}

configmap:
  nginx-config:
    enabled: true
    data:
      nginx-config: |
        server {
          listen {{ .Values.service.main.ports.main.port }};
          location / {
              proxy_pass http://localhost:80;
          }
          location ~* ^/(api|dav|\.well-known)/ {
              proxy_pass http://localhost:3456;
              client_max_body_size {{ .Values.vikunja.files.maxsize | upper | trimSuffix "B" }};
          }
        }
{{- end -}}
