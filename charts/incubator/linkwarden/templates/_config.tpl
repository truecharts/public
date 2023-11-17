{{/* Define the configmap */}}
{{- define "linkwarden.config" -}}

{{- $vAdd := .Values.linkwarden.additional }}
{{- $vAWS := .Values.linkwarden.aws }}
{{- $vSMT := .Values.linkwarden.smtp }}

enabled: true
data:
NEXTAUTH_SECRET=very_sensitive_secret
DATABASE_URL=postgresql://{{ .Values.cnpg.main.user }}:{{ .Values.cnpg.main.creds.password | trimAll "\"" }}@{{ .Values.cnpg.main.creds.host | trimAll "\"" }}:5432/{{ .Values.cnpg.main.database }}
NEXTAUTH_URL=http://localhost:3000

# Additional

PAGINATION_TAKE_COUNT=
STORAGE_FOLDER=
AUTOSCROLL_TIMEOUT=
NEXT_PUBLIC_DISABLE_REGISTRATION=
RE_ARCHIVE_LIMIT=

# AWS
SPACES_KEY=
SPACES_SECRET=
SPACES_ENDPOINT=
SPACES_REGION=

# SMTP
NEXT_PUBLIC_EMAIL_PROVIDER=
EMAIL_FROM=
EMAIL_SERVER=


{{- end -}}
