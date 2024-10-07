{{/* Define the secrets */}}
{{- define "vaultwarden.secrets" -}}

{{- $adminToken := "" }}
{{- if eq .Values.vaultwarden.admin.enabled true }}
{{- $adminToken = .Values.vaultwarden.admin.token | default (randAlphaNum 48) | quote }}
{{- end -}}

{{- $smtpUser := "" }}
{{- if and (eq .Values.vaultwarden.smtp.enabled true ) (.Values.vaultwarden.smtp.user) }}
{{- $smtpUser = .Values.vaultwarden.smtp.user | quote }}
{{- end -}}

{{- $yubicoClientId := "" }}
{{- if eq .Values.vaultwarden.yubico.enabled true }}
{{- $yubicoClientId = required "Yubico Client ID required" .Values.vaultwarden.yubico.clientId | toString | quote }}
{{- end -}}
enabled: true
data:
  placeholder: placeholdervalue
  {{- if ne $adminToken "" }}
  ADMIN_TOKEN: {{ $adminToken }}
  {{- end }}
  {{- if ne $smtpUser "" }}
  SMTP_USERNAME: {{ $smtpUser }}
  SMTP_PASSWORD: {{ required "Must specify SMTP password" .Values.vaultwarden.smtp.password | quote }}
  {{- end }}
  {{- if ne $yubicoClientId "" }}
  YUBICO_CLIENT_ID: {{ $yubicoClientId }}
  YUBICO_SECRET_KEY: {{ required "Yubico Secret Key required" .Values.vaultwarden.yubico.secretKey | quote }}
  {{- end }}
  {{- if .Values.vaultwarden.push.enabled }}
  PUSH_ENABLED: {{ .Values.vaultwarden.push.enabled | quote }}
  PUSH_INSTALLATION_ID: {{ required "Installation ID required" .Values.vaultwarden.push.installationId | quote }}
  PUSH_INSTALLATION_KEY: {{ required "Installation Key required" .Values.vaultwarden.push.installationKey | quote }}
  {{- end }}
{{- end -}}
