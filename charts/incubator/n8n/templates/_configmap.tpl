{{/* Define the configmap */}}
{{- define "n8n.configmap" -}}
---
apiVersion: v1
kind: ConfigMap
metadata:
  name: n8n-config
data:
  {{/*  Workflows */}}
  {{- if .Values.workflows.WORKFLOWS_DEFAULT_NAME }}
  WORKFLOWS_DEFAULT_NAME: {{ .Values.workflows.WORKFLOWS_DEFAULT_NAME | quote }}
  {{- end }}
  {{/*  Security */}}
  {{- if .Values.security.N8N_BASIC_AUTH_ACTIVE }}
  N8N_BASIC_AUTH_ACTIVE: {{ .Values.security.N8N_BASIC_AUTH_ACTIVE | quote }}
  {{- end }}
  {{- if .Values.security.N8N_BASIC_AUTH_USER }}
  N8N_BASIC_AUTH_USER: {{ .Values.security.N8N_BASIC_AUTH_USER | quote }}
  {{- end }}
  {{- if .Values.security.N8N_BASIC_AUTH_PASSWORD }}
  N8N_BASIC_AUTH_PASSWORD: {{ .Values.security.N8N_BASIC_AUTH_PASSWORD | quote }}
  {{- end }}
  {{- if .Values.security.N8N_BASIC_AUTH_HASH }}
  N8N_BASIC_AUTH_HASH: {{ .Values.security.N8N_BASIC_AUTH_HASH | quote }}
  {{- end }}
  {{- if .Values.security.N8N_JWT_AUTH_ACTIVE }}
  N8N_JWT_AUTH_ACTIVE: {{ .Values.security.N8N_JWT_AUTH_ACTIVE | quote }}
  {{- end }}
  {{- if .Values.security.N8N_JWT_AUTH_HEADER }}
  N8N_JWT_AUTH_HEADER: {{ .Values.security.N8N_JWT_AUTH_HEADER | quote }}
  {{- end }}
  {{- if .Values.security.N8N_JWT_AUTH_HEADER_VALUE_PREFIX }}
  N8N_JWT_AUTH_HEADER_VALUE_PREFIX: {{ .Values.security.N8N_JWT_AUTH_HEADER_VALUE_PREFIX | quote }}
  {{- end }}
  {{- if .Values.security.N8N_JWKS_URI }}
  N8N_JWKS_URI: {{ .Values.security.N8N_JWKS_URI | quote }}
  {{- end }}
  {{- if .Values.security.N8N_JWT_ISSUER }}
  N8N_JWT_ISSUER: {{ .Values.security.N8N_JWT_ISSUER | quote }}
  {{- end }}
  {{- if .Values.security.N8N_JWT_NAMESPACE }}
  N8N_JWT_NAMESPACE: {{ .Values.security.N8N_JWT_NAMESPACE | quote }}
  {{- end }}
  {{- if .Values.security.N8N_JWT_ALLOWED_TENANT }}
  N8N_JWT_ALLOWED_TENANT: {{ .Values.security.N8N_JWT_ALLOWED_TENANT | quote }}
  {{- end }}
  {{- if .Values.security.N8N_JWT_ALLOWED_TENANT_KEY }}
  N8N_JWT_ALLOWED_TENANT_KEY: {{ .Values.security.N8N_JWT_ALLOWED_TENANT_KEY | quote }}
  {{- end }}
  {{/*  Logs */}}
  {{- if .Values.logs.N8N_LOG_LEVEL }}
  N8N_LOG_LEVEL: {{ .Values.logs.N8N_LOG_LEVEL | quote }}
  {{- end }}
  {{- if .Values.logs.N8N_LOG_OUTPUT }}
  N8N_LOG_OUTPUT: {{ .Values.logs.N8N_LOG_OUTPUT | quote }}
  {{- end }}
  {{- if .Values.logs.N8N_LOG_FILE_COUNT_MAX }}
  N8N_LOG_FILE_COUNT_MAX: {{ .Values.logs.N8N_LOG_FILE_COUNT_MAX }}
  {{- end }}
  {{- if .Values.logs.N8N_LOG_FILE_SIZE_MAX }}
  N8N_LOG_FILE_SIZE_MAX: {{ .Values.logs.N8N_LOG_FILE_SIZE_MAX }}
  {{- end }}
  {{- if .Values.logs.N8N_LOG_FILE_LOCATION }}
  N8N_LOG_FILE_LOCATION: {{ .Values.logs.N8N_LOG_FILE_LOCATION | quote }}
  {{- end }}
{{- end -}}
