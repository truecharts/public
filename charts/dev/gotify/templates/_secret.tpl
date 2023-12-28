{{/* Define the secret */}}
{{- define "gotify.secret" -}}

{{- $secretName := printf "%s-secret" (include "tc.v1.common.names.fullname" .) }}
{{- $secretEnvName := printf "%s-secret-env" (include "tc.v1.common.names.fullname" .) }}

{{- $url := (.Values.cnpg.main.url.plain | trimAll "\"") }}
{{- $password := (.Values.cnpg.main.creds.password | trimAll "\"") }}
{{- $dbuser := .Values.cnpg.main.user }}
{{- $dbname := .Values.cnpg.main.database }}
{{- $port := .Values.service.main.ports.main.port }}
---
apiVersion: v1
kind: Secret
metadata:
  name: {{ $secretEnvName }}
  labels:

data: {{/* Env takes precedence, and it;s defined in Dockerfile as 80 */}}
  GOTIFY_SERVER_PORT: {{ $port | quote }}
---
apiVersion: v1
kind: Secret
metadata:
  name: {{ $secretName }}
  labels:

data:
  config.yml: |
    server:
      listenaddr: ""
      keepaliveperiodseconds: {{ .Values.gotify.keep_alive_period_seconds }}
      port: {{ $port }}
      {{- with .Values.gotify.response_headers }}
      responseheaders:
        {{- range $item := . }}
        {{ $item.key }}: {{ $item.value | quote }}
        {{- end }}
      {{- end }}
      ssl:
        enabled: false
      stream:
        pingperiodseconds: {{ .Values.gotify.stream.ping_period_seconds }}
        {{- with .Values.gotify.stream.allowed_origins }}
        allowedorigins:
          {{- range $item := . }}
          - {{ $item | quote }}
          {{- end }}
        {{- end }}
      {{- if or .Values.gotify.cors.allowed_origins .Values.gotify.cors.allowed_methods .Values.gotify.cors.allowed_headers }}
      cors:
        {{- with .Values.gotify.cors.allowed_origins }}
        alloworigins:
          {{- range $item := . }}
          - {{ $item | quote }}
          {{- end }}
        {{- end }}
        {{- with .Values.gotify.cors.allowed_methods }}
        allowmethods:
          {{- range $item := . }}
          - {{ $item | quote }}
          {{- end }}
        {{- end }}
        {{- with .Values.gotify.cors.allowed_headers }}
        allowheaders:
          {{- range $item := . }}
          - {{ $item | quote }}
          {{- end }}
        {{- end }}
      {{- end }}
    database:
      dialect: postgres
      connection: {{ printf "host=%s port=5432 user=%s dbname=%s password=%s sslmode=disable" $url $dbuser $dbname $password }}
    uploadedimagesdir: {{ printf "%s/images" .Values.persistence.data.mountPath }}
    {{- if .Values.gotify.plugins_enabled }}
    pluginsdir: {{ printf "%s/plugins" .Values.persistence.data.mountPath }}
    {{- end }}
    defaultuser:
      name: {{ .Values.gotify.user }}
      pass: {{ .Values.gotify.pass }}
    passstrength: {{ .Values.gotify.password_strength }}
    registration: {{ .Values.gotify.registration }}
{{- end -}}
