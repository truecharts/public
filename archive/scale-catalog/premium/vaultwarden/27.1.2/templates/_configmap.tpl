{{/* Define the configmap */}}
{{- define "vaultwarden.configmap" -}}
enabled: true
data:
  ROCKET_PORT: "8080"
  SIGNUPS_ALLOWED: {{ .Values.vaultwarden.allowSignups | quote }}
  {{- if .Values.vaultwarden.signupDomains }}
  SIGNUPS_DOMAINS_WHITELIST: {{ join "," .Values.vaultwarden.signupDomains | quote }}
  {{- end }}
  {{- if and (eq .Values.vaultwarden.verifySignup true) (eq .Values.vaultwarden.smtp.enabled false) }}{{ required "Signup verification requires SMTP to be enabled" nil}}{{end}}
  SIGNUPS_VERIFY: {{ .Values.vaultwarden.verifySignup | quote }}
  {{- if and (eq .Values.vaultwarden.requireEmail true) (eq .Values.vaultwarden.smtp.enabled false) }}{{ required "Requiring emails for login depends on SMTP" nil}}{{end}}
  REQUIRE_DEVICE_EMAIL: {{ .Values.vaultwarden.requireEmail | quote }}
  {{- if .Values.vaultwarden.emailAttempts }}
  EMAIL_ATTEMPTS_LIMIT: {{ .Values.vaultwarden.emailAttempts | quote }}
  {{- end }}
  {{- if .Values.vaultwarden.emailTokenExpiration }}
  EMAIL_EXPIRATION_TIME: {{ .Values.vaultwarden.emailTokenExpiration | quote }}
  {{- end }}
  INVITATIONS_ALLOWED: {{ .Values.vaultwarden.allowInvitation | quote }}
  {{- if .Values.vaultwarden.defaultInviteName }}
  INVITATION_ORG_NAME: {{ .Values.vaultwarden.defaultInviteName | quote }}
  {{- end }}
  SHOW_PASSWORD_HINT: {{ .Values.vaultwarden.showPasswordHint | quote }}
  WEB_VAULT_ENABLED: {{ .Values.vaultwarden.enableWebVault | quote }}
  ORG_CREATION_USERS: {{ .Values.vaultwarden.orgCreationUsers | quote }}
  {{- if .Values.vaultwarden.attachmentLimitOrg }}
  ORG_ATTACHMENT_LIMIT: {{ .Values.vaultwarden.attachmentLimitOrg | quote }}
  {{- end }}
  {{- if .Values.vaultwarden.attachmentLimitUser }}
  USER_ATTACHMENT_LIMIT: {{ .Values.vaultwarden.attachmentLimitUser | quote }}
  {{- end }}
  {{- if .Values.vaultwarden.hibpApiKey }}
  HIBP_API_KEY: {{ .Values.vaultwarden.hibpApiKey | quote }}
  {{- end }}
  {{- include "vaultwarden.dbTypeValid" . }}
  {{- if .Values.database.retries }}
  DB_CONNECTION_RETRIES: {{ .Values.database.retries | quote }}
  {{- end }}
  {{- if .Values.database.maxConnections }}
  DATABASE_MAX_CONNS: {{ .Values.database.maxConnections | quote }}
  {{- end }}
  {{- if eq .Values.vaultwarden.smtp.enabled true }}
  SMTP_HOST: {{ required "SMTP host is required to enable SMTP" .Values.vaultwarden.smtp.host | quote }}
  SMTP_FROM: {{ required "SMTP sender address ('from') is required to enable SMTP" .Values.vaultwarden.smtp.from | quote }}
  {{- if .Values.vaultwarden.smtp.fromName }}
  SMTP_FROM_NAME: {{ .Values.vaultwarden.smtp.fromName | quote }}
  {{- end }}
  {{- if .Values.vaultwarden.smtp.security }}
  SMTP_SECURITY: {{ .Values.vaultwarden.smtp.security | quote }}
  {{- end }}
  {{- if .Values.vaultwarden.smtp.port }}
  SMTP_PORT: {{ .Values.vaultwarden.smtp.port | quote }}
  {{- end }}
  {{- if .Values.vaultwarden.smtp.authMechanism }}
  SMTP_AUTH_MECHANISM: {{ .Values.vaultwarden.smtp.authMechanism | quote }}
  {{- end }}
  {{- if .Values.vaultwarden.smtp.heloName }}
  HELO_NAME: {{ .Values.vaultwarden.smtp.heloName | quote }}
  {{- end }}
  {{- if .Values.vaultwarden.smtp.timeout }}
  SMTP_TIMEOUT: {{ .Values.vaultwarden.smtp.timeout | quote }}
  {{- end }}
  {{- if .Values.vaultwarden.smtp.invalidHostname }}
  SMTP_ACCEPT_INVALID_HOSTNAMES: {{ .Values.vaultwarden.smtp.invalidHostname | quote }}
  {{- end }}
  {{- if .Values.vaultwarden.smtp.invalidCertificate }}
  SMTP_ACCEPT_INVALID_CERTS: {{ .Values.vaultwarden.smtp.invalidCertificate | quote }}
  {{- end }}
  {{- end }}
  {{- if .Values.vaultwarden.log.file }}
  LOG_FILE: {{ .Values.vaultwarden.log.file | quote }}
  {{- end }}
  {{- if or .Values.vaultwarden.log.level .Values.vaultwarden.log.timeFormat }}
  EXTENDED_LOGGING: "true"
  {{- end }}
  {{- if .Values.vaultwarden.log.level }}
  {{- include "vaultwarden.logLevelValid" . }}
  LOG_LEVEL: {{ .Values.vaultwarden.log.level | quote }}
  {{- end }}
  {{- if .Values.vaultwarden.log.timeFormat }}
  LOG_TIMESTAMP_FORMAT: {{ .Values.vaultwarden.log.timeFormat | quote }}
  {{- end }}
  {{- if .Values.vaultwarden.icons.disableDownload }}
  DISABLE_ICON_DOWNLOAD: {{ .Values.vaultwarden.icons.disableDownload | quote }}
  {{- if and (not .Values.vaultwarden.icons.cache) (eq .Values.vaultwarden.icons.disableDownload "true") }}
  ICON_CACHE_TTL: "0"
  {{- end }}
  {{- end }}
  {{- if .Values.vaultwarden.icons.cache }}
  ICON_CACHE_TTL: {{ .Values.vaultwarden.icons.cache | quote }}
  {{- end }}
  {{- if .Values.vaultwarden.icons.cacheFailed }}
  ICON_CACHE_NEGTTL: {{ .Values.vaultwarden.icons.cacheFailed | quote }}
  {{- end }}
  {{- if eq .Values.vaultwarden.admin.enabled true }}
  {{- if eq .Values.vaultwarden.admin.disableAdminToken true }}
  DISABLE_ADMIN_TOKEN: "true"
  {{- end }}
  {{- end }}
  {{- if eq .Values.vaultwarden.yubico.enabled true }}
  {{- if .Values.vaultwarden.yubico.server }}
  YUBICO_SERVER: {{ .Values.vaultwarden.yubico.server | quote }}
  {{- end }}
  {{- end }}
  {{- if eq .Values.database.type "sqlite" }}
  ENABLE_DB_WAL: {{ .Values.database.wal | quote }}
  {{- else }}
  ENABLE_DB_WAL: "false"
  {{- end }}
{{- end -}}
