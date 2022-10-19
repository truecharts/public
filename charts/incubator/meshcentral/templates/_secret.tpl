{{/* Define the secret */}}
{{- define "meshcentral.secret" -}}

{{- $secretName := printf "%s-secret" (include "tc.common.names.fullname" .) }}
{{- $mongoURL := printf "mongodb://%v:%v@%v" .Values.mongodb.mongodbUsername (.Values.mongodb.mongodbPassword | trimAll "\"") (.Values.mongodb.url.plainporthost | trimAll "\"") }}
{{- $config := .Values.meshcentral }}

{{- $sessionKey := "" }}
{{- with (lookup "v1" "Secret" .Release.Namespace $secretName) }}
{{- $sessionKey = (index .data "session_key") }}
{{- else }}
{{- $sessionKey = randAlphaNum 32 }}
{{- end }}

{{/* Inject some values */}}
{{- $_ := set $config "$schema" "http://info.meshcentral.com/downloads/meshcentral-config-schema.json" }}
{{- $_ := set $config "__comment__" "This file is generated dynamically at install time, do not attemp to modify it. On next start it will be re-generated" }}
{{- if not (hasKey $config "settings") }}
{{- $_ := set $config "settings" dict }}
{{- end }}
{{- $_ := set $config.settings "mongoDB" $mongoURL }}
{{- $_ := set $config.settings "mongoDbName" .Values.mongodb.mongodbDatabase }}
{{- $_ := set $config.settings "sessionKey" $sessionKey }}
{{- $_ := set $config.settings "port" .Values.service.main.ports.main.port }}

{{/* Force disable some functions that are not appliable in docker */}}
{{- $_ := set $config.settings "selfUpdate" false }}
{{- $_ := set $config.settings "cleanNpmCacheOnUpdate" false }}

---

apiVersion: v1
kind: Secret
type: Opaque
metadata:
  name: {{ $secretName }}
  labels:
    {{- include "tc.common.labels" . | nindent 4 }}
data:
  session_key: {{ $sessionKey | b64enc }}
  config.json: |
{{- toPrettyJson $config | b64enc | nindent 4 }}
{{- end }}
