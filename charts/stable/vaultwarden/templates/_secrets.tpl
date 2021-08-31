{{/* Define the secrets */}}
{{- define "vaultwarden.secrets" -}}

{{- $adminToken := "" }}
{{- if eq .Values.vaultwarden.admin.enabled true }}
{{- $adminToken = .Values.vaultwarden.admin.token | default (randAlphaNum 48) | b64enc | quote }}
{{- end -}}

{{- $smtpUser := "" }}
{{- if and (eq .Values.vaultwarden.smtp.enabled true ) (.Values.vaultwarden.smtp.user) }}
{{- $smtpUser = .Values.vaultwarden.smtp.user | b64enc | quote }}
{{- end -}}

{{- $yubicoClientId := "" }}
{{- if eq .Values.vaultwarden.yubico.enabled true }}
{{- $yubicoClientId = required "Yubico Client ID required" .Values.vaultwarden.yubico.clientId | toString | b64enc | quote }}
{{- end -}}
---

apiVersion: v1
kind: Secret
metadata:
  name: {{ .Release.Name }}-vaultwardensecret
data:
  {{- if ne $adminToken "" }}
  ADMIN_TOKEN: {{ $adminToken }}
  {{- end }}
  {{- if ne $smtpUser "" }}
  SMTP_USERNAME: {{ $smtpUser }}
  SMTP_PASSWORD: {{ required "Must specify SMTP password" .Values.vaultwarden.smtp.password | b64enc | quote }}
  {{- end }}
  {{- if ne $yubicoClientId "" }}
  YUBICO_CLIENT_ID: {{ $yubicoClientId }}
  YUBICO_SECRET_KEY: {{ required "Yubico Secret Key required" .Values.vaultwarden.yubico.secretKey | b64enc | quote }}
  {{- end }}

---

apiVersion: v1
kind: Secret
metadata:
  labels:
    {{- include "common.labels" . | nindent 4 }}
  {{- $dbcredsname := ( printf "%v-%v"  .Release.Name "dbcreds" ) }}
  name: {{ $dbcredsname }}
data:
  {{- $dbPass := "" }}
  {{ $rootPass := "" }}
  {{ $urlPass := "" }}

  {{- if .Release.IsInstall }}
  {{ $dbPass = ( randAlphaNum 50 | b64enc | quote )  }}
  {{ $rootPass = ( randAlphaNum 50 | b64enc | quote )  }}
  {{ $urlPass = $dbPass }}
  {{ else }}
  # `index` function is necessary because the property name contains a dash.
  # Otherwise (...).data.db_password would have worked too.
  {{ $dbPass = ( index (lookup "v1" "Secret" .Release.Namespace ( $dbcredsname | quote ) ).data "postgresql-postgres-password" ) }}
  {{ $rootPass = ( index (lookup "v1" "Secret" .Release.Namespace ( $dbcredsname | quote ) ).data "postgresql-postgres-password" ) }}
  {{ $urlPass = ( ( index (lookup "v1" "Secret" .Release.Namespace ( $dbcredsname | quote ) ).data "postgresql-postgres-password" ) | b64dec | quote ) }}
  {{ end }}

  postgresql-password: {{ $dbPass }}
  postgresql-postgres-password: {{ $rootPass }}
  url: {{ ( printf "%v%v:%v@%v-%v:%v/%v" "postgresql://" .Values.postgresql.postgresqlUsername $urlPass .Release.Name "postgresql" "5432" .Values.postgresql.postgresqlDatabase  ) | b64enc | quote }}
  postgresql_host: {{ ( printf "%v-%v" .Release.Name "postgresql" ) | b64enc | quote }}
type: Opaque
{{- end -}}
